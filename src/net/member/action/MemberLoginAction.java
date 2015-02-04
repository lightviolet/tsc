package net.member.action;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.db.LoginManager;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;
/*
 * 로그인
 */
public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("로그인페이지에서 넘어옴");
		
		request.setCharacterEncoding("utf-8");
		//폼데이터 받기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String save_id = request.getParameter("save_id");
		System.out.println(id+"/"+password);
		MemberDAO dao = new MemberDAO();
		MemberBean bean = new MemberBean();
		//아이디저장을 누르지않았다면 이전 쿠키삭제
		if(save_id == null){
			System.out.println("쿠키삭제");
			Cookie[] cookies = request.getCookies();
			for(int i=0; i<cookies.length; i++){
				if(cookies[i].getName().equals("cookieId")){
					cookies[i].setValue("");
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
			}
		}else if(save_id.equals("save")){//아이디저장을 눌럿다면 쿠키등록
			System.out.println("쿠키생성");
			Cookie saveCookie = new Cookie("cookieId", id);
			saveCookie.setMaxAge(30*24*60*60);//한달!
			response.addCookie(saveCookie);
		}
		HttpSession session = request.getSession();
		
		// DAO 작업
		LoginManager loginManager = LoginManager.getInstance();
		boolean loginCheck = dao.loginCheck(id, password);
		boolean idCheck = dao.idCheck(id);
		//로그인중이지않고 ID/PASSWORD일치하다면
		if(loginCheck && !loginManager.isUsing(id)){
			System.out.println(id+"님 로그인성공");
			loginManager.setSession(session, id);
			bean = dao.getMember(id);
			session.setAttribute("Member", bean);
			
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("/TscMainView.tsc");

			return forward;
		}else if(loginManager.isUsing(id) && idCheck){//아이디가 로그인중이라면
			request.setAttribute("msg", 3);
			request.setAttribute("useID", id);
	    }else if(!idCheck){
			request.setAttribute("msg", 1);//아이디가 없다면
	    }else if(idCheck){
	    	request.setAttribute("msg", 2);//아이디는 있는데 로그인이 안된다면 PASSWORD불일치
	    }
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("member/memberLoginForm.jsp");
		return forward;
	}

}