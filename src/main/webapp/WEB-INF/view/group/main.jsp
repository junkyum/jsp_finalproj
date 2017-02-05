<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    	String cp = request.getContextPath();
%>

<script type="text/javascript">
$(function(){
	$("#tapmenu").tabs();
});
function signin(){
	var url="<%=cp%>/group/signin";
	var query="groupName=${dto.groupName}";
	$.ajax({
		type:"post",
		url :url,
		data : query,
		dataType:"json",
		success:function(data){
			if(data.res=="fail"){
			 	alert("안들어갔다");	
			}else {
				alert("들어갔다");
			}
			
		},error:function(e) {
	    	  console.log(e.responseText);
	      }
	
});	
}
function signout(){
	var url="<%=cp%>/group/signout";
	var query="groupName="+${dto.groupName};
	$.ajax({
		type:"post",
		url :url,
		data : query,
		dataType:"json",
		success:function(data){
			if(data.res=="fail"){
			   alert("안나가짐");					
			}else {
				 alert("나가짐");	
			}
			
		},error:function(e) {
	    	  console.log(e.responseText);
	      }
	
    });	 
}
</script>

<div style="margin-left: 50px;">
	<div id="left" style="float: left; width: 200px; height: 700px;">
		<div style="margin-bottom: 20px; height: 200px; border: 1px solid black;">
			${dto.groupName}<br> 
			그룹정보<br>
			그룹사진<br>
			<c:if test=""></c:if>
			<button type="button" onclick="signin();">가입</button>
			<button type="button" onclick="signout();">탈퇴</button>
		</div>
		<div style="height: 480px; border: 1px solid black;">
			
		</div>
		
	</div>
	
	<div id = "tapmenu" style = "float: left; margin-left:2% ; width:77%; height:700px; border: 1px solid black;">
	  	<ul>
		<li><a href="<%=cp%>/group/notice?userId=${dto.userId}&groupName=${dto.groupName}"><span>공지사항</span></a></li>
		<li><a href="<%=cp%>/group/sch"><span>그룹스케줄</span></a></li>
		<li><a href="<%=cp%>/groupGally/gally?groupName=${dto.groupName}"><span>그룹갤러리</span></a></li>
		<li><a href="<%=cp%>/group/groupBoard?userId=${dto.userId}&groupName=${dto.groupName}"><span>게시판</span></a></li>
		</ul>
	</div>
	
	<div style="clear:both;">
	</div>
</div>
