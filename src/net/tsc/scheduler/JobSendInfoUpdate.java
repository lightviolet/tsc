package net.tsc.scheduler;

import java.util.ArrayList;

import net.sms.db.SmsDAO;
import net.sms.db.SmsReportInfoBean;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class JobSendInfoUpdate implements Job {

	public void execute(JobExecutionContext context) throws JobExecutionException {
		// 이부분에 로직을 작성
		sendInfoUpdate();
	}

	public void sendInfoUpdate(){
		
		SmsDAO dao = new SmsDAO();
		//My 전용 데이터들을 no값들만 가져옴
		ArrayList<SmsReportInfoBean> list = new ArrayList<SmsReportInfoBean>();
		list = dao.selectAllReportInfo();
		//가져온값들 My 전용 디비에 저장
		if(dao.updateReportInfoList(list)){
			System.out.println("스케줄링 : 업데이트 성공");
		}else{
			System.out.println("스케줄링 : 업데이트 실패");
		}
		//보낸 성공카운트 / 실패카운트 업데이트
		ArrayList<String> etcList = new ArrayList<String>();
		etcList= dao.getSendEtcList();
		if(dao.setSendAllCount(etcList)){
			System.out.println("스케줄링 : 성공실패건수 삽입 성공");
		}else{
			System.out.println("스케줄링 : 성공실패건수 삽입 실패");
		}
	}

}
