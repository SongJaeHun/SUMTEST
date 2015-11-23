package mail;

public class AddAccInfo {
	private String[] mails;
	private String[] sites;
	private String[] pwds;
	
	public AddAccInfo(String[] mails , String[] sites , String[] pwds){
		this.mails = mails;
		this.sites = sites;
		this.pwds = pwds;
	}

	public String[] getMails() {
		return mails;
	}

	public String[] getSites() {
		return sites;
	}

	public String[] getPwds() {
		return pwds;
	}
	
	
}
