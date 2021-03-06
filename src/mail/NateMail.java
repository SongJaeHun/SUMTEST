package mail;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.UIDFolder;
import javax.mail.URLName;
import javax.mail.internet.MimeBodyPart;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.sun.mail.imap.IMAPStore;
import com.sun.mail.util.MailSSLSocketFactory;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;



public class NateMail implements Mail{

    private  long previousUID =1 ;
    
    private  int number =1 ;
    	
    private  int temp =1  ;
    
    private  ArrayList<String> str  ;
    
    private String filePath;
    private String accountAddr;
    private String accountPwd;
    private int accountId;
    public NateMail(int accId , String accAddr , String accPwd , String file_Path) throws Exception {
    	accountId = accId;
    	accountAddr = accAddr ;
    	accountPwd = accPwd;
    	filePath = file_Path ;
    }

    public  void doit() throws Exception {
        Folder folder = null;
        Store store = null;
        try {
            Properties props = System.getProperties();
            props.setProperty("mail.store.protocol", "imaps");
            props.setProperty("mail.imap.port", "993");
            props.setProperty("mail.imap.ssl.enable", "true");
            props.setProperty("mail.imap.fetchsize", "1024000");
            
            MailSSLSocketFactory socketFactory = new MailSSLSocketFactory();
            socketFactory.setTrustAllHosts(true);

            props.put("mail.imap.ssl.socketFactory",socketFactory);
        
            Session session = Session.getDefaultInstance(props,null);
            URLName urlName = new URLName("imap","imap.naver.com" ,
            												993, "" ,
            												accountAddr,accountPwd);
            store = new IMAPStore(session,urlName);
            store.connect();
            folder = store.getFolder("Inbox");
            folder.open(Folder.READ_WRITE);
            UIDFolder uf = (UIDFolder) folder;	
            Message messages[] = uf.getMessagesByUID(previousUID + 1, UIDFolder.LASTUID);
            System.out.println(messages.length);
            BASE64Encoder base64Encoder = new BASE64Encoder();
            BASE64Decoder base64Decoder = new BASE64Decoder();
            
            for (int i = messages.length - 1 ; i  >= 0  ; i--) {
                Message msg = messages[i];
                
                Object getContent = msg.getContent();
                Multipart mp = null;
                System.out.println(accountAddr + " : " +msg.getSubject());
                if(getContent instanceof String)
                {
                	String content = (String)getContent;
                    byte[] contents = content.getBytes("UTF-8");   
                    content = new String(contents,"UTF-8");
                    if(content.contains("charset")){
        				if(content.contains("euc-kr") || content.contains("EUC-KR")){
        					content = content.replaceAll("euc-kr", "utf-8").replaceAll("EUC-KR", "utf-8").replaceAll("<xmeta","<meta").replaceAll("<xxmeta", "<meta");
        				}

                    } else{
                    	content = addMetaTag(content);
                    }             
                    content = base64Encoder.encode(content.getBytes());
                    content = new String(base64Decoder.decodeBuffer(content));
                    
                    long uId = uf.getUID(msg);
                    String fileName = "" + System.currentTimeMillis();
                    saveParts(uId, content, fileName, filePath);
                    
                    content = null;
                    msg.setFlag(Flags.Flag.SEEN, false);

                }else if (getContent instanceof Multipart){ // multipart 인 경우
                	
                	mp = (Multipart)getContent;		 
                	
                	long uId = uf.getUID(msg);
                    String fileName = "" + System.currentTimeMillis();
                    saveParts(uId, mp , fileName, filePath);
                    
                    number = 1;
                    temp = number;
                    
                    msg.setFlag(Flags.Flag.SEEN, false);
                }
            }
        } finally {
            if (folder != null) {
                folder.close(true);
            }
            if (store != null) {
                store.close();
            }
        }
    }
    
    private  int contentImgCount(String htmlPath){	//cid 갯수 리턴
    	int num_Of_Content_Img = 0;
    	 File input = null;
    	 try{
    		 input = new File(htmlPath);
    		 Document doc = Jsoup.parse(input, "utf-8"); 
    		 Elements elements = doc.select("img");
	    
    		 for(Element e : elements) {     	 
 	             String cid = e.attr("src" );
 	             if(cid.contains("cid"))
 	                 num_Of_Content_Img++;
 	         }
    	 }catch(NullPointerException ne) {
 	         ne.printStackTrace();
 	      }
 	      catch(FileNotFoundException fe) {
 	         fe.printStackTrace();
 	      }
 	      catch(IOException ie) {
 	         ie.printStackTrace();
 	      }
    	return num_Of_Content_Img ;
    }

    private  void contentImgParsing(String htmlPath ){
 	   	  File input = null;
 	      FileWriter writer = null; 
 	      int num_Of_Content_Img = 1;
 	     
 	      try
 	      {
 	    	 int pathIndex = htmlPath.lastIndexOf("-");
 	    	 String path = htmlPath.substring(0,pathIndex) + "-1.html";
 	         input = new File(path);
 	         int index = path.indexOf("1.html");
 	         String filePath = path.substring(0,index);
 	         Document doc = Jsoup.parse(input, "utf-8"); 
 	         Elements elements = doc.select("img");
 	         
 	         int i = 0 ;
 	        
 	         for(Element e : elements) {
  	 
 	             String cid = e.attr("src" );
 	             if(cid.contains("cid")){
 	                 num_Of_Content_Img++;
 	                 e.attr("src", filePath + num_Of_Content_Img + str.get(i++));
 	             }
 	         }
 	         
 	         String temp = doc.toString();
 	         writer = new FileWriter(input); 
 	         writer.write(temp);
 	      }
 	      catch(NullPointerException ne) {
 	         ne.printStackTrace();
 	      }
 	      catch(FileNotFoundException fe) {
 	         fe.printStackTrace();
 	      }
 	      catch(IOException ie) {
 	         ie.printStackTrace();
 	      }
 	      
 	      finally {
 	          try {
 	             writer.close();
 	             System.gc();
 	             
 	          } catch (IOException e) {
 	             e.printStackTrace();
 	          }
 	       }
    
    }
    

    public  String multipartToString(Multipart mp) throws MessagingException, IOException{
    	
    	Multipart part = mp ;
    	BodyPart bp = null;
    	String temp = null;
       	for(int j = 0 ; j < part.getCount() ; j++){
    		bp = part.getBodyPart(j);
    	//	System.out.println(bp.getContentType().toString() + " zz");
    		if(bp.getContentType().contains("text") || bp.getContentType().contains("TEXT")){
    			temp = bp.getContent().toString();
    			if(temp.contains("charset")){
    				if(temp.contains("euc-kr") || temp.contains("EUC-KR")){
    					temp = temp.replaceAll("euc-kr", "utf-8").replaceAll("<xmeta","<meta").replaceAll("EUC-KR","utf-8").replaceAll("<xxmeta", "<meta");	
    				}else{
    					temp = addMetaTag(temp);
    				}
    			}else{
    				temp = addMetaTag(temp);
    			}
    		}
    	}
    	return temp;
    }
    
    public  String addMetaTag(String htmlCode){

    	StringBuffer strBuffer = new StringBuffer();
    	strBuffer = new StringBuffer(htmlCode);
    	strBuffer.insert(0, "<meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\">");
    	return strBuffer.toString();
    }
    
    public  String getSender(Message msg) throws MessagingException {
        String from = "unknown";
        if (msg.getReplyTo().length >= 1) {
            from = msg.getReplyTo()[0].toString();
        } else if (msg.getFrom().length >= 1) {
            from = msg.getFrom()[0].toString();
        }
        
        if(from.startsWith("=")){					// euc-kr or utf-8 일 경우 짤라서 sender 저장
        	int index = from.lastIndexOf("<");
        	from = from.substring(index , from.length());
        }
        
        return from;
    }
    	
    public  void saveParts(long uId, Object content, String fileName, String filePath)
            throws Exception {
        String tmpFileName = fileName;
        if (content instanceof Multipart) {
            Multipart multi = ((Multipart) content);				
           	String str = multipartToString(multi);
       	    if(str != null)
       	    {
       	    	saveParts(uId, str, fileName, filePath);	
       	    }	
            
            int parts = multi.getCount();

            for (int j = 0; j < parts; ++j) {	//첫번째 본문내용 넘기고나서 다음거 해야함...
                MimeBodyPart part = (MimeBodyPart) multi.getBodyPart(j);
                if (part.getContent() instanceof Multipart) {  	
                    saveParts(uId, part.getContent(), fileName, filePath );
                } else {
                    try {
                        saveSinglePart(uId, part, fileName, filePath , number++);
                    } catch (Exception e) {
                        e.printStackTrace();
                        try {
                        	 saveSinglePart(uId, part, fileName, filePath , number++);
                        } catch (Exception ex) {

                            ex.printStackTrace();
                            saveSinglePart(uId, part, fileName, filePath , number++);
                        }
                    }
                }
                fileName = tmpFileName;
            }
        } else {
            FileOutputStream output = new FileOutputStream(filePath + fileName+ "-1.html");		// String part 의 본문 html 
            output.write(content.toString().getBytes());
            output.close();
           temp = contentImgCount(filePath + fileName+ "-1.html");
            if(temp != 0){
            	str = new ArrayList<String>();
            }
        }
    }

    public  void saveSinglePart(long uId, MimeBodyPart part, String fileName, String filePath , int numOfAttachment)
            throws IOException, MessagingException, Base64DecodingException, InterruptedException {

        BufferedOutputStream out = null;
        BufferedInputStream in = null;
        String fileFullPath = "";
        try {		//첨부파일 html 인지 메일 html 인지 구분해줘야해...
        	if (part.isMimeType("text/html")) {
        		if(number != 2 ){
        			fileName = fileName+ "-" +  numOfAttachment + ".html";
        			fileFullPath = filePath + fileName;    
        		}else{
        			return;
        		}
        	} else {

        		if (part.isMimeType("text/plain")) {
        			if(number != 2)
        				fileName = fileName+ "-" + numOfAttachment  + ".txt";
        			else{
        				number --;
        				return;
        			}
        				
                 } 
                 
                 else if(part.isMimeType("image/jpeg")){
                	 fileName = fileName+ "-" + numOfAttachment + ".jpg" ;    
                	 if(str != null)
                		 str.add(".jpg");
                 }
         		
                 else if(part.isMimeType("image/gif")){
                	 fileName = fileName + "-" + numOfAttachment + ".gif";
                  	 if(str != null)
                		 str.add(".gif");
                 }
                 
                 else if(part.isMimeType("application/pdf")){
                	 fileName = fileName+ "-" + numOfAttachment  + ".pdf";
                 }
                 
                 else if(part.isMimeType("application/octet-stream") || part.isMimeType("APPLICATION/HAANSOFTHWP") || part.isMimeType("application/x-hwp") ){
                	 fileName = fileName+ "-" + numOfAttachment  + ".hwp";
                 }
                 
                 else if(part.isMimeType("application/excel") || part.isMimeType("application/vnd.ms-excel") ){
                	 fileName = fileName+ "-" + numOfAttachment  + ".xls";
                 }
                 
                 else if(part.isMimeType("application/powerpoint")){
                	 fileName = fileName+ "-" + numOfAttachment  + ".ppt";
                 }
                 
                 else if(part.isMimeType("application/zip")){
                	 fileName = fileName+ "-" + numOfAttachment  + ".zip";
                 }
        		
                 else if(part.isMimeType("image/PNG")){
                	 fileName = fileName+ "-" + numOfAttachment  + ".PNG";
                   	 if(str != null)
                		 str.add(".PNG");
                 }
        		
                 else if(part.isMimeType("application/x-zip-compressed")){
                	 fileName = fileName+ "-" + numOfAttachment  + ".zip";
                 }
                 //기타 확장자들 MimeType에 따라 걸러서 확장자 추가해주면 됨
                 
                 else {
                     fileName = fileName + "-" + part.getDataHandler().getName();	
                 }
                 fileFullPath = filePath + fileName;
             }

            try {
                Thread.sleep(1);
            } catch (Exception e) {
                e.printStackTrace();
            }
            out = new BufferedOutputStream(new FileOutputStream(new File(fileFullPath)));
            in = new BufferedInputStream(part.getInputStream());
            int k;
            while ((k = in.read()) != -1) {
                out.write(k);
            }
            
            if(temp == (numOfAttachment - 1)){
            	contentImgParsing(fileFullPath );
            }
            
            
            try {
                Thread.sleep(1);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.flush();
                out.close();
            }
        }
    }
}
