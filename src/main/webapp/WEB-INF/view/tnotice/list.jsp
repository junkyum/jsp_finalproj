<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.table th, .table td {
	font-weight: normal;
	border-top: none;
}
.table thead tr th {
	border-bottom: none;
}
.table thead tr {
	border: #d5d5d5 solid 1px;
	background: #eeeeee;
	color: #787878;
}
.table td {
	border-bottom: #d5d5d5 solid 1px;
}
.table td a {
	color: #000;
}
</style>

<script type="text/javascript">
function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/tnotice/list";
		f.submit();
}
</script>

<div class="mk_bodyFrame2" style="margin: 0 auto; width: 1000px; padding-top: 10px;">
	<div class="mk_body-title">
		<h3>공지사항</h3>
	</div>

		<c:if test="${dataCount!=0 }">
			<div style="clear: both; height: 30px; line-height: 30px;">
				<div style="float: left;">${dataCount}개(${page}/${total_page}
					페이지)
				</div>
				<div style="float: right;">&nbsp;</div>
			</div>

			<div class="table-responsive" style="clear: both;">
				<!-- 테이블 반응형 -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center" style="width: 70px;">번호</th>
							<th>제목</th>
							<th class="text-center" style="width: 100px;">글쓴이</th>
							<th class="text-center" style="width: 100px;">날짜</th>
							<th class="text-center" style="width: 70px;">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${listTop}">
							<tr>
								<td class="text-center">
									<span style="display: inline-block; width: 28px; height: 18px; line-height: 18px; background: #ED4C00; color: #FFFFFF">공지</span>
								</td>
								<td>	
									<a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
								</td>
								<td class="text-center">${dto.userName}</td>
								<td class="text-center">${dto.created}</td>
								<td class="text-center">${dto.hitCount}</td>
							</tr>
						</c:forEach>
						<c:forEach var="dto" items="${list}">
							<tr>
								<td class="text-center">${dto.listNum}</td>
								<td>
									<a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
									<c:if test="${dto.gap < 1}">
										<!-- <img src='cp들어가야/res/images/new.gif'> -->
										// 새글 표시
									</c:if>
								</td>
								<td class="text-center">${dto.userName}</td>
								<td class="text-center">${dto.created}</td>
								<td class="text-center">${dto.hitCount}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
		
		<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
			<c:if test="${dataCount==0 }">
                  	등록된 게시물이 없습니다.
            </c:if>
			<c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
		</div>

		<div style="clear: both;">
			<div style="float: left; width: 20%; min-width: 85px;">
				<button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tnotice/list';">
					새로고침
				</button>
			</div>
			<div style="float: left; width: 60%; text-align: center;">
				<form name="searchForm" method="post" class="form-inline">
					<select class="form-control input-sm" name="searchKey">
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="created">등록일</option>
					</select> 
					
					<input type="text" class="form-control input-sm input-search" name="searchValue">
					<button type="button" class="btn btn-default btn-sm wbtn" onclick="searchList();">
						<!-- 돋보기 그림 -->
						<!-- <span class="glyphicon glyphicon-search"></span> -->
						 검색
					</button>
				</form>
			</div>
			<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
				<c:if test="${sessionScope.member.userId=='admin'}">
					<button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tnotice/created';">
						<!--  연필 그림 -->
						<!-- <span class="glyphicon glyphicon glyphicon-pencil"></span> -->
						 글쓰기
					</button>
				</c:if>
			</div>
		</div>

	</div>

</div>