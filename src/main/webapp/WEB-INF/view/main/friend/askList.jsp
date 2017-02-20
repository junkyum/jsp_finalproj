<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
//11
%>
<c:forEach var="dto" items="${friendAskList}">
	<span>
    	&nbsp;
		<a href="javascript:askDelete('${dto.num}');">
			<img src="<%=cp%>/res/images/icon-minus.png" border="0">
		</a>&nbsp;
    	${dto.friendUserName}(${dto.friendUserId})
    	<br>
  	</span>
</c:forEach>