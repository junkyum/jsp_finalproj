<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">

.alert-error {
    color:#b94a48;
    background-color:#f2dede;
    border-color:#eed3d7;
}

.boxLayout {
    max-width:500px;
    padding:20px;
    margin: 0 auto;
}

@media (min-width: 768px) {
  .boxLayout {
    margin-top: 70px;
  }
}

</style>
<div class="bodyFrame">

<div class="boxLayout">  
    <div class="alert alert-error">
            <h4><strong>확인!</strong></h4>
              파일은 최대 10MB까지만 업로드 가능합니다.
    </div>

    <p>
          <button type="button" class="btn btn-default btn-lg btn-block" onclick="javascript:location.href='<%=cp%>/';"> 메인화면으로 이동 &raquo; </button>
    </p>
</div>    
    
</div>