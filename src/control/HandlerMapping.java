package control;

public class HandlerMapping {
	private static HandlerMapping hm=new HandlerMapping();
	private HandlerMapping(){}
	public static HandlerMapping getInstance(){
		return hm;
	}
	public Controller create(String command){
		Controller c=null;
		if(command.equals("allview")){
			c=new AllViewController();
		}else if(command.equals("login")){
			c=new LoginController();
		}else if(command.equals("home")){
			c=new HomeController();
		}/*else if(command.equals("gmail")){
			c=new GmailController();
		}else if(command.equals("naver")){
			c=new NaverController();
		}else if(command.equals("gmail")){
			c=new HotmailController();
		}else if(command.equals("hotmail")){
			c=new LoginController();
		}*/else if(command.equals("mailview")){
			c=new MailViewController();
		}
		return c;
	}
}

