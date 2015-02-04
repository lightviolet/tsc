package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.member.db.MemberBean;
import net.member.db.MemberDAO;
/*
 * 회원가입
 */
public class MemberJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("회원가입페이지에서 넘어옴");
		
		request.setCharacterEncoding("utf-8");
		//폼데이터 받기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phonenumber = request.getParameter("phoneNumber");
		//받은 폼데이터 bean에 저장
		MemberBean bean = new MemberBean();

		bean.setId(id);
		bean.setPassword(password);
		bean.setName(name);
		bean.setEmail(email);
		bean.setPhonenumber(phonenumber);
		//bean내용을 DB에 저장
		MemberDAO dao = new MemberDAO();

		boolean joinSuccess = dao.setMember(bean);
		if (joinSuccess) {
			System.out.println("회원저장성공");
		} else {
			System.out.println("회원저장실패");
		}

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("member/memberLoginForm.jsp");

		return forward;
	}

}