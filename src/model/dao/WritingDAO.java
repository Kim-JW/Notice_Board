package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.vo.WritingVO;

public class WritingDAO implements Writing {
	
	public int pageNum(int writingNum) {
		int num = 0;
		
		Connection conn = connectDB();
		try(Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(
						"select count(id) from writing");) {
			while(rs.next()) {
				num = rs.getInt(1);
			}
		} catch (SQLException e ) {
			e.printStackTrace();
		}
		close(conn);
		
		if(num % writingNum > 0) {
			num = (num / writingNum) + 1;
		} else {
			num = num / writingNum;
		}
		return num;
	}

	// 번호, 제목, 작성자, 작성일 ,조회수
	public ArrayList<WritingVO> listAll(int startNum, int splitNum) {
		ArrayList<WritingVO> list = new ArrayList<>();
		Connection conn = connectDB();
		try (Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(
						"select id, title, writer, date_format(writedate, '%Y년 %m월 %d일'), cnt "
						+ "from writing order by id desc limit " + startNum + ", " + splitNum);) {
			WritingVO vo;
			while (rs.next()) {
				vo = new WritingVO();
				vo.setId(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setWriter(rs.getString(3));
				vo.setWriteDate(rs.getString(4));
				vo.setCnt(rs.getInt(5));
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(conn);
		return list;
	}

	public ArrayList<WritingVO> search(String option, String keyword) {
		ArrayList<WritingVO> list = new ArrayList<>();
		Connection conn = connectDB();
		try (Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("select id, title, writer, date_format(writedate, '%Y년 %m월 %d일'), cnt"
						+ " from writing where " + option + " like '%"+ keyword + "%'");) {
			WritingVO vo;
			while (rs.next()) {
				System.out.println(rs.getString(2));
				System.out.println(rs.getString(3));
				System.out.println(rs.getString(4));
				vo = new WritingVO();
				vo.setId(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setWriter(rs.getString(3));
				vo.setWriteDate(rs.getString(4));
				vo.setCnt(rs.getInt(5));
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(conn);
		return list;
	}

	public boolean insert(WritingVO vo) {
		boolean result = true;
		Connection conn = connectDB();
		try (PreparedStatement pstmt = conn.prepareStatement(
				"insert into writing (title, writer, content, writedate, cnt) values(? ,?, ?, ?, ?)");) {
			// System.out.println(vo.getMeetingDate());
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getWriter());
			pstmt.setString(3, vo.getContent());
			pstmt.setString(4, vo.getWriteDate());
			pstmt.setInt(5, 0);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			result = false;
			e.printStackTrace();
		}
		close(conn);
		return result;
	}

	public boolean delete(int id) {
		boolean result = true;
		Connection conn = connectDB();
		try (PreparedStatement pstmt = conn.prepareStatement("delete from writing where id = ?");) {
			pstmt.setInt(1, id);
			int deleteNum = pstmt.executeUpdate();
			if (deleteNum != 1)
				result = false;
		} catch (SQLException e) {
			result = false;
			e.printStackTrace();
		}
		close(conn);
		return result;
	}

	public boolean update(WritingVO vo) {
		boolean result = true;
		Connection conn = connectDB();
		try (PreparedStatement pstmt = conn.prepareStatement("update writing set " + "title = ?, "
				+ "content = ? " + "where id = ?");) {
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			result = false;
			e.printStackTrace();
		}
		close(conn);
		return result;
	}

	@Override
	public Connection connectDB() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // Java 6 버전부터는 생략 가능
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

	@Override
	public WritingVO listOne(int id) {
		
		WritingVO vo = null;
		
		Connection conn = connectDB();
		try (Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(
						"select id, writer, title, content, date_format(writedate, '%Y년 %m월 %d일'), cnt from writing where id = " + id);) {
			vo = new WritingVO();
			rs.next();
			vo.setId(rs.getInt(1));
			vo.setWriter(rs.getString(2));
			vo.setTitle(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setWriteDate(rs.getString(5));
			vo.setCnt(rs.getInt(6));

		} catch (SQLException e) {
			e.printStackTrace();
		}
		close(conn);

		return vo;
	}
	
	public boolean viewCntIncrease(int id) {
		
		Connection conn = connectDB();
		try (PreparedStatement pstmt = conn.prepareStatement("update writing set " + "cnt = cnt +1 " + "where id = ?");) {
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			close(conn);
		}
	}

	@Override
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