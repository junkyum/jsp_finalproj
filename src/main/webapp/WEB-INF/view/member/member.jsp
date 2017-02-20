<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
 <style type="text/css">
.body{
background-image: url("<%=cp%>/res/images/bg.png");
}
.member-form {
  border:1px solid #999;
  background: white;/* 안에 공백색갈*/
  border-radius:10px;
  box-shadow:0px 0px 10px #000;
  
}
.member-form {
  box-sizing:border-box;
  padding-top:15px;
  margin-top:30px;
  margin-left:30% ;
  margin-right:30%;
  overflow: hidden;
}
</style> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
<script type="text/javascript">
function emailCheck() {
	 var email=$("#email").val();
	   if(!/^[0-9a-zA-Z_\-]+@[.0-9a-zA-Z_\-]+$/i.test(email)) { 
	      var str="이메일은 aaa@aaa.com 형식으로 입력합니다.";
	      $("#email").focus();
	      $("#email + .help-block").html(str);
	      return false;
	   }
	  
	var url = "<%=cp%>/member/emailCheck";
	var params ="email="+email;
	
	$.ajax({
		type:"POST",
		url:url,
		data:params,
		dataType:"JSON",
		success:function(data){
			var passed= data.passed;
			if(passed== "true"){
				 var str="<span style='color:blue;font-weight: bold;'>"+email+"</span> 이메일은 사용가능 합니다.";
		        $("#email + .help-block").html(str);
			}else {
				   var str="<span style='color:red;font-weight: bold;'>"+email+"</span> 이메일은 사용할수 없습니다.";
		            $("#email + .help-block").html(str);
		       		$("#email").val("");
		       		$("#email").focus();
		       		
			}
		}
		
	});
}
// 아이디 중복 검사
function userIdCheck() {
   var userId=$("#userId").val();
   if(!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) { 
      var str="아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
      $("#userId").focus();
      $("#userId + .help-block").html(str);
      return false;
   }
   
   var url="<%=cp%>/member/userIdCheck";
   var params="userId="+userId;
   $.ajax({
      type:"POST"
      ,url:url
      ,data:params
      ,dataType:"JSON"
      ,success:function(data) {
         var passed=data.passed;
         if(passed=="true") {
            var str="<span style='color:blue;font-weight: bold;'>"+userId+"</span> 아이디는 사용가능 합니다.";
            $("#userId + .help-block").html(str);
         } else {
            var str="<span style='color:red;font-weight: bold;'>"+userId+"</span> 아이디는 사용할수 없습니다.";
            $("#userId + .help-block").html(str);
            $("#userId").val("");
            $("#userId").focus();
         }
      }
   });
}

function check() {
   var f = document.memberForm;
   var str;
   
   str=f.userId.value;
   if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
      f.userId.focus();
      return false;
   }
   
   str = f.userPW.value;
   if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
      f.userPW.focus();
      return false;
   }
   
   if(f.userPWCheck.value != str) {
      $("#userPWCheck + .help-block").html("패스워드가 일치하지 않습니다.");
      f.userPWCheck.focus();
      return false;
   } else {
      $("#userPWCheck + .help-block").html("패스워드를 한번 더 입력해주세요.");
   }
   
    str = f.userName.value;
   str = $.trim(str);
    if(!str) {
        f.userName.focus();
        return false;
    }
    f.userName.value = str;
   
    str = f.birth.value;
    if(!isValidDateFormat(str)) {
        f.birth.focus();
        return false;
    }

    str = f.email.value;
    if(!isValidEmail) {
        f.email.focus();
        return false;
    }	
    
    str = f.tel1.value;
    if(!str) {
        f.tel1.focus();
        return false;
    }

    str = f.tel2.value;
    if(!/^(\d+)$/.test(str)) {
        f.tel2.focus();
        return false;
    }

    str = f.tel3.value;
    if(!/^(\d+)$/.test(str)) {
        f.tel3.focus();
        return false;
    }
    
    var mode="${mode}";
    if(mode=="created") {
       f.action = "<%=cp%>/member/member";
    } else if(mode=="update") {
       f.action = "<%=cp%>/member/update";
    }
    
    return true;
}
</script>
<div class="body" style = "background-color: #F6F6F6; height: 1080px; opacity:0.9;">
<br>
<div style="text-align: center; font-size: 20pt; color: white; opacity:0.9;" >
    <span class="glyphicon glyphicon-user"></span>회원가입
</div>
<div class="member-form" style="opacity:0.9;">
 <form class="form-horizontal" name="memberForm" method="post" onsubmit="return check();"  style="margin-left: 40px; margin-top:10px;margin-right:auto; width: 600px" >
    <div class="form-group" >
        <label class="col-sm-2 control-label" for="userId">아이디</label>
        <div class="col-sm-7">
            <input class="form-control" id="userId" name="userId" type="text" placeholder="아이디"
                       onchange="userIdCheck();"
                       value="${dto.userId}"
                       ${mode=="update" ? "readonly='readonly' style='border:none;'":""}>
            <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="userPW">패스워드</label>
        <div class="col-sm-7">
            <input class="form-control" id="userPW" name="userPW" type="password" placeholder="비밀번호">
            <p class="help-block">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="userPWCheck">패스워드 확인</label>
        <div class="col-sm-7">
            <input class="form-control" id="userPWCheck" name="userPWCheck" type="password" placeholder="비밀번호 확인">
            <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="userName">이름</label>
        <div class="col-sm-7">
            <input class="form-control" id="userName" name="userName" type="text" placeholder="이름"
                       value="${dto.userName}" ${mode=="update" ? "readonly='readonly' style='border:none;' ":""}>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="birth">생년월일</label>
        <div class="col-sm-7">
            <input class="form-control" id="birth" name="birth" type="text" placeholder="생년월일" value="${dto.birth}">
            <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
        </div>
    </div>
 <div class="form-group">
        <label class="col-sm-2 control-label" for="gender">성별</label>
            <label style="padding-left: 10px;padding-top: 5px;padding-right: 10px">
                 <input type="radio" name="gender" id="gender" value="남자">남자&nbsp;
                 <input type="radio" name="gender" id="gender" value="여자">여자&nbsp;
            </label>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="email">이메일</label>
        <div class="col-sm-7">
            <input class="form-control" id="email" name="email" type="email" placeholder="이메일" onchange="emailCheck();" value="${dto.email}"  >
              <p class="help-block">이메일은 aaa@aaa.com 형식으로 입력합니다.</p>
        
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="email">전화번호</label>
        <div class="col-sm-7">
             <div class="row">
                  <div class="col-sm-3" style="padding-right: 5px;">
                    <select class="form-control" id="tel1" name="tel1" style="width: 80px" >
                        <option value="">선 택</option>
                        <option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
                        <option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
                        <option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
                        <option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
                        <option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
                        <option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
                    </select>
                  </div>
                  <div class="col-sm-1" style="width: 1%; padding-left: 5px; padding-right: 10px;">
                         <p class="form-control-static">-</p>
                  </div>
                 <div class="col-sm-2" style="padding-left: 5px; padding-right: 5px;width: 70px">
                     <input class="form-control" id="tel2" name="tel2" type="text" value="${dto.tel2}" maxlength="4">
                  </div>
                  <div class="col-sm-1" style="width: 1%; padding-left: 5px; padding-right: 10px;">
                         <p class="form-control-static">-</p>
                  </div>
                  <div class="col-sm-2" style="padding-left: 5px; padding-right: 5px;width: 70px">
                    <input class="form-control" id="tel3" name="tel3" type="text" value="${dto.tel3}" maxlength="4">
                  </div>
             </div>
        </div>
    </div>
  <div class="form-group">
        <label class="col-sm-2 control-label" for="keyword" >관심 사항</label>
            <label style="padding-left: 10px;padding-top: 5px;padding-right: 10px">
                 <input type="checkbox" name="keyword" id="keyword" value="여행">여행&nbsp;
                 <input type="checkbox" name="keyword" id="keyword" value="스터디">스터디&nbsp;
                 <input type="checkbox" name="keyword" id="keyword" value="운동">운동&nbsp;
                 <input type="checkbox" name="keyword" id="keyword" value="만남">만남&nbsp;
                 <input type="checkbox" name="keyword" id="keyword" value="식사">식사&nbsp;
                 <input type="checkbox" name="keyword" id="keyword" value="영화">영화&nbsp;    
                 <input type="checkbox" name="keyword" id="keyword" value="노래">노래&nbsp;
              </label>
   
    </div>
    
    <div class="form-group">
        <label class="col-sm-2 control-label" for="area">지역</label>
        <div class="col-sm-7">
            <input class="form-control" id="area" name="area" type="text" placeholder="지역">
        </div>
    </div>
    
    
    
<c:if test="${mode=='created'}">
    <div class="form-group">
        <label class="col-sm-2 control-label" for="agree">약관 동의</label>
        <div class="col-sm-7 checkbox">
            <label>
                <input id="agree" name="agree" type="checkbox" checked="checked"
                         onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
            </label>
        </div>
    </div>
</c:if>
     
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
<c:if test="${mode=='created'}">
            <button type="submit" name="sendButton"><img src="<%=cp%>/res/images/btn_submit.gif"></button>
            <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/';">가입취소 <span class="glyphicon glyphicon-remove"></span></button>
</c:if>            
<c:if test="${mode=='update'}">
            <button type="submit" class="btn btn-default btn-sm wbtn">정보수정 <span class="glyphicon glyphicon-ok"></span></button>
            <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/';">수정취소 <span class="glyphicon glyphicon-remove"></span></button>
</c:if>   
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
                <p class="form-control-static">${message}</p>
        </div>
    </div>
  </form>
</div>
</div>