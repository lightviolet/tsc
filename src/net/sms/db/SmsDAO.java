package net.sms.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import net.common.db.LocalDbUtil;
import net.common.db.SmsDbUtil;
/*
 * SMS관련 데이터접근 클래스
 */
public class SmsDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	////////////////////////////////////////LOCALDB//////////////////////////////////////////////
	/***************************************SELECT파트******************************************/
	//SEND_INFO테이블의 발송정보 갯수
	public int getSendCount(String id){
		int count = 0;
		try{
			String sql = "SELECT COUNT(*) as CNT FROM SMS_SEND_INFO WHERE MEM_ID=?";
			con = LocalDbUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt("CNT");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return count;
	}
	//pageNo와 pageSize정보를 바탕으로 pageSize만큼의 보낸 리스트 가져오기(페이징부분)
	public ArrayList<SmsSendInfoBean> getSendInfoList(String id, int pageNo, int pageSize){
		ArrayList<SmsSendInfoBean> list = new ArrayList<SmsSendInfoBean>();
		
		try{
			con = LocalDbUtil.getConnection();
			/*String sql = "SELECT * FROM ("
					+ " SELECT ROWNUM AS rnum, A.* FROM ("
					+ " SELECT * FROM SEND_INFO WHERE MEM_ID=? ORDER BY SEND_DATE DESC) A WHERE ROWNUM <= ?)"
					+ " WHERE RNUM >= ?";*/
			String sql = "select * "
					+ " from SMS_SEND_INFO "
					+ " where MEM_ID = ? "
					+ " order by SEND_DATE desc Limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, (pageNo-1)*pageSize);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				SmsSendInfoBean bean = new SmsSendInfoBean();
				bean.setFromNumber(rs.getString("FROM_NUMBER"));
				bean.setSendDate(rs.getTimestamp("SEND_DATE"));
				bean.setMessage(rs.getString("SMS_MESSAGE"));
				bean.setEtc(rs.getString("ETC"));
				bean.setSendTotal(rs.getInt("SEND_TOTAL"));
				bean.setSendSuccess(rs.getInt("SEND_SUCCESS"));
				bean.setSendFailure(rs.getInt("SEND_FAILURE"));
				list.add(bean);
			}
		}catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return list;
	}
	//전송실패개수
	public int getSendFailCount(String id){
		int count = 0;
		try{
			String sql = "SELECT COUNT(*) as CNT FROM SMS_SEND_INFO A, REPORT_INFO B WHERE A.ETC = B.ETC AND A.MEM_ID=? AND B.RESULT_CODE!='0'";
			con = LocalDbUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt("CNT");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(rs);
			LocalDbUtil.close(con);
		}
		return count;
	}
	//전송성공개수
	public int getSendSuccessCount(String id){
		int count = 0;
		try{
			String sql = "SELECT COUNT(*) as CNT FROM SMS_SEND_INFO A, REPORT_INFO B WHERE A.ETC = B.ETC AND A.MEM_ID=? AND B.RESULT_CODE='0'";
			con = LocalDbUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt("CNT");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(rs);
			LocalDbUtil.close(con);
		}
		return count;
	}
	//ETC정보를 바탕으로 해당결과리스트의 카운트값가져오기
	public int getFailCount(String etc){
		int count = 0;
		try{
			String sql = "SELECT COUNT(*) as CNT FROM SMS_REPORT_INFO WHERE ETC=? AND RESULT_CODE!='0'";
			con = LocalDbUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, etc);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt("CNT");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return count;
	}
	//해당 발송에 대한 총건수
	public int getTotalCount(String etc){
		int count = 0;
		try{
			String sql = "SELECT COUNT(*) as CNT FROM SMS_REPORT_INFO WHERE ETC=?";
			con = LocalDbUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, etc);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt("CNT");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return count;
	}
	//ETC조건으로 성공한 개수 가져오기
	public int getSuccessCount(String etc){
		int count = 0;
		try{
			String sql = "SELECT COUNT(*) as CNT FROM SMS_REPORT_INFO WHERE ETC=? AND RESULT_CODE='0'";
			con = LocalDbUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, etc);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt("CNT");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return count;
	}
	//ETC의 마지막번호 가져오기(MSG_ETC5의 고유키값을 추가하기 위함)
	public int getEtc(){
		int etc = 0;
		try{
			con = LocalDbUtil.getConnection();
			String sql = "SELECT MAX(CAST(ETC AS UNSIGNED)) as ETC FROM SMS_SEND_INFO";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				etc = rs.getInt("ETC");
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		
		return etc;
	}
	//ETC정보를 바탕으로 해당 결과리스트만 가져오기
	public ArrayList<SmsReportInfoBean> getReportInfoList(String etc){
		ArrayList<SmsReportInfoBean> list = new ArrayList<SmsReportInfoBean>();
		try{
			con = LocalDbUtil.getConnection();
			String sql = "SELECT * FROM SMS_REPORT_INFO WHERE ETC = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, etc);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				SmsReportInfoBean bean = new SmsReportInfoBean();
				bean.setToNumber(rs.getString("TO_NUMBER"));
				bean.setSentDate(rs.getTimestamp("SENT_DATE"));
				bean.setReceiveDate(rs.getTimestamp("RECEIVE_DATE"));
				bean.setResultCode(rs.getString("RESULT_CODE"));
				bean.setEtc(rs.getString("ETC"));
				list.add(bean);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(rs);
			LocalDbUtil.close(con);
		}
		return list;
	}
	//pageNo와 pageSize정보를 바탕으로 pageSize만큼의 결과 리스트 가져오기(페이징부분)
	public ArrayList<SmsReportInfoBean> getReportInfoList(String etc, int pageNo, int pageSize){
		ArrayList<SmsReportInfoBean> list = new ArrayList<SmsReportInfoBean>();
		try{
			con = LocalDbUtil.getConnection();
			/*String sql = "SELECT * "
					+ " FROM (SELECT ROWNUM AS rnum, A.* "
					+ " FROM (SELECT * FROM REPORT_INFO WHERE etc=? ORDER BY RECEIVE_DATE) A WHERE ROWNUM <= ?) "
					+ " WHERE RNUM >= ?";*/
			String sql = "select * "
					+ " from SMS_REPORT_INFO "
					+ " where ETC = ? "
					+ " order by RECEIVE_DATE desc Limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, etc);
			pstmt.setInt(2, (pageNo-1)*pageSize);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				SmsReportInfoBean bean = new SmsReportInfoBean();
				bean.setToNumber(rs.getString("TO_NUMBER"));
				bean.setSentDate(rs.getTimestamp("SENT_DATE"));
				bean.setReceiveDate(rs.getTimestamp("RECEIVE_DATE"));
				bean.setResultCode(rs.getString("RESULT_CODE"));
				bean.setEtc(rs.getString("ETC"));
				list.add(bean);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(rs);
			LocalDbUtil.close(con);
		}
		return list;
	}
	//보낸 ETC정보의 모든 리스트 가져오기
	public ArrayList<String> getSendEtcList(){
		ArrayList<String> list = new ArrayList<String>();
		try{
			String sql = "SELECT ETC FROM SMS_SEND_INFO";
			con = LocalDbUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				list.add(rs.getString("ETC"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return list;
	}
	//로그인한 아이디가 보낸 모든 보낸리스트받기
	public ArrayList<SmsSendInfoBean> getSendInfoList(String id){
		ArrayList<SmsSendInfoBean> list = new ArrayList<SmsSendInfoBean>();
		
		try{
			con = LocalDbUtil.getConnection();
			String sql = "SELECT distinct A.ETC, FROM_NUMBER, SEND_DATE, SMS_MESSAGE, SEND_TOTAL, SEND_SUCCESS, SEND_FAILURE "
					+ " FROM SMS_REPORT_INFO A, SMS_SEND_INFO B "
					+ " WHERE A.ETC = B.ETC AND B.MEM_ID = ? ORDER BY SEND_DATE DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while (rs.next())
			{
				SmsSendInfoBean bean = new SmsSendInfoBean();
				bean.setFromNumber(rs.getString("FROM_NUMBER"));
				bean.setSendDate(rs.getTimestamp("SEND_DATE"));
				bean.setMessage(rs.getString("SMS_MESSAGE"));
				bean.setEtc(rs.getString("ETC"));
				bean.setSendTotal(rs.getInt("SEND_TOTAL"));
				bean.setSendSuccess(rs.getInt("SEND_SUCCESS"));
				bean.setSendFailure(rs.getInt("SEND_FAILURE"));
				list.add(bean);
			}
		}catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return list;
	}
	/***************************************INSERT파트******************************************/
	//SMS발송 전에 내 DB에 INSERT
	public boolean setSendInfo(SmsSendInfoBean bean){
		boolean isSuccess = false;
		try
		{
			con = LocalDbUtil.getConnection();
			con.setAutoCommit(false);
			String sql = "INSERT INTO SMS_SEND_INFO VALUES ((SELECT COUNT(*) FROM (SELECT * FROM SMS_SEND_INFO) A)+1,?,NOW(),?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getFromNumber());
			pstmt.setString(3, bean.getMessage());
			pstmt.setInt(4, bean.getSendTotal());
			pstmt.setInt(5, bean.getSendSuccess());
			pstmt.setInt(6, bean.getSendFailure());
			pstmt.executeUpdate();
			isSuccess=true;
			LocalDbUtil.commit(con);
		} catch (Exception e)
		{
			LocalDbUtil.rollback(con);
			e.printStackTrace();
		} finally
		{
			try {
				con.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return isSuccess;
	}
	//SMS 발송 후 발송한 사람에 대한 정보를 내DB에 저장
	public boolean setReportInfo(ArrayList<SmsReportInfoBean> list){
		boolean isSuccess = false;
		
		try
		{
			con = LocalDbUtil.getConnection();
			con.setAutoCommit(false);
			String sql = "INSERT INTO SMS_REPORT_INFO (TO_NUMBER, ETC) "
					+ " VALUES (?,(SELECT COUNT(*) FROM SMS_SEND_INFO))";
			for(int i=0; i<list.size(); i++){
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, list.get(i).getToNumber());
			pstmt.executeUpdate();
			}
			isSuccess=true;
			LocalDbUtil.commit(con);
		} catch (Exception e)
		{
			LocalDbUtil.rollback(con);
			e.printStackTrace();
		} finally
		{
			try {
				con.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return isSuccess;
	}
	
	/**********************************UPDATE파트*************************************/
	//결과테이블에 보낸시간,받은시간,결과코드가 비어있다면 업데이트
	public boolean updateReportInfoList(ArrayList<SmsReportInfoBean> list){
		boolean isSuccess = false;
		try
		{
			con = LocalDbUtil.getConnection();
			con.setAutoCommit(false);
			/*String sql = "MERGE INTO REPORT_INFO "
					+" USING DUAL"
					+" ON(TO_NUMBER=? AND ETC=?)"
					+" WHEN MATCHED THEN"
					+" UPDATE SET SENT_DATE = ?, RECEIVE_DATE=?, RESULT_CODE=?"
					+" WHERE SENT_DATE IS NULL OR RECEIVE_DATE IS NULL OR RESULT_CODE IS NULL";*/
			String sql = "UPDATE SMS_REPORT_INFO "
					+ " SET SENT_DATE=?, RECEIVE_DATE=?, RESULT_CODE=? "
					+ " WHERE TO_NUMBER=? AND ETC=? "
					+ " AND (SENT_DATE IS NULL OR RECEIVE_DATE IS NULL OR RESULT_CODE IS NULL)";
			pstmt = con.prepareStatement(sql);
			for(int i=0; i<list.size(); i++){
			pstmt.setTimestamp(1, list.get(i).getSentDate());
			pstmt.setTimestamp(2, list.get(i).getReceiveDate());
			pstmt.setString(3, list.get(i).getResultCode());
			pstmt.setString(4, list.get(i).getToNumber());
			pstmt.setString(5, list.get(i).getEtc());
			pstmt.executeUpdate();
			}
			isSuccess=true;
			LocalDbUtil.commit(con);
		} catch (Exception e)
		{
			LocalDbUtil.rollback(con);
			e.printStackTrace();
		} finally
		{
			try {
				con.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		
		return isSuccess;
	}
	//보낸정보DB내용에 성공/실패를 결과테이블을 바탕으로 업데이트
	public boolean setSendAllCount(ArrayList<String> etcList){
		boolean isSuccess = false;
		try{
			String sql = "UPDATE SMS_SEND_INFO "
					+ " SET SEND_SUCCESS =(SELECT COUNT(*) FROM (SELECT * FROM SMS_SEND_INFO) A, (SELECT * FROM SMS_REPORT_INFO) B WHERE A.ETC=B.ETC AND A.ETC=? AND B.RESULT_CODE='0'),"
					+ " SEND_FAILURE = (SELECT COUNT(*) FROM (SELECT * FROM SMS_SEND_INFO) A, (SELECT * FROM SMS_REPORT_INFO) B WHERE A.ETC=B.ETC AND A.ETC=? AND B.RESULT_CODE!='0')"
					+ " WHERE ETC=?";
			con = LocalDbUtil.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(sql);
			for(int i=0; i<etcList.size(); i++){
				pstmt.setString(1, etcList.get(i));
				pstmt.setString(2, etcList.get(i));
				pstmt.setString(3, etcList.get(i));
				pstmt.executeUpdate();
			}
			isSuccess = true;
			LocalDbUtil.commit(con);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try {
				con.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return isSuccess;
	}

	/////////////////////////////////////////MYSQL//////////////////////////////////////////////
	//SMS DB에 SMS 발송정보를 INSERT
	public ArrayList<SmsReportInfoBean> insertMsgData(String[] toNumber,String fromNumber,String id, String message, int seq){
		ArrayList<SmsReportInfoBean> reportList = new ArrayList<SmsReportInfoBean>();
		int check=0;
		try {
			String sql = "INSERT INTO MSG_DATA (CUR_STATE, CALL_TO, CALL_FROM, SMS_TXT, MSG_TYPE, MSG_ETC2, MSG_ETC3, MSG_ETC4, MSG_ETC5) "
					+ " VALUES (0, ?, ? ,? , 4 , 'no',?, 'bypark', ? )";
			con = SmsDbUtil.getConnection();
			for (int i = 0; i < toNumber.length; i++) {
				SmsReportInfoBean reportBean = new SmsReportInfoBean();
				pstmt = con.prepareStatement(sql); // 성공=1 실패 =0 반환
				pstmt.setString(1, toNumber[i]);
				pstmt.setString(2, fromNumber);
				pstmt.setString(3, message);
				pstmt.setString(4, id);
				pstmt.setString(5, String.valueOf(seq));
				System.out.println(toNumber[i]);
				reportBean.setToNumber(toNumber[i]);
				reportBean.setEtc(String.valueOf(seq));
				reportList.add(reportBean);
				check = pstmt.executeUpdate();
				if (check == 1) {
					System.out.println("인설트성공");
				} else {
					System.out.println("인설트실패");
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally{
			SmsDbUtil.close(pstmt);
			SmsDbUtil.close(con);
		}
		return reportList;
	}
	//SMS DB의 로그테이블에서 ETC조건에 맞는 내용을 가져오기
	public ArrayList<SmsReportInfoBean> selectAllReportInfo(){
		ArrayList<SmsReportInfoBean> list = new ArrayList<SmsReportInfoBean>();
		try {
			con = SmsDbUtil.getConnection();
			String sql1 = "SELECT SENT_DATE, RSLT_DATE, RSLT_CODE2, CALL_TO, MSG_ETC5"
					+ " FROM MSG_LOG_201502 "
					+ " WHERE MSG_ETC2='no' AND MSG_ETC4 = 'bypark' AND RSLT_CODE2 IS NOT NULL";
			pstmt = con.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				SmsReportInfoBean bean = new SmsReportInfoBean();

				bean.setSentDate(rs.getTimestamp("SENT_DATE"));
				bean.setReceiveDate(rs.getTimestamp("RSLT_DATE"));
				bean.setResultCode(rs.getString("RSLT_CODE2"));
				bean.setToNumber(rs.getString("CALL_TO"));
				bean.setEtc(rs.getString("MSG_ETC5"));
				list.add(bean);
			}
			//가져가고 난뒤 no로 되있는것을 yes로 바꾸기
			String sql2 = "UPDATE MSG_LOG_201502"
				+ " SET MSG_ETC2 = 'yes' "
				+ " WHERE MSG_ETC2 = 'no' AND MSG_ETC4 = 'bypark'";
			pstmt = con.prepareStatement(sql2);
			pstmt.executeUpdate();	
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		SmsDbUtil.close(rs);
		SmsDbUtil.close(pstmt);
		SmsDbUtil.close(con);
		
		return list;
	}
	
}
