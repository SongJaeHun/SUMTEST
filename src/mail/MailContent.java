package mail;

public class MailContent {
	int acc_id;		//	db
	String subject;	//	msg.getSubject();
	String sender;	//	getSender
	String receivedDate ; // msg.getReceivedDate()

	public String getReceivedDate() {
		return receivedDate;
	}

	String mainHtmlPath ; //filePath + fileName + "-1.html";
	String contentImgPath ;
	String attachmentPath;

	public MailContent(int acc_id, String subject, String sender , String receivedDate) {
		super();
		this.acc_id = acc_id;
		this.subject = subject;
		this.sender = sender;
		this.receivedDate = receivedDate;
	}
	
	public int getAcc_id() {
		return acc_id;
	}


	public String getSubject() {
		return subject;
	}

	public String getSender() {
		return sender;
	}

	public String getMainHtmlPath() {
		return mainHtmlPath;
	}

	public void setMainHtmlPath(String mainHtmlPath) {
		this.mainHtmlPath = mainHtmlPath;
	}

	public String getContentImgPath() {
		return contentImgPath;
	}

	public void setContentImgPath(String contentImgPath) {
		this.contentImgPath = contentImgPath;
	}

	public String getAttachmentPath() {
		return attachmentPath;
	}

	public void setAttachmentPath(String attachmentPath) {
		this.attachmentPath = attachmentPath;
	}


}
