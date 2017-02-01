<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" type="text/css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript">
$(function(){
	$("#tapmenu").tabs();
});
</script>

<div style="margin-left: 50px;">
	<div id="left" style="float: left; width: 200px; height: 700px;">
		<div style="margin-bottom: 20px; height: 200px; border: 1px solid black;">
			그룹정보..<br> 
			그룹이름<br> 
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
		<li><a href="<%=cp%>/gnotice"><span>공지사항</span></a></li>
		<li><a href="<%=cp%>/group/sch"><span>그룹스케줄</span></a></li>
		<li><a href="<%=cp%>/groupGally/list"><span>그룹갤러리</span></a></li>
		<li><a href="<%=cp%>/group/bbs"><span>게시판</span></a></li>
		</ul>
	</div>
	
	<div style="clear:both;">
	</div>
</div>
