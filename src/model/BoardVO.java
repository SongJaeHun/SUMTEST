package model;

public class BoardVO {
	String user_id;
	String user_pwd;
	int mail_no;		//메일 번호
	int acc_id;		//내 계정 아이디
	String title;		//제목
	String recv_date;	//받은시간
	String recv_addr;	//보낸사람주소
	int mb_id;			//멤버아이디 = 내 계정아이디랑 연결
	String acc_addr;	//내계정 주소
	String acc_pwd;		//내계정 비밀전호
	String acc_site_name;//내가등록한사이트 이름 = acc_id(내계정아이디랑 연결)
	String user_name;
	String cf_email;
	
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getCf_email() {
		return cf_email;
	}
	public void setCf_email(String cf_email) {
		this.cf_email = cf_email;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public int getMail_no() {
		return mail_no;
	}
	public void setMail_no(int mail_no) {
		this.mail_no = mail_no;
	}
	public int getAcc_id() {
		return acc_id;
	}
	public void setAcc_id(int acc_id) {
		this.acc_id = acc_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRecv_date() {
		return recv_date;
	}
	public void setRecv_date(String recv_date) {
		this.recv_date = recv_date;
	}
	public String getRecv_addr() {
		return recv_addr;
	}
	public void setRecv_addr(String recv_addr) {
		this.recv_addr = recv_addr;
	}
	public int getMb_id() {
		return mb_id;
	}
	public void setMb_id(int mb_id) {
		this.mb_id = mb_id;
	}
	public String getAcc_addr() {
		return acc_addr;
	}
	public void setAcc_addr(String acc_addr) {
		this.acc_addr = acc_addr;
	}
	public String getAcc_pwd() {
		return acc_pwd;
	}
	public void setAcc_pwd(String acc_pwd) {
		this.acc_pwd = acc_pwd;
	}
	public String getAcc_site_name() {
		return acc_site_name;
	}
	public void setAcc_site_name(String acc_site_name) {
		this.acc_site_name = acc_site_name;
	}
	
	public BoardVO(String user_id, String user_pwd, String user_name, String cf_email) {
		super();
		this.user_id = user_id;
		this.user_pwd = user_pwd;
		this.user_name = user_name;
		this.cf_email = cf_email;
	}
	
	public BoardVO(String acc_addr,String acc_site_name, int mb_id) {
		super();
		this.acc_addr = acc_addr;
		this.acc_site_name = acc_site_name;
		this.mb_id = mb_id;
	}
	
	public BoardVO(String acc_addr,String acc_site_name ,String acc_pwd , int mb_id) {
		super();
		this.acc_addr = acc_addr;
		this.acc_site_name = acc_site_name;
		this.acc_pwd = acc_pwd;
		this.mb_id = mb_id;
	}
	
	
	public BoardVO(int mail_no, int acc_id ,String title, String recv_date, String recv_addr, int mb_id,
			String acc_addr, String acc_pwd, String acc_site_name) {
		super();
		this.mail_no = mail_no;
		this.acc_id = acc_id;
		this.title = title;
		this.recv_date = recv_date;
		this.recv_addr = recv_addr;
		this.mb_id = mb_id;
		this.acc_addr = acc_addr;
		this.acc_pwd = acc_pwd;
		this.acc_site_name = acc_site_name;
	}
	
	public BoardVO(int mail_no, String title, String recv_date, String recv_addr) {
		super();
		this.mail_no = mail_no;
		this.title = title;
		this.recv_date = recv_date;
		this.recv_addr = recv_addr;
	}
	public BoardVO(String user_id, String user_pwd) {
		this.user_id = user_id;
		this.user_pwd = user_pwd;
	}
	
	public BoardVO(String user_id){
		this.user_id = user_id;
	}
	public BoardVO(int acc_id, String acc_addr, String acc_site_name, String acc_pwd, int mb_id) {
		this.acc_id = acc_id;
		this.acc_addr = acc_addr;
		this.acc_site_name = acc_site_name;
		this.acc_pwd = acc_pwd;
		this.mb_id = mb_id;
	}
	
	public BoardVO(int acc_id, String acc_addr, String acc_site_name, String acc_pwd, int mb_id,String user_id) {
		this.acc_id = acc_id;
		this.acc_addr = acc_addr;
		this.acc_site_name = acc_site_name;
		this.acc_pwd = acc_pwd;
		this.mb_id = mb_id;
		this.user_id = user_id;
	}
	
	public BoardVO(){
		
	}
	
	@Override
	public String toString() {
		return "BoardVO [user_id=" + user_id + ", user_pwd=" + user_pwd
				+ ", mail_no=" + mail_no + ", acc_id=" + acc_id + ", title="
				+ title + ", recv_date=" + recv_date + ", recv_addr="
				+ recv_addr + ", mb_id=" + mb_id + ", acc_addr=" + acc_addr
				+ ", acc_pwd=" + acc_pwd + ", acc_site_name=" + acc_site_name
				+ "]";
	}


}
