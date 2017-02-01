<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    	String cp = request.getContextPath();
%>

<script src="//code.jquery.com/jquery-1.10.2.js"></script> 
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript">
function mk_main_indiv() {
	document.getElementById("mk_indiv").style.width="50%";
	document.getElementById("mk_indivMenu").style.width="50%";
	
	document.getElementById("mk_group").style.width="0";
	document.getElementById("mk_groupMenu").style.width="0";
	
	document.getElementById("mk_indiv_friend").style.width="0";
	$("#mk_indivMenu").delay(1000).animate({
		left:0
	},"clip")
	$("#mk_indivMenu").show("slide",1000);
}
function mk_main_group() {
	document.getElementById("mk_indiv").style.width="0";
	document.getElementById("mk_indivMenu").style.width="0";
	
	document.getElementById("mk_group").style.width="50%";
	document.getElementById("mk_groupMenu").style.width="50%";
	
	document.getElementById("mk_indiv_friend").style.width="0";
	$("#mk_groupMenu").delay(1000).animate({
		left:0
	},"clip")
	$("#mk_groupMenu").show("slide",1000);
}
function mk_indiv_friend() {
	document.getElementById("mk_indiv").style.width="50%";
	document.getElementById("mk_indivMenu").style.width="0";
	
	document.getElementById("mk_group").style.width="0";
	document.getElementById("mk_groupMenu").style.width="0";
	
	document.getElementById("mk_indiv_friend").style.width="50%";
	$("#mk_indiv_friend").delay(1000).animate({
		left:0
	},"clip")
	$("#mk_indiv_friend").show("slide",1000);
}
function maker(){
	    $("#divGroupMaker").dialog({
	       title:"그룹만들기",
	       modal:true,
	       width:300,
	       height:300,
		   show:"clip",
		   hide:"clip",
		   buttons:{
				"만들기":function(){
					alert("야호");
				},"취소":function(){
					$(this).dialog("close");
				}
			}
	    });
}
function finder(){
	    $("#divGroupFinder").dialog({
	       title:"그룹찾기",
	       modal:true,
	       width:400,
	       height:200,
		   show:"clip",
		   hide:"clip",
		   buttons:{
				"찾기":function(){
					alert("야호");
				},"취소":function(){
					$(this).dialog("close");
				}
			}
	    });
}
function grouplist(){
	alert("그룹리스트");
}
function map(){
	alert("맵");
}
function option(){
	alert("설정");
}
</script>


<style type="text/css">
#mk_content {
	float:left;
	width: 100%;
	height:500px;
}
#mk_indiv {
	text-align: center;
	width: 49%;
	height: 100%;
	float: left;
	padding-top: 20px;	
}
.mk_indiv_in {
	display: inline-block;
}
#mk_group {
	text-align: center;
	width: 49%;
	height: 100%;
	float: left;	
	padding-top: 20px;
}
.mk_group_in {
	display: inline-block;
}
#mk_indivMenu {
	text-align: center;
	width: 50%;
	height: 100%;
	float: left;	
	padding-top: 50px;
	display: none;
}
#mk_groupMenu {
	text-align: center;
	width: 50%;
	height: 100%;
	float: left;
	padding-top: 50px;
	display: none;	
}
#mk_indiv_friend {
	text-align: center;
	width : 25%;
	float: left;
	padding-top: 50px;
	display: none;
}
div.friendScroll {
	scrollbar-highlight-color:#FFFFFF;
	scrollbar-shadow-color:#FFFFFF;
	scrollbar-arrow-color:#B4751B;
	scrollbar-face-color:#FFFFFF;
	scrollbar-3dlight-color:#FFFFFF;
	scrollbar-darkshadow-color:#FFFFFF;
	scrollbar-track-color:#FFFFFF;
	overflow:auto;
}
.jkbutton{
	background:none;
	border:none;
}
</style>


<div id="mk_content">

	<!-- 개인 222222-->
	<div id="mk_indiv">
	
		<div class="mk_indiv_in">
			<button type="button" onclick="mk_main_indiv();"  id="btn_indiv"  style="background-color:#FFFFFF; border: 0px;">
				<img src="<%=cp%>/res/images/indiv.png" style="width: 80%">
			</button>
		</div>
	</div>
	
		
	<!-- 그룹 -->
	<div id="mk_group">
	
		<div class="mk_group_in">
			<button type="button" onclick="mk_main_group();"  id="btn_group" style="background-color:#FFFFFF; border: 0px;" >
				<img src="<%=cp%>/res/images/group.png" style="width: 80%;">
			</button>
		</div>
	</div>
	
	<!-- 개인 메뉴바 -->
	<div id="mk_indivMenu">
		<div>
			<button type="button" onclick="mk_indiv_friend();"  id="btn_indiv_friend"  style="border: 0px; width:25%;">
				<img src="<%=cp%>/res/images/img_A.jpg" style="width: 100%; height: 135px;">
			</button>
		
			<a href="<%=cp%>/tboard/list">
				<img src="<%=cp%>/res/images/img_B.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_C.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_D.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_E.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_F.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
	</div>
	
	<!-- 그룹 메뉴바 -->
	<div id="mk_groupMenu">
		<div>
			<button type="button" onclick="maker();" class="jkbutton">
				<img src="<%=cp%>/res/images/maker.png" style="width: 135px; height: 135px;">
			</button>
		
			<button type="button" onclick="finder();" class="jkbutton">
				<img src="<%=cp%>/res/images/finder.png" style="width: 135px; height: 135px;">
			</button>
		</div>
		<div>
			<button type="button" onclick="grouplist();" class="jkbutton">
				<img src="<%=cp%>/res/images/mygroup.png" style="width: 135px; height: 135px;">
			</button>
		
			<button type="button" onclick="map();" class="jkbutton">
				<img src="<%=cp%>/res/images/map.png" style="width: 135px; height: 135px;">
			</button>
		</div>
		<div>
			<button type="button" onclick="option();" class="jkbutton">
				<img src="<%=cp%>/res/images/option.png" style="width: 135px; height: 135px;">
			</button>
			<button type="button" onclick="javascript:location.href='<%=cp%>/';" class="jkbutton">
				<img src="<%=cp%>/res/images/home.png" style="width: 135px; height: 135px;">
			</button>
		</div>
	</div>
	
	<!-- 개인 친구 -->
	<div id="mk_indiv_friend">
		<table class="friend_table" style="margin: 0px auto; width:500px ;height: 400px; " border="1">
			<tr style="height: 1px">
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
			</tr>
			<tr style="height: 20px;">
				<td colspan="3">친구 검색</td>
				<td colspan="2">input 예정</td>
			</tr>
			<tr>
				<td colspan="5">
					<div class="friendScroll" style="height: 400px">
						<table border="1" style="width:480px; border-style: hidden hidden solid hidden;">
							<c:set var="friendCount" value="15" />
							
							
							
							
							
							
							 <c:forEach var="index" begin="0" end="30" step="1">
								<tr>
									<td style="width:75%;"> 친구 이름</td>
									<td style="width:25%;"> 쪽지|수정 |삭제</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</td>
			</tr>
			<tr style="height: 1px">
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
				<td style="width: 20%"></td>
			</tr>
		</table>
	</div>
	
	
	
</div><!-- 전체  div -->

<div id="divGroupMaker" style = "display:none;">
<form >
이름:<input type="text" id="name" name="name"><br>
소개:<input type="text" id="intro" name="intro"><br>
장소:<input type="text" id="place" name="place"><br>
키워드:<input type="text" id="keyword" name="keyword"><br>
</form>
</div>

<div id="divGroupFinder" style = "display:none;">
<form >
<select name="searchKey">
<option value="name">이름</option>
<option value="place">장소</option>
<option value="keyword">키워드</option>
</select>
<input type="text" name="searchValue"><br>
</form>
</div>
