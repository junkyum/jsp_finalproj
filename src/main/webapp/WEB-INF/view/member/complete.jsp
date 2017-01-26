<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="jumbotron">
    <h1>${title}</h1>
</div>

<div class="bodyFrame">
   <p class="lead text-center">${message}</p>
   <p style="max-width: 400px; margin: 0 auto;">
      <button type="button" class="btn btn-primary btn-lg btn-block" onclick="javascript:location.href='<%=cp%>/';"> 메인화면으로 이동 &raquo; </button>
   </p>
</div>
