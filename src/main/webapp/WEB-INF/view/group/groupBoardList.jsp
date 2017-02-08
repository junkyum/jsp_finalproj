<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
.bestbig {
	margin: 0 auto;
	width: 900px;
	/* 	height: 680px; */
}
</style>
<head>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
</head>
<div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width: 70px;">번호</th>
					<th>제목</th>
					<th class="text-center" style="width: 100px;">작성자</th>
					<th class="text-center" style="width: 130px;">등록일</th>
					<th class="text-center" style="width: 70px;">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${boardList}">
					<tr>
						<td style="width: 70px;">${dto.listNum}</td>
				        <td >${dto.subject}</td>    
						<td class="text-center" >${dto.userId}</td>
						<td class="text-center">${dto.created}</td>
						<td class="text-center" >${dto.hitCount}</td>
					</tr>
				</c:forEach>				
			</tbody>
		</table>
	</div>
	

<div style="clear: both;">
	<div class="paging"	style="text-align: center; min-height: 50px; line-height: 50px;">
		<c:if test="${dataCount==0 }">등록된 게시물이 없습니다.</c:if>
		<c:if test="${dataCount!=0 }">${paging}</c:if>
	</div>

	<div style="float: left; width: 20%; min-width: 85px;">
		<button type="button" class="btn btn-default btn wbtn">
			<span class="glyphicon glyphicon-repeat"></span>
			<!-- 새로고침  -->
		</button>
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
			<button type="button" class="btn btn-default btn btn-search"
				onclick="searchList();">
				<span class="glyphicon glyphicon-search"></span>
			</button>
		</form>
	</div>
	<div
		style="float: left; width: 20%; min-width: 85px; text-align: right;">
		<button type="button" class="btn btn-default btn wbtn"
			data-toggle="modal" data-target="#myModalGboard">
			<span class="glyphicon glyphicon glyphicon-pencil"></span>
		</button>
	</div>

</div>








