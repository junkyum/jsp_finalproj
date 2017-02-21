<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    	String cp = request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>
<style>
.button{
 background: none;
 border: none;
}
.dot {
  height: 18px;
  width: 18px;
  margin-bottom:10px;
  border:3px solid #bbb;
  background-color: white;
  border-radius: 50%;
  transition: background-color 0.6s ease;
}
.dotbar{
  position: absolute;
  top:50%;
  left:3%;
}
.dot:HOVER{
height: 18px;
width: 18px;
border:none;
background-color:gray;
}
.bottombar {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
    position: fixed;
    bottom: 0;
    width: 100%;
}

.bottombar li {
    float: left;
    
}

.bottombar li a {
    display: block;
    color: white;
    text-align: center;
    padding: 10px 10px;
    text-decoration: none;
    font-size: 15pt;
}

.bottombar li a:hover:not(.active) {
    background-color: #111;
}

.active {
    background-color: #4CAF50;
}
</style>
<script type="text/javascript">
function groupUpdate(){
	var f = document.updateForm;
    var jkformData = new FormData(f);
	$.ajax({
		type:"post",
		url :"<%=cp%>/group/update",
		processData: false,
		contentType: false,
		data : jkformData,
		beforeSend:check,
		dataType:"json",
		success:function(data){
			if(data.res=="fail"){
			   alert("업데이트 실패");					
			}else {
				url="<%=cp%>/group?groupName=${dto.groupName}";
				location.href=url;
			}
		},error:function(e) {
	    	  console.log(e.responseText);
	      }
	
});
}
function groupDelete(){
	if(confirm("그룹을 삭제하시겠습니까?"))
	{
	url="<%=cp%>/group/delete?groupName=${dto.groupName}";
	location.href=url;
	}
}
function check(){
	var f = document.updateForm;
	if(!f.introduce.value) {
		alert('내용을 입력하세요');
		f.upload.focus();
		return false;
	}
	if(!f.place.value) {
		alert('내용을 입력하세요');
		f.upload.focus();
		return false;
	}
	if(!f.keyword.value) {
		alert('내용을 입력하세요');
		f.upload.focus();
		return false;
	}
	if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
		alert('이미지 파일만 가능합니다. !!!');
		f.upload.focus();
		return false;
	}
}
function menu(num){
	var userId="${dto.userId}";
	var groupName="${dto.groupName}";
	if(num==1){
	$("#yap").load("group/notice?userId="+userId+"&groupName="+groupName)
	}
	else if(num==2){
	$("#yap").load("group/sch?userId="+userId+"&groupName="+groupName)		
	}
	else if(num==3){
	$("#yap").load("groupGally/gally?groupName="+groupName)
	}
	else if(num==4){
	$("#yap").load("group/groupBoard?userId="+userId+"&groupName="+groupName)
	}
	else if(num==5){
	$("#yap").load("group/bbs?groupName="+groupName)
	}
}
$(function(){
	menu(1);
});
</script>
<div style="width: 100%; height: 100%;">
	<div class ="dotbar">
	  <div class="dot" onclick=" menu(1);"></div> 
	  <div class="dot" onclick=" menu(2);"></div> 
	  <div class="dot" onclick=" menu(3);"></div>
	  <div class="dot" onclick=" menu(4);"></div> 
	  <div class="dot" onclick=" menu(5);"></div> 
	</div>
<div id="yap" style="width:100%; height:100%; left: 5%;margin: auto;"  ></div>
<ul id="groupInfo" class="bottombar">
		<li >
			<img class="img-circle" alt="Cinque Terre" src="<%=cp%>/uploads/photo/${dto.profile}" style = "margin-bottom: 0px;" width="50" height="50">
		</li>
		<li data-toggle="modal" data-target="#infoModal" class="button">
		<a>${dto.groupName}</a>
		</li>
		<li>
        <a data-toggle="modal" data-target="#memberlistModal">회원목록</a>	
        </li>
		<c:if test="${res=='notyet' }">
		<li style="float:right;">
		<a href="<%=cp%>/group/signin?groupName=${dto.groupName}">가입</a>
		</li>
		</c:if>
		<c:if test="${res=='already'}">
		<li style="float:right;">
		<a href="<%=cp%>/group/signout?groupName=${dto.groupName}">탈퇴</a>
		</li>
		</c:if>
		<c:if test="${res=='owner' }">
		<li style="float:right;">
		<a onclick="groupDelete();">그룹삭제</a>
		</li>
		<li style="float:right;">
		<a data-toggle="modal" data-target="#updateModal">그룹수정</a>	
		</li>
		</c:if>
</ul>
</div>



<form name = "updateForm" enctype="multipart/form-data">
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">그룹업데이트</h4>
	      </div>
	      <div class="modal-body">
			소개:<input type="text" id="introduce" name="introduce" value ="${dto.introduce }" class="form-control"><br>
			장소:<input type="text" id="place" name="place" value ="${dto.place }" class="form-control"><br>
			키워드:<input type="text" id="keyword" name="keyword"  value ="${dto.keyword }" class="form-control"><br>
			프로필 사진:<input type="file" id="upload" name="upload" value ="${dto.profile }" class="form-control"><br>
			현재 프로필<br>
			<img class="img-responsive" src="<%=cp%>/uploads/photo/${dto.profile}"><br>
	      	<input type = "hidden" id="groupName" name = "groupName" value="${dto.groupName}">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" onclick="groupUpdate();">업데이트하기</button>
	      </div>
    </div>
  </div>
</div>
</form>
<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">그룹정보</h4>
	      </div>
	      <div class="modal-body">
	      	이름:<input type="text" id="groupName" name ="groupName" value="${dto.groupName}" readonly="readonly" class="form-control"><br>
			소개:<input type="text" id="introduce" name="introduce" value ="${dto.introduce }" readonly="readonly" class="form-control"><br>
			장소:<input type="text" id="place" name="place" value ="${dto.place }" readonly="readonly"class="form-control"><br>
			키워드:<input type="text" id="keyword" name="keyword"  value ="${dto.keyword }" readonly="readonly" class="form-control"><br>
			프로필 사진:<img class="img-responsive" src="<%=cp%>/uploads/photo/${dto.profile}"><br>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="memberlistModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">멤버리스트</h4>
	      </div>
	      <div class="modal-body">
	       <c:forEach var="list" items="${memberlist}">
			    <li style="clear: both;">
			    ${list.userId }
			    </li>
			  </c:forEach>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
    </div>
  </div>
</div>
