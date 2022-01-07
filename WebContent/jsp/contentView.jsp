
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="model.vo.WritingVO, model.vo.MemberVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 - 글내용</title>
<style type="text/css">
#title {
	height: 16;
	font-family: '돋움';
	font-size: 12;
	text-align: center;
}
  table {
    width: 100%;
    height: 200px;
  }
</style>
</head>
<body>
	<br>
	<b><font size="6" color="gray">게시글 내용</font></b>
	<br>
	<a href="/bbs/board">메인으로 가기</a>

		<!--  <input type="hidden" name="writer" value="${sessionScope.id}">
				<input type="hidden" name="title" value="${sessionScope.title}">
				<input type="hidden" name="content" value="${sessionScope.content}"> -->
		<table width="700" border="3" bordercolor="lightgray" align="center">
			<%
			WritingVO vo = (WritingVO) request.getAttribute("select_list");

			if (vo != null) {
			%>

			<tr>
				<td id="title">작성자</td>
				<td><%=vo.getWriter()%></td>
			</tr>
			<tr>
				<td id="title">제 목</td>

				<%
				if (session.getAttribute("id").equals(vo.getWriter())) {
				%>
				
				<td><input name="title" type="text" size="70" maxlength="100"
					value="<%=vo.getTitle()%>" /></td>
				<%
				} else {
				%>
				<td><%=vo.getTitle()%></td>
				<%
				}
				%>
			</tr>
			<tr>
			<td id="title">내 용</td>
				<%
				if (session.getAttribute("id").equals(vo.getWriter())) {
				%>
				<td><textarea name="content" cols="72" rows="20"> <%=vo.getContent()%>
				</textarea>
				</td>
				<%
				} else {
				%>
				<td height="200"><table cols="72" rows="20"> <%=vo.getContent()%></table></td>
				<%
				}
				%>
			</tr>
			<%
			}
			%>


			<tr align="center" valign="middle">
				<td colspan="5"></td>
						</div>
			</tr>
		</table>
			<%
				if (session.getAttribute("id").equals(vo.getWriter())) {
			%>
				수정완료<input type="button" name="action" value="update">
				</form>
			
  				<form method="get" action="/bbs/board">
				삭제<input type="button" name="action" value="delete">
				</form>
  				<%
				}else{
  				%>
  				<a href='/bbs/board'>메인으로 돌아가기</a>
  				
  				<%} %>
	
</body>
</html>