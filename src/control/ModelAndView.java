package control;

public class ModelAndView {
	private boolean isRedirect=false;
	private String path="";
	
	public ModelAndView() {
		super();
	}

	public ModelAndView(boolean isRedirect, String path) {
		super();
		this.isRedirect = isRedirect;
		this.path = path;
	}

	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Override
	public String toString() {
		return "ModelAndView [isRedirect=" + isRedirect + ", path=" + path
				+ "]";
	}
	
}
