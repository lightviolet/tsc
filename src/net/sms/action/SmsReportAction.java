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
 * 보낸정보리스트
 */
public class SmsReportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		//현재페이지와 페이지크기에 맞춰서 리스트 가져오기
		SmsDAO dao = new SmsDAO();
		ArrayList<SmsSendInfoBean> sendList = new ArrayList<SmsSendInfoBean>();
		HttpSession session = request.getSession();
		MemberBean bean = (MemberBean)session.getAttribute("Member");
		int pageNo = Integer.valueOf(request.getParameter("pageno"));
		int pageSize = 5;

		if(pageNo<1){
			pageNo=1;
		}
		sendList = dao.getSendInfoList(bean.getId(), pageNo, pageSize);
		if(sendList.size()==0){
			pageNo= pageNo-1;
			sendList = dao.getSendInfoList(bean.getId(), pageNo, pageSize);
		}

		request.setAttribute("pageNo", pageNo);
		request.setAttribute("sendList", sendList);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("sms/reportSMS.jsp");
		
		return forward;
	}

}