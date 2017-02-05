<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<div>
	<table class="table">
			<tr>
				<td>그룹명</td>
				<td>소개</td>
				<td>그룹장</td>
				<td>장소</td>
				<td>키워드</td>
				<td>입장</td>
			</tr>
		<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.groupName}</td>
				<td>${dto.introduce}</td>
				<td>${dto.userId }</td>
				<td>${dto.place }</td>
				<td>${dto.keyword }</td>
				<td>
				<button type="button" class="jkbutton" onclick="javascript:location.href='<%=cp%>/group?groupName=${dto.groupName}';">
				<img src ="<%=cp%>/res/images/right.png" style="width:20px;height:20px;">
				</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	</div>
<c:if test="${distinction != 'my'}">
<div class="paging"	style="text-align: center; min-height: 50px; line-height: 50px; margin-bottom: auto;">
		<c:if test="${dataCount==0 }">
                 등록된 그룹이 없습니다.
        </c:if>
		<c:if test="${dataCount!=0 }">
        ${paging}
        </c:if>
</div>
</c:if>

