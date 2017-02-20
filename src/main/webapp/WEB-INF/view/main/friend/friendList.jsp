<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
//11
%>

<c:forEach var="dto" items="${friendList}">
	<tr height='25' data-tid='${dto.friendUserId}'>
		<td align='center' width='30'><input type='checkbox'
			value='${dto.num}' data-userId='${dto.friendUserId}'></td>
		<td align='left' width='200'>
			${dto.friendUserName}(${dto.friendUserId})</td>
	</tr>
</c:forEach>
