<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<c:forEach var="dto" items="${list }">
	<div>
	
	
	</div>
</c:forEach>
<div class="paging"
		style="text-align: center; min-height: 50px; line-height: 50px;">
		<c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
		<c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
</div>

