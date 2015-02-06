package net.push.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.member.action.Action;
import net.member.action.ActionForward;
/*
 * 페이지이동(+보낸정보리스트 1페이지에 띄울 정보)
 */
public class PushReportView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("push/reportPush.jsp");
		
		return forward;
	}

}