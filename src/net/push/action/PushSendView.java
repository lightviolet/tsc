package net.push.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.member.action.Action;
import net.member.action.ActionForward;
/*
 * 페이지이동
 */
public class PushSendView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("push/sendPush.jsp");
		
		return forward;
	}

}