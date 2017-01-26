<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
.container {
	width: 900px;
	height: 680px;
	border: 1px solid #5D5D5D;
}

</style>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container" style="clear: both;">
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width: 70px;">번호</th>
					<th>제목</th>
					<th class="text-center" style="width: 100px;">작성자</th>
					<th class="text-center" style="width: 100px;">등록일</th>
					<th class="text-center" style="width: 70px;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>가입인사</td>
					<td class="text-center" style="width: 100px;">문경미</td>
					<td class="text-center" style="width: 100px;">2017-01-20</td>
					<td class="text-center" style="width: 70px;">100</td>
				</tr>
				<tr>
					<td>2</td>
					<td>가입인사</td>
					<td class="text-center" style="width: 100px;">문최고</td>
					<td class="text-center" style="width: 100px;">2017-01-20</td>
					<td class="text-center" style="width: 70px;">100</td>
				</tr>
				<tr>
					<td>3</td>
					<td>가입인사</td>
					<td class="text-center" style="width: 100px;">문미미</td>
					<td class="text-center" style="width: 100px;">2017-01-20</td>
					<td class="text-center" style="width: 70px;">100</td>
				</tr>
			</tbody>
		</table>
		<div class="threediv" style="clear: both;">
			<div style="float: left; width: 20%; min-width: 85px;">
				<button type="button" class="btn btn-default btn-sm wbtn">새로고침</button>
			</div>
			<div style="float: left; width: 60%; text-align: center;">
				<form name="searchForm" method="post" class="form-inline">
					<select class="form-control input-sm" name="searchKey">
						<option value="subject">제목</option>
						<option value="userName">작성자</option>
						<option value="content">내용</option>
						<option value="created">등록일</option>
					</select> <input type="text" class="form-control input-sm input-search"
						name="searchValue">
					<button type="button" class="btn btn-info btn-sm btn-search"
						onclick="searchList();">
						<span class="glyphicon glyphicon-search"></span> 검색
					</button>
				</form>
			</div>
			<div
				style="float: left; width: 20%; min-width: 85px; text-align: right;">
				<button type="button" class="btn btn-primary btn-sm bbtn">
					<span class="glyphicon glyphicon glyphicon-pencil"></span> 글쓰기
				</button>

			</div>
		</div>

	</div>

</body>

