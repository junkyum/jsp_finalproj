<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
%>

<c:forEach var="dto" items="${listFriend}">
    <tr height='25' data-tid='${dto.friendUserId}'>
          <td align='center' width='30'>
              <input type='checkbox' value='${dto.friendUserId}' >
          </td>
          <td align='left' width='160'>
              ${dto.friendUserName}(${dto.friendUserId})
          </td>
     </tr>
</c:forEach>
