package net.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.common.db.LocalDbUtil;
import net.common.db.SmsDbUtil;
/*
 * 멤버관련 데이터접근 클래스
 */
public class MemberDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	Statement stmt;
	////////////////////////////LOCALDB//////////////////////////////////////
	//회원정보가져오기
	public MemberBean getMember(String id){
		MemberBean bean = new MemberBean();
		try
		{
			con = LocalDbUtil.getConnection();
			String sql = "SELECT * FROM MEMBER WHERE MEM_ID=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				bean.setId(rs.getString("MEM_ID"));
				bean.setPassword(rs.getString("MEM_PASSWORD"));
				bean.setName(rs.getString("MEM_NAME"));
				bean.setEmail(rs.getString("MEM_EMAIL"));
				bean.setPhonenumber(rs.getString("MEM_PHONENUMBER"));
				bean.setJoinDate(rs.getDate("MEM_JOINDATE"));
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
		return bean;
	}
	//회원가입 INSERT하기
	public boolean setMember(MemberBean bean){
		
		boolean isSuccess = false;

		try
		{
			con = LocalDbUtil.getConnection();
			con.setAutoCommit(false);
			String sql = "INSERT INTO MEMBER VALUES (?,?,?,?,?,NOW())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPassword());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getPhonenumber());

			int result = pstmt.executeUpdate();

			if (result != 0)
			{
				isSuccess = true;
				LocalDbUtil.commit(con);
			}
		} catch (Exception e)
		{
			LocalDbUtil.rollback(con);
			e.printStackTrace();
		} finally
		{
			try {
				con.setAutoCommit(false);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return isSuccess;
	}
	//회원정보수정
	public boolean alterMember(MemberBean bean){
		
		boolean isSuccess = false;

		try
		{
			con = LocalDbUtil.getConnection();
			con.setAutoCommit(false);
			String sql = "UPDATE MEMBER SET MEM_PASSWORD = ?, MEM_NAME=?, MEM_EMAIL=?, MEM_PHONENUMBER=? WHERE MEM_ID=? ";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getPassword());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getEmail());
			pstmt.setString(4, bean.getPhonenumber());
			pstmt.setString(5, bean.getId());
			
			int result = pstmt.executeUpdate();

			if (result != 0)
			{
				isSuccess = true;
				LocalDbUtil.commit(con);
			}
		} catch (Exception e)
		{
			LocalDbUtil.rollback(con);
			e.printStackTrace();
		} finally
		{
			try {
				con.setAutoCommit(false);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return isSuccess;
	}
	//아이디 중복체크
	public boolean duplicateIdCheck(String id){
		boolean isDup = true;
		
		try
		{
			con = LocalDbUtil.getConnection();
			String sql = "SELECT * FROM MEMBER WHERE MEM_ID=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (!rs.next())
			{
				isDup = false;
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
		return isDup;
	}
	//아이디 비밀번호 일치체크
	public boolean loginCheck(String id, String password){
		boolean login = false;
		
		try{
			con = LocalDbUtil.getConnection();
			String sql = "SELECT * FROM MEMBER WHERE MEM_ID=? AND MEM_PASSWORD=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				login = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return login;
	}
	//아이디 체크
	public boolean idCheck(String id){
		boolean login = false;
		
		try{
			con = LocalDbUtil.getConnection();
			String sql = "SELECT * FROM MEMBER WHERE MEM_ID=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				login = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			LocalDbUtil.close(rs);
			LocalDbUtil.close(pstmt);
			LocalDbUtil.close(con);
		}
		return login;
	}
	/////////////////////////////////MYSQL/////////////////////////////////////
	//SMS 회원가입인증번호 보내기
	public boolean sendConfirmNumber(String toNumber, String confirmNumber) throws SQLException{
		boolean isSuccess = false;
		
		try {
			String sql = "INSERT INTO MSG_DATA"
					+ " (CUR_STATE, CALL_TO, CALL_FROM, SMS_TXT, MSG_TYPE)"
					+ " VALUES (0,  '"+toNumber+"' , '01055233629', '인증번호는 ["+confirmNumber+"]입니다.' , 4)";
			
			con = SmsDbUtil.getConnection();
			stmt = con.createStatement();
			int result = stmt.executeUpdate(sql); // 성공=1 실패 =0 반환
			if (result == 1) {
				System.out.println("인설트성공");
			} else {
				System.out.println("인설트실패");
			}
			isSuccess = true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally{
			stmt.close();
			SmsDbUtil.close(con);
		}
		return isSuccess;
	}
}
