<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
//대댓글 리스트
%>
<c:forEach var="vo" items="${listAnswer}">
    <div class='answer'  style='padding: 0px 10px;'>
        <div style='clear:both; padding: 10px 0px;'>
            <div style='float: left; width: 5%;'>└</div>
            <div style='float: left; width:95%;'>
                <div style='float: left;'><b>작성자:${vo.userId} </b></div>
                <div style='float: right;'>
                    <span>${vo.created}</span> |
                    
                  <%--   <a onclick='deleteReplyAnswerList("${vo.replyNum}", "${vo.replyAnswer}");'>삭제</a> --%>
  <c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}">   
                   <a onclick='deleteReplyAnswerList("${vo.replyNum}", "${vo.replyAnswer}");'>삭제</a>
</c:if>
<%--
<c:if test="${sessionScope.member.userId!=vo.userId && sessionScope.member.userId!='admin'}">   
                    <a href='#'>신고</a>
</c:if>      --%>                
                </div>
            </div>
        </div>
        <div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;'>
            ${vo.content}
        </div>
    </div>
</c:forEach>