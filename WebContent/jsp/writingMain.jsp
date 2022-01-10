<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="model.vo.WritingVO, java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style>
div {
	text-align: center;
}
td {
	border-bottom: 1px dotted green;
}
tr:hover {
	background-color: pink;
	font-weight: bold;
}
td:nth-child(3) {
	width: 400px
}

</style>
</head>
<body>
	<center>	
<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> 	<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="/bbs/board">유머 게시판</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="/bbs/board">메인으로</a></li>
			</ul>	
				</div>
	</nav>
    <img  src="/bbs/img/sponge1.jpg" width = "1200" height = "200">
    <div id="writing">
        <table class="table table-striped" id="bList"  border="2" bordercolor="lightgray" align = "center">
            <tr heigh="30">
                <td style="background-color: #eeeeee; text-align: center;">글번호</td>
                <td style="background-color: #eeeeee; text-align: center;">작성자</td>
                <td style="background-color: #eeeeee; text-align: center;">제목</td>          
                <td style="background-color: #eeeeee; text-align: center;">작성일</td>
                <td style="background-color: #eeeeee; text-align: center;">조회수</td>
            </tr>
        <%
        String state = (String) session.getAttribute("state");
		ArrayList<WritingVO> list = (ArrayList<WritingVO>) request.getAttribute("list");
	if (list != null) {
	%>
        <%
		for (WritingVO vo : list) {
		%>
            <tr>
			<td><%=vo.getId()%></td>
			<td><%=vo.getWriter()%></td>
			<%  if (!state.equals("member")) {%>
            <td><a href="javascript:alert('로그인 하세요! 아이디 없을 시 회원가입 먼저!!');"><%=vo.getTitle()%></a></td>
            <%}else{ %>
            <td><a href='/bbs/board?action=select&id=<%=vo.getId()%>'><%=vo.getTitle()%></a></td>
            <%} %>
			<td><%=vo.getWriteDate()%></td>
			<td><%=vo.getCnt()%></td>
			<br>
		</tr>
	<%
		}
	%>
	<%
	}
	%>
        </table>
    </div>
        <%
	String state1 = (String)session.getAttribute("state");
	if(state1.equals("member")){
	%>
	<button type="button" class="btn btn-primary pull-right"
                  onclick="location.href='/bbs/jsp/insertForm.jsp'">글작성</button>
                  
    <button type="button" class="btn btn-primary pull-right"
                  onclick="location.href='/bbs/board?action=logout'">로그아웃</button>
	<% 	
	} else {
	%>
	<button type="button" class="btn btn-primary pull-right"
                  onclick="location.href='/bbs/jsp/login.jsp'">로그인</button>
    <button type="button" class="btn btn-primary pull-right"
                  onclick="location.href='/bbs/jsp/signup.jsp'">회원가입</button>
	
	<%
	}
	
	%>
	<% 
	int pageNum = (int)session.getAttribute("pageNum");
	for(int i = 1; i <= pageNum; i++ ) {
	%>
	
	<a href="/bbs/board?currentPage=<%=i%>"><font size="3"><%=i %></font></a>
	<%
	}
	%>
	<br>
    <div id="searchForm">
        <form action= "/bbs/board">
            <select name="opt">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="writer">글쓴이</option>
            </select>
            <input type="text" size="20" name="condition"/>&nbsp;
            <input type="submit" name="action" value="search"/>
        </form>    
    </div>

 <!--   <a class="navbar-brand" href="/bbs/board">메인화면으로</a>-->  
	
	<!-- <input type="submit" value="등록"> <input type="reset" value="재작성"> -->
	
<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>