package net.sms.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
 * ActionFoword 객체 행위작성 인터페이스(요청에 대한 응답작성)
 */
public interface Action {
	public ActionForward execute(
			HttpServletRequest request, 
			HttpServletResponse response) 
					throws Exception;
}
