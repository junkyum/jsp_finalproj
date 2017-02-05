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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


</head>

<c:forEach var="dto" items="${boardList}">
	<tr>
		<td class="text-center">${dto.listNum}</td>
	<%-- 	<td><a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a>
			<c:if test="${dto.gap < 1}">
			
            </c:if></td> --%>
        <td class="text-center">${dto.subject}</td>    
		<td class="text-center">${dto.userName}</td>
		<td class="text-center">${dto.created}</td>
		<td class="text-center">${dto.hitCount}</td>
	</tr>
</c:forEach>

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








