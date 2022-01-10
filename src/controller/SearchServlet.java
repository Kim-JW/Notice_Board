package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.WritingDAO;
import model.vo.WritingVO;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	int splitNum = 3;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String target_url = "/jsp/writingMain.jsp";
		String action = request.getParameter("action");
		
		HttpSession session = request.getSession();
		
		WritingDAO dao = new WritingDAO();
		
		String searchOption = request.getParameter("opt");
		String condition = request.getParameter("condition");
		String search_state = request.getParameter("search_state");
		
		int currentPage = 1;
		
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		
		session.setAttribute("search_pageNum", dao.search_pageNum(splitNum, searchOption, condition));
		session.setAttribute("search_currentPage", condition);
		
		if(action != null) {
			if(action.equals("search")) {
				ArrayList<WritingVO> list = dao.search(searchOption, condition);
				if (list != null && list.size() == 0) {
					System.out.println("찾는 글이 하나도 없음");
				} else {
					request.setAttribute("list", list);
				}
			}
		}
		
		request.getRequestDispatcher(target_url).forward(request, response);
	}

}
