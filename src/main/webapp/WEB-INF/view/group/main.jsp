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
</script>

<div style="margin-left: 50px;">
	<div id="left" style="float: left; width: 200px; height: 700px;">
		<div style="margin-bottom: 20px; height: 200px; border: 1px solid black;">
			${dto.groupName}<br> 
			그룹정보<br>
			그룹사진<br>
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
			<button type="button" onclick="javascript:location.href='<%=cp%>/group/update?groupName=${dto.groupName}';">
			그룹정보수정
			</button>
			<button type="button" onclick="javascript:location.href='<%=cp%>/group/delete?groupName=${dto.groupName}';">
			그룹탈퇴
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

<div id="divGroupMaker" style = "display:none;">
<form name = "createdForm">
이름:<input type="text" id="groupName" name="groupName" class="form-control"><br>
소개:<input type="text" id="introduce" name="introduce" class="form-control"><br>
장소:<input type="text" id="place" name="place" class="form-control"><br>
키워드:<input type="text" id="keyword" name="keyword" class="form-control"><br>
프로필 사진:<input type="text" id="profile" name="profile" class="form-control"><br>
</form>
</div>
