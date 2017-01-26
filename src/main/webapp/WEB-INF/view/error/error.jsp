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
            <h4><strong>에러!</strong></h4>
              시스템에 에러가 발생 했습니다. 잠시후 다시 시도 하시기 바랍니다.
    </div>

    <p>
          <button type="button" class="btn btn-default btn-lg btn-block" onclick="javascript:location.href='<%=cp%>/';"> 메인화면으로 이동 &raquo; </button>
    </p>
</div>    
    
</div>