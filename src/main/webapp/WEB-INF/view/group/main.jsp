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
			그룹정보..<br> 
			${dto.groupName }<br> 
			그룹사진<br>
		</div>
		<div style="height: 480px; border: 1px solid black;">
			<div class="btn-group"> 
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown" aria-expanded="false">
				준겸 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a href="#">쪽지하기</a></li>
				<li><a href="#">채팅하기</a></li>
			</ul>
			</div>
			<br>
			<div class="btn-group"> 
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown" aria-expanded="false">
				경미 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a href="#">쪽지하기</a></li>
				<li><a href="#">채팅하기</a></li>
			</ul>
			</div>
			<br>
			<div class="btn-group"> 
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown" aria-expanded="false">
				김철<span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a href="#">쪽지하기</a></li>
				<li><a href="#">채팅하기</a></li>
			</ul>
			</div>
			<br>
			<div class="btn-group"> 
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown" aria-expanded="false">
				문구 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a href="#">쪽지하기</a></li>
				<li><a href="#">채팅하기</a></li>
			</ul>
			</div>
			<br>
			<div class="btn-group"> 
			<button type="button" class="btn btn-default dropdown-toggle"
				data-toggle="dropdown" aria-expanded="false">
				세영 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
				<li><a href="#">쪽지하기</a></li>
				<li><a href="#">채팅하기</a></li>
			</ul>
			</div>
			<br>
		</div>

	</div>
	
	<div id = "tapmenu" style = "float: left; margin-left:2% ; width:77%; height:700px; border: 1px solid black;">
	  	<ul>
		<li><a href="<%=cp%>/group/notice"><span>공지사항</span></a></li>
		<li><a href="<%=cp%>/group/sch"><span>그룹스케줄</span></a></li>
		<li><a href="<%=cp%>/groupGally/gally"><span>그룹갤러리</span></a></li>
		<li><a href="<%=cp%>/group/groupBoard"><span>게시판</span></a></li>
		</ul>
	</div>
	
	<div style="clear:both;">
	</div>
</div>
