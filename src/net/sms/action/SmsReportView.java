package net.sms.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.member.action.Action;
import net.member.action.ActionForward;
import net.member.db.MemberBean;
import net.sms.db.SmsDAO;
import net.sms.db.SmsSendInfoBean;
/*
 * 페이지이동(+보낸정보리스트 1페이지에 띄울 정보)
 */
public class SmsReportView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//1페이지에 띄울 사이즈를 바탕으로 리스트가져오기
		SmsDAO dao = new SmsDAO();
		ArrayList<SmsSendInfoBean> sendList = new ArrayList<SmsSendInfoBean>();
		HttpSession session = request.getSession();
		MemberBean bean = (MemberBean)session.getAttribute("Member");
		sendList = dao.getSendInfoList(bean.getId(),1,5);
		
		int totalSendCount = dao.getSendCount(bean.getId());
		request.setAttribute("sendList", sendList);
		request.setAttribute("pageNo", 1);
		session.setAttribute("totalSendCount", totalSendCount);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("sms/reportSMS.jsp");
		
		return forward;
	}

}