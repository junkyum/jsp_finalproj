<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
//11
%>

<c:forEach var="dto" items="${friendSearchList}">
  <span style="display: block;" data-userId="${dto.friendUserId}">
       &nbsp;<a href="javascript:friendAdd('${dto.friendUserId}');"><img src="<%=cp%>/res/images/icon-plus.png" border="0"></a>&nbsp;
       ${dto.friendUserName}(${dto.friendUserId})</span>
</c:forEach>