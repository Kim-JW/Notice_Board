package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import model.vo.MemberVO;
import model.vo.WritingVO;

public class MemberDAO {
	/*
	 * 아이디 중복 체크
	 * 아이디 DB에 삽입
	 */
	
	public boolean login(String id, String password) {
		Connection conn = connectDB();
		try(Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select id, password from member");){	
			while(rs.next()) {
				String candidateId = rs.getString(1);
				String candidatepw = rs.getString(2);
				
				if (id.equals(candidateId) && password.equals(candidatepw)) {
					return true;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		close(conn);
		
		return false;
	}
	
	public boolean isNewId(String id) {
		
		if(id.equals("")) {
			return false;
		}
		
		Connection conn = connectDB();
		try(Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select id from member");){	
			while(rs.next()) {
				
				String candidateId = rs.getString(1);
				
				if (id == candidateId) {
					return false;
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		close(conn);
		
		return true;
	}
	
	public boolean signup(MemberVO mo) {
		boolean result = true;
		Connection conn = connectDB();
		if(!isNewId(mo.getId())) {
			return false;
		}
		
		try (PreparedStatement pstmt = conn.prepareStatement("insert into member (id, password, name, phone) values(?, ?, ?, ?)");){
			//System.out.println(vo.getMeetingDate());
			pstmt.setString(1, mo.getId());
			pstmt.setString(2, mo.getPassword());
			pstmt.setString(3, mo.getName());
			pstmt.setString(4, mo.getPhone());
			pstmt.executeUpdate();			
		}catch(SQLException e){
			result = false;
			e.printStackTrace();
		}
		close(conn);
		return result;
	}
	
	public Connection connectDB() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); //Java 6 버전부터는 생략 가능
			String url = "jdbc:mysql://localhost:3306/humor?characterEncoding=UTF-8&serverTimezone=UTC";
			String user = "root";
			String passwd = "2413";
			conn = DriverManager.getConnection(url, user, passwd);						
		} catch (Exception e) {
			System.out.println("MYSQL 연결 실패");
			System.out.print("사유 : " + e.getMessage());
		}
		return conn;
	}
	
	public void close(Connection conn) {
		try {
			if (conn != null) 
				conn.close();
		} catch (Exception e) {
			System.out.println("MYSQL 닫기 실패");
			System.out.print("사유 : " + e.getMessage());
		}
		
	}
}
