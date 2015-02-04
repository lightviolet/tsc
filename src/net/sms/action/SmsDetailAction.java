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
 * 세부정보리스트
 */
public class SmsDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		
		HttpSession session = request.getSession();
		String etc = (String)session.getAttribute("etc");
		SmsDAO dao = new SmsDAO();
		//현재페이지와 페이지사이즈의 정보로 리스트가져오기
		ArrayList<SmsReportInfoBean> reportInfoList = new ArrayList<SmsReportInfoBean>();
		int pageSize = 4;
		int pageNo = Integer.valueOf(request.getParameter("pageno"));
		if(pageNo<1){
			pageNo=1;
		}
		reportInfoList = dao.getReportInfoList(etc, pageNo, pageSize);
		if(reportInfoList.size()==0){
			pageNo= pageNo-1;
			reportInfoList = dao.getReportInfoList(etc, pageNo, pageSize);
		}
		request.setAttribute("reportInfoList", reportInfoList);
		request.setAttribute("pageNo", pageNo);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("sms/detailSMS.jsp");
		
		return forward;
	}

}