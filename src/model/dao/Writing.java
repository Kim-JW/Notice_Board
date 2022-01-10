package model.dao;

import java.sql.Connection;
import java.util.List;

import model.vo.WritingVO;

public interface Writing {
	public Connection connectDB();
	public void close(Connection conn);
	public boolean insert(WritingVO vo);
	public boolean update(WritingVO vo);
	public boolean delete(int id);
	public List<WritingVO> listAll(int startNum, int endNum);
	public WritingVO listOne(int id);
	
}
