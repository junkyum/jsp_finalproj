<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.form-signin {
  max-width: 400px;
  padding: 15px;
  margin: 0 auto;
}

@media (min-width: 768px) {
  .form-signin {
    padding-top: 70px;
  }
}

.form-signin-heading {
  text-align: center;
  font-weight:bold;  
  font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", sans-serif;
  margin-bottom: 30px;
}

.lbl {
   position:absolute; 
   margin-left:15px; margin-top: 13px;
   color: #999999;
   font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.loginTF {
  max-width: 370px; height:45px;
  padding: 5px;
  padding-left: 15px;
  margin-top:5px; margin-bottom:15px;
}
</style>

<script type="text/javascript">
function bgLabel(ob, id) {
       if(!ob.value) {
          document.getElementById(id).style.display="";
       } else {
          document.getElementById(id).style.display="none";
       }
}

function sendLogin() {
       var f = document.loginForm;

       var str = f.userId.value;
        if(!str) {
            f.userId.focus();
            return false;
        }

        str = f.userPW.value;
        if(!str) {
            f.userPW.focus();
            return false;
        }

    
        f.submit();
}
</script>
<div class="bodyFrame">

    <form class="form-signin" name="loginForm" method="post"  action = "<%=cp%>/member/login_check">
        <h2 class="form-signin-heading">Log In</h2>
        <label for="userId" id="lblUserId" class="lbl">아이디</label>
        <input type="text" id="userId" name="userId" class="form-control loginTF" autofocus="autofocus"
                  onfocus="document.getElementById('lblUserId').style.display='none';"
                 onblur="bgLabel(this, 'lblUserId');">
        <label for="userPw" id="lblUserPwd" class="lbl">패스워드</label>
        <input type="password" id="userPW" name="userPW" class="form-control loginTF"
                  onfocus="document.getElementById('lblUserPwd').style.display='none';"
                 onblur="bgLabel(this, 'lblUserPwd');">
        		
        <div style="margin-top:10px; text-align: center;">
	        <button class="btn btn-lg btn-primary btn-block" type="button" onclick="sendLogin();">로그인 <span class="glyphicon glyphicon-ok"></span></button>
            <button type="button" class="btn btn-link" onclick="location.href='<%=cp%>/member/member';">회원가입</button>
            <button type="button" class="btn btn-link">아이디찾기 </button>
            <button type="button" class="btn btn-link">패스워드찾기</button>
        </div>
        
        <div style="margin-top:10px; text-align: center;">${message}</div>
        
    </form>

</div>