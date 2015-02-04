package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.db.LoginManager;
import net.member.db.MemberBean;
/*
 * 로그아웃
 */
public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		//Login유저에 관한 클래스에서 현id정보삭제, 세션초기화
		LoginManager loginManager = LoginManager.getInstance();

		loginManager.logoutSession(session, ((MemberBean)session.getAttribute("Member")).getId());
		session.invalidate();
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("index.jsp");

		return forward;
	}

}