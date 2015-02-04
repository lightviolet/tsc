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
import net.sms.db.SmsSendInfoBean;
/*
 * SMS 발송에 대한 정보를 받아서 인설트
 */
public class SmsSendAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("SMS발송페이지에서 넘어옴");
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");

		String toList = request.getParameter("list");
		String fromNumber = request.getParameter("from_number");
		String message = request.getParameter("message");
		SmsDAO dao = new SmsDAO();
		ArrayList<SmsReportInfoBean> reportList = new ArrayList<SmsReportInfoBean>();

		String[] toNumber = toList.split("/");

		MemberBean currentMember = (MemberBean) session.getAttribute("Member");
		
		SmsSendInfoBean sendBean = new SmsSendInfoBean();
		sendBean.setId(currentMember.getId());
		sendBean.setFromNumber(fromNumber);
		sendBean.setMessage(message);
		sendBean.setSendTotal(toNumber.length);
		sendBean.setSendSuccess(0);
		sendBean.setSendFailure(0);
		
		boolean result = dao.setSendInfo(sendBean);
		if (result) {
			System.out.println("SendInfo인설트성공");
		} else {
			System.out.println("SendInfo인설트실패");
		}
		int seq = dao.getEtc();

		reportList = dao.insertMsgData(toNumber, fromNumber, currentMember.getId(), message, seq);
		
		result = dao.setReportInfo(reportList);
		if (result) {
			System.out.println("ReportInfo인설트성공");
		} else {
			System.out.println("ReportInfo인설트실패");
		}
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("/TSC/TscMainView.tsc");
		return forward;
	}

}