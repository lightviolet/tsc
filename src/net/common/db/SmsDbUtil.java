package net.common.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/* 
 *MySQL DB 유틸리티
 */
public class SmsDbUtil {

	static String url = "jdbc:mysql://119.207.76.72:3306/i10";
	static String user = "i10";
	static String pass = "vhtmxmaos";
	
	public static Connection getConnection() throws SQLException
	{
		Connection con = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, user, pass);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return con;
	}

	public static void close(ResultSet rs)
	{
		try
		{
			rs.close();
		}
		catch (SQLException e)
		{
			System.out.println("ResultSet 닫기 에러: " + e.getMessage());
		}
	}

	public static void close(PreparedStatement pstmt)
	{
		try
		{
			pstmt.close();
		}
		catch (SQLException e)
		{
			System.out.println("PreparedStatement 닫기 에러: " + e.getMessage());
		}
	}

	public static void close(Connection con)
	{
		try
		{
			con.close();
		}
		catch (SQLException e)
		{
			System.out.println("Connection 닫기 에러: " + e.getMessage());
		}
	}

	public static void commit(Connection con)
	{
		try
		{
			con.commit();
			System.out.println("커밋 성공");
		}
		catch (SQLException e)
		{
			System.out.println("커밋 실패");
		}
		finally
		{
			try
			{
				con.setAutoCommit(true);
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
	}

	public static void rollback(Connection con)
	{
		try
		{
			con.rollback();
			System.out.println("롤백 성공");
		}
		catch (SQLException e)
		{
			System.out.println("롤백 실패");
		}
		finally
		{
			try
			{
				con.setAutoCommit(true);
			}
			catch (SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
}
