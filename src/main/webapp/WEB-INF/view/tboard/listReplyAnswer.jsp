<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
//11
%>



<c:if test="${not empty listReplyAnswer}">
    <c:forEach var="vo" items="${listReplyAnswer}">
        <div style="clear: both; border-top: #d5d5d5 solid 1px; margin-top: 7px; padding-top: 5px;">
            <div style="float: left;">${vo.userName} | ${vo.created }</div>
            <div style="float: right; text-align: rigth;">
<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">   
		     <a onclick='deleteReplyAnswer("${vo.repleNum}", "${vo.answer}");'>삭제</a>
</c:if>
<c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">   
		   | <a href='#'>신고</a>
</c:if>
            </div>
        </div>
        <div style="clear: both; padding: 5px 0 5px 0px;  min-height: 70px;">
            ${vo.content}
        </div>
    </c:forEach>
</c:if>