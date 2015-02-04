package net.sms.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.action.Action;
import net.member.action.ActionForward;
import net.member.db.MemberBean;
import net.sms.db.SmsDAO;
import net.sms.db.SmsReportInfoBean;
/*
 * 페이지이동(세부정보리스트 첫페이지에 띄울 정보보내기)
 */
public class SmsDetailView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String etc = request.getParameter("etc");
		HttpSession session = request.getSession();
		MemberBean memberBean = (MemberBean)session.getAttribute("Member");
		
		SmsDAO dao = new SmsDAO();
		//1페이지에 사이즈4개의 리스트가져오기
		ArrayList<SmsReportInfoBean> reportInfoList = new ArrayList<SmsReportInfoBean>();
		reportInfoList = dao.getReportInfoList(etc,1,4);
		
		request.setAttribute("reportInfoList", reportInfoList);
		//차트를 위한 AllCount와 성공Count/실패Count
		int totalFailCount = dao.getFailCount(etc);
		int totalSuccesCount = dao.getSuccessCount(etc);
		int totalTotalCount = dao.getTotalCount(etc);
		
		session.setAttribute("totalFailCount", totalFailCount);
		session.setAttribute("totalSuccessCount", totalSuccesCount);
		session.setAttribute("totalTotalCount", totalTotalCount);
		session.setAttribute("etc", etc);
		
		request.setAttribute("pageNo", 1);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("sms/detailSMS.jsp");
		
		return forward;
	}

}