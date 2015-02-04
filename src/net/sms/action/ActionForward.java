package net.sms.action;
/*
 * ActionFoward 객체
 */
public class ActionForward {
	boolean isRedirect;
	String path;
	
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
	
}
