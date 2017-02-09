<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    	String cp = request.getContextPath();
%>

<script type="text/javascript">
$(function(){
	$("#groupTap").tabs();
});
</script>
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
			   alert("안만들어짐");					
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
</script>


<div style="margin-left: 50px;">
	<div id="left" style="float: left; width: 200px; height: 700px;">
		<div id="groupInfo" style="margin-bottom: 20px; height: 200px; border: 1px solid black;">
			<img class="img-responsive" src="<%=cp%>/uploads/photo/${dto.profile}" style = "margin-bottom: 0px;"><br>
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#infoModal">
 			${dto.groupName}
			</button><br>
			
			<c:if test="${res=='notyet' }">
			<button type="button" onclick="javascript:location.href='<%=cp%>/group/signin?groupName=${dto.groupName}';">
			가입
			</button>
			</c:if>
			
			<c:if test="${res=='already' }">
			<button type="button" onclick="javascript:location.href='<%=cp%>/group/signout?groupName=${dto.groupName}';">
			탈퇴
			</button>
			</c:if>
			
			<c:if test="${res=='owner' }">
			<button type="button" data-toggle="modal" data-target="#updateModal">
 			그룹수정
			</button>
			<button type="button" onclick="groupDelete();">
			그룹삭제
			</button>
			</c:if>
			
			<div class="dropdown">
			  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
			    내 그룹 목록
			    <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
				<c:forEach var="vo" items="${myList}">
			    <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:location.href='<%=cp%>/group?groupName=${vo.groupName}';">
			    ${vo.groupName }</a></li>
				</c:forEach>
			  </ul>
			</div>
				<div class="dropdown">
			  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
			  그룹 회원 목록
			    <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
				<c:forEach var="list" items="${memberlist}">
			    <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:location.href='<%=cp%>/?userId=${list.userId}';">
			    ${list.userId }</a></li>
				</c:forEach>
			  </ul>
			</div>
		</div>
		<div style="height: 480px; border: 1px solid black;">
		
		</div>
		
	</div>
	
	<div  id="groupTap" style = "float: left; margin-left:2% ; width:77%; height:700px; border: 1px solid black;">
	  	<ul >
		<li ><a href="<%=cp%>/group/notice?userId=${dto.userId}&groupName=${dto.groupName}"><span>공지사항</span></a></li>
		<li ><a href="<%=cp%>/sch/sch"><span>그룹스케줄</span></a></li>
		<li ><a href="<%=cp%>/groupGally/gally?groupName=${dto.groupName}"><span>그룹갤러리</span></a></li>
		<li ><a href="<%=cp%>/group/groupBoard?userId=${dto.userId}&groupName=${dto.groupName}"><span>게시판</span></a></li>
		<li ><a href="<%=cp%>/group/bbs?groupName=${dto.groupName}"><span>답변형게시판</span></a></li>
		</ul>
	</div>
	
	<div style="clear:both;">
	</div>
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
