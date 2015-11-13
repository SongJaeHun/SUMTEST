package mail;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
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

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.sun.mail.imap.IMAPStore;
import com.sun.mail.util.MailSSLSocketFactory;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;



public class HotmailMail {

    private  long previousUID = 1;
    
    private  int number = 1;
    
    private  int temp = 1;
    
    private String filePath;
    private String accountAddr;
    private String accountPwd;
    
    public HotmailMail(String accAddr , String accPwd , String file_Path) {
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
          //  props.setProperty("mail.imap.auth","false");
         //   props.setProperty("mail.imap.starttls.enable", "true");
          //  props.setProperty("mail.imap.ssl.checkserveridentity	", "true");
         //   props.setProperty("mail.imap.ssl.trust", "*");
          //  props.setProperty("mail.imap.ssl.trust", "imapserver");
           // props.setProperty("mail.debug.auth", "true");
            
            
            MailSSLSocketFactory socketFactory = new MailSSLSocketFactory();
            socketFactory.setTrustAllHosts(true);

            props.put("mail.imap.ssl.socketFactory",socketFactory);
        


            Session session = Session.getDefaultInstance(props,null);
            URLName urlName = new URLName("imap","imap-mail.outlook.com" ,
            												993, "" ,
            												accountAddr,accountPwd);

            store = new IMAPStore(session,urlName);
            store.connect();


            //Inbox라고 써있는 부분에 받아오고 싶은 메일 폴더 이름을 넣습니다. Inbox는 받은메일함 폴더를 의미합니다.
            folder = store.getFolder("Inbox");
            folder.open(Folder.READ_WRITE);
            UIDFolder uf = (UIDFolder) folder;	
            //읽지 않은 메일을 읽어오고 싶다면 이렇게 message를 받아오고
            //Message messages[] = folder.search(new FlagTerm(new Flags(Flags.Flag.SEEN), false));
            //특정 번호 사이의 메일을 받아오고 싶다면 getMessageByUID를 사용하면 됩니다. UIDFolder.LASTUID를 이용하면 해당 폴더의 마지막 메일 번호를 알아서 알려줍니다.
            Message messages[] = uf.getMessagesByUID(previousUID + 1, UIDFolder.LASTUID);
           // Message messages[] = folder.search(new FlagTerm(new Flags(Flags.Flag.SEEN) , false));
            System.out.println(messages.length);
            BASE64Encoder base64Encoder = new BASE64Encoder();
            BASE64Decoder base64Decoder = new BASE64Decoder();

            for (int i = messages.length - 1 ; i  >= 0  ; i--) {
                Message msg = messages[i];
                

/*                String sender = getSender(msg);
                String receivedDate = new SimpleDateFormat("yyyy년MM월dd일HH시mm분ss초").format(msg.getReceivedDate());
                String subject = msg.getSubject();*/
                
                Object getContent = msg.getContent();
                Multipart mp = null;
   
                if(getContent instanceof String)
                {

                	System.out.println("스트링 파트 : " + msg.getSubject());
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
                	
                	System.out.println("멀티파트 : " + msg.getSubject());               	
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
    				//link tag 속에도 charset 이 존재 할 수 있으니 replace 후에 태그를 무조건 추가해주기.
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
                 }
                 
                 else if(part.isMimeType("application/pdf")){
                	 fileName = fileName+ "-" + numOfAttachment  + ".pdf";
                 }
                 
                 else if(part.isMimeType("application/octet-stream")){
                	 fileName = fileName+ "-" + numOfAttachment  + ".hwp";
                 }
                 
                 else if(part.isMimeType("application/excel")){
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
                 }
                 //기타 확장자들 MimeType에 따라 걸러서 확장자 추가해주면 됨
                 
                 else {
                     fileName = fileName + "_" + part.getDataHandler().getName();		//part.getDataHandler().getName() 
                 }
                 fileFullPath = filePath + fileName;
             }
        	 
            String result = String.format("[%d]: fileName:%s \tfilePath:%s", uId, fileName, fileFullPath);

            System.out.println("... " + result);

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
