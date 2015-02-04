package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.db.MemberBean;
import net.member.db.MemberDAO;
/*
 * 회원정보수정
 */
public class MemberAlterAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("회원수정페이지에서 넘어옴");
		
		request.setCharacterEncoding("utf-8");
		//폼데이터 받기
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phonenumber = request.getParameter("phoneNumber");
		//받은 폼데이터 bean에 저장
		HttpSession session = request.getSession();
		MemberBean sessionBean = (MemberBean)session.getAttribute("Member");
		MemberBean bean = new MemberBean();
		bean.setId(sessionBean.getId());
		bean.setPassword(password);
		bean.setName(name);
		bean.setEmail(email);
		bean.setPhonenumber(phonenumber);
		System.out.println(password);
		//bean내용을 DB에 저장
		MemberDAO dao = new MemberDAO();

		boolean alterSuccess = dao.alterMember(bean);
		if (alterSuccess) {
			System.out.println("회원수정성공");
		} else {
			System.out.println("회원수정실패");
		}
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/SmsMainView.sms");
		
		return forward;
	}

}