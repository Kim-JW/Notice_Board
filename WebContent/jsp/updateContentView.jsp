<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.vo.WritingVO, model.vo.MemberVO, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width" , initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<!-- 네비게이션 -->
		<div class="navbar-header">
			<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="/bbs/board">유머 게시판</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="/bbs/board">메인으로</a></li>
			</ul>


		</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->

	<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
				<%
			WritingVO vo = (WritingVO) request.getAttribute("select_list");
			%>	
			<form method="post" action="/bbs/board">		
			<input type="hidden" name="action" value="update">
			<input type="hidden" name="writing_id" value="<%=vo.getId()%>">
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">유머
								게시판 글쓰기</th>
						</tr>
					</thead>
					<tbody>
					<tr>
							<td id="title"><%=vo.getWriter()%>님이 글을 수정합니다^0^</td>
						</tr>
						<tr>
							<td><input name="title" type="text" class="form-control"
								 name="title" maxlength="50" value="<%=vo.getTitle()%>"/></td>
						</tr>
						<tr>
							<td><textarea class="form-control" 
									name="content" maxlength="2048" style="height: 350px;"><%=vo.getContent().replaceAll("<br>", "")%></textarea></td>
						</tr>
						
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="등록">
				<input type="reset" class="btn btn-primary pull-right" value="작성취소">
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->

	<!-- jquery -->

	<script src="//code.jquery.com/jquery.min.js"></script>



	<!-- BootStrap -->

	<!-- 합쳐지고 최소화된 최신 CSS -->

	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

	<!-- 부가적인 테마 -->

	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->

	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</body>
</html>