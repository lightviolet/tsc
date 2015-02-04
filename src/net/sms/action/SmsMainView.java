package net.sms.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.action.Action;
import net.member.action.ActionForward;
import net.member.db.MemberBean;
import net.sms.db.SmsDAO;
/*
 * 로그인후 메인화면
 */
public class SmsMainView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberBean bean = (MemberBean)session.getAttribute("Member");
		
		SmsDAO dao = new SmsDAO();
		int failCount = dao.getSendFailCount(bean.getId());
		int successCount = dao.getSendSuccessCount(bean.getId());
		
		request.setAttribute("failCount", failCount);
		request.setAttribute("successCount", successCount);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("tsc/main.jsp");
		
		return forward;
	}

}