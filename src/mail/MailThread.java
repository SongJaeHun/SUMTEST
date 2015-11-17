package mail;

public class MailThread extends Thread {

	Mail mail ;
	
	public MailThread(Mail m){
		mail = m;
	}
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			mail.doit();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
