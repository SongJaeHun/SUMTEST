package mail;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.AuthenticationFailedException;
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

import model.BoardService;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.sun.mail.imap.IMAPStore;
import com.sun.mail.util.MailSSLSocketFactory;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;



public class NaverMail implements Mail{

    private  long previousUID =1 ;
    
    private  int number =1 ;
    	
    private  int temp = 1  ;
    
    private  ArrayList<String> str  ;
    
    private String filePath;
    private String accountAddr;
    private String accountPwd;
    private int accountId;
    
    private MailContent mail ;
    
    private String contentImgPath;
    private String attachmentPath;
    
    private Date lastReceivedDate ;
    //private 
    
    private BoardService service = BoardService.getInstance();
 
    BASE64Encoder base64Encoder = new BASE64Encoder();
    BASE64Decoder base64Decoder = new BASE64Decoder();
    
    public NaverMail(int accId , String accAddr , String accPwd , String file_Path) throws Exception {
    	accountId = accId;
    	accountAddr = accAddr ;
    	accountPwd = accPwd;
    	filePath = file_Path ;
    	lastReceivedDate = service.getLastReceivedDate(accountId);
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
        //    mails = new MailContent[messages.length - 1]();
            System.out.println(messages.length);
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            // acc_id 를 디비에 질의해서 가장 receivedDate 가 마지막인거 찾기
            int compare = 1;
            
            if( lastReceivedDate == null) {
            	lastReceivedDate = new Date(messages[messages.length - 1].getReceivedDate().getTime());
            }
            
            
            
            for (int i = messages.length - 1 ; i  >= 0  ; i--) {
                Message msg = messages[i];
                
                compare = lastReceivedDate.compareTo(msg.getReceivedDate()); // 메일 없을때 0
         
                // lastReceivedDate 가 더 나중이면 1 return 같으면 0 return 빠르면 -1
                if(i == messages.length - 1){
                	
                	boolean existFlag = service.getExistFlag(accountId);
                	
                	if(existFlag){
                		
                	}else{
                		compare = 1;
                		System.out.println("메일 없을때 1번만 실행되야함 ~~");
                	}
                }
                
                if(compare != 1){
                	break;
                }
                
                contentImgPath = "";
                attachmentPath = "";
                mail = new MailContent(accountId , getSubject(msg.getSubject()) , getSender(msg) , format.parse(format.format(msg.getReceivedDate())));;
                Object getContent = msg.getContent();
                Multipart mp = null;
                
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
                //여기서 저장후에 htmlPath WebContent 제거 후 다시 저장
               
                int startIndex = mail.getMainHtmlPath().indexOf("Web") ;
               String path = mail.getMainHtmlPath().substring(0 , startIndex);
               int lastIndex = startIndex + 12;
              
               path = path + mail.getMainHtmlPath().substring(lastIndex , mail.getMainHtmlPath().length());
               path = path.replace("c:\\\\web\\\\", "http://localhost:9090\\\\").replace("\\\\", "/"); 
               
               // localhost:9090/SUMTEST/temp/ 등으로 바꿔야할듯
               
                mail.setMainHtmlPath(path);
                mail.setContentImgPath(contentImgPath);
                mail.setAttachmentPath(attachmentPath);
                
                service.registContent(mail);

            }
            
            // DELETEFLAG업데이트  accountId 전달하여 메서드 실행
            service.updateDeleteFlag(accountId);
            
        }catch(AuthenticationFailedException e){
        	//존재하지 않는 아이디 혹인 비밀번호 즉 걸려있는 계정으로 메일 못받을시
        	//여기 걸려있는 애들도 DELETEFLAG1로 설정해주기
        	  service.updateDeleteFlag(accountId);
        	System.out.println("계정 오류");
        	
        } finally{
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
 	             if(cid.contains("cid")){
 	                 num_Of_Content_Img++;
 	                 //이 시점에서 ContentImgPath 에 추가해주면 될듯.
 	             }
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
 	                 contentImgPath += filePath + num_Of_Content_Img + str.get(i - 1) + " ; ";
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
 	        	  if(writer != null)
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
    
    public String getSubject(String subject) throws IOException{
    	String title = subject;
    	if(title.equals(""))
    	{
    		return "제목없음";
    	}
    	
    	if(title.startsWith("\"")){
    		int firstIndex = title.indexOf("B?");
        	int lastIndex = title.lastIndexOf("?");
        	String temp = title.substring(firstIndex + 2 , lastIndex);
    		temp = new String(base64Decoder.decodeBuffer(temp));
    		return temp;
    	}
    	return title;
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
        	from = from.substring(index+1 , from.length()-1);
        }
        
        if(from.contains("facebook")){
        	from = "Facebook";
        }
        
        if(from.contains("\""))
        {
        	from = from.replaceAll("\"", "");
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
            mail.setMainHtmlPath(filePath + fileName + "-1.html");
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
        BASE64Decoder base64Decoder = new BASE64Decoder();
        try {		//첨부파일 html 인지 메일 html 인지 구분해줘야해...
        	if (part.isMimeType("text/html")) {
        		if(number != 2 ){
        			fileName = fileName+ "-" +  numOfAttachment + ".html";
        			fileFullPath = filePath + fileName;    
        		}else{
        			return;
        		}
        	} else {
        		String x = part.getDataHandler().getName();
        		if(x == null){
        			
        		}
        		else{
        			if(x.contains("UTF")){
        				int firstIndex = x.indexOf("B?");
        				int lastIndex = x.lastIndexOf("?");
        				String c = x.substring(firstIndex + 2 , lastIndex);
        				c = new String(base64Decoder.decodeBuffer(c));
        				x = c;
        			}
        		}
        		fileName = fileName + "-" + numOfAttachment + x;

        		if (part.isMimeType("text/plain")) {
        			if(number != 2){}
        		//		fileName = fileName+ "-" + numOfAttachment  + ".txt";
        			else{
        				number --;
        				return;
        			}
        				
                 } 
                 
                 else if(part.isMimeType("image/jpeg")){
              //  	 fileName = fileName+ "-" + numOfAttachment + ".jpg" ;    
                	 if(temp != 0){
                		 str.add(".jpg");
                	 }
                 }
         		
                 else if(part.isMimeType("image/gif")){
                //	 fileName = fileName + "-" + numOfAttachment + ".gif";
                  	 if(temp != 0){
                		 str.add(".gif");
                	 }
                 }
                 
                 else if(part.isMimeType("application/pdf")){
                //	 fileName = fileName+ "-" + numOfAttachment  + ".pdf";
                 }
                 
                 else if(part.isMimeType("application/octet-stream") || part.isMimeType("APPLICATION/HAANSOFTHWP") || part.isMimeType("application/x-hwp") ){
                //	 fileName = fileName+ "-" + numOfAttachment  + ".hwp";
                 }
                 
                 else if(part.isMimeType("application/excel") || part.isMimeType("application/vnd.ms-excel") ){
               // 	 fileName = fileName+ "-" + numOfAttachment  + ".xls";
                 }
                 
                 else if(part.isMimeType("application/powerpoint")){
               // 	 fileName = fileName+ "-" + numOfAttachment  + ".ppt";
                 }
                 
                 else if(part.isMimeType("application/zip")){
                //	 fileName = fileName+ "-" + numOfAttachment  + ".zip";
                 }
        		
                 else if(part.isMimeType("image/PNG")){
              //  	 fileName = fileName+ "-" + numOfAttachment  + ".PNG";
                  	 if(temp != 0){
                		 str.add(".PNG");
                	 }
                 }
        		
                 else if(part.isMimeType("application/x-zip-compressed")){
              //  	 fileName = fileName+ "-" + numOfAttachment  + ".zip";
                 }
                 //기타 확장자들 MimeType에 따라 걸러서 확장자 추가해주면 됨
                 
                 else {
            //         fileName = fileName + "-" + part.getDataHandler().getName();	
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
            
            int t = temp;
            
            if(numOfAttachment > 1){
            	//여기서 attachmentPath 에 추가해줘야 할듯..
            	if( t > 0){
            		t --;
            	}else{
            		attachmentPath += fileFullPath + " ; " ;
            	}
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
