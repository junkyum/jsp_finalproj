<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();

%>

<div class="jumbotron" style="text-align: center">
    <h2>${title}</h2>
</div>

<div class="bodyFrame">
   <p class="lead text-center">${message}</p>
   <p style="width:100%;" align="center">
      <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/';"> 메인화면으로 이동 &raquo; </button>
   </p>
</div>
