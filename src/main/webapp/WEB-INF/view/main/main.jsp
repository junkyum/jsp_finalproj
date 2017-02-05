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
	       width:400,
	       height:700,
		   show:"clip",
		   hide:"clip",
		   buttons:{
				"만들기":function(){
					var url="<%=cp%>/group/created";
					var query=$('form[name=createdForm]').serialize();
					$.ajax({
						type:"post",
						url :url,
						data : query,
						dataType:"json",
						success:function(data){
							var result = data.result;
							if(data.res=="false"){
							   alert("안만들어짐");					
							}else {
								$('#groupName').val("");
								$('#introduce').val("");
								$('#place').val("");
								$('#keyword').val("");
								$('#profile').val("");
								$("#divGroupMaker").dialog("close");
								listPage(1);
							}
							
						},error:function(e) {
					    	  console.log(e.responseText);
					      }
					
				});	
				},"취소":function(){
					$(this).dialog("close");
				}
			}
	    });
}
function finder(){
		listPage(1);
	    $("#divGroupFinder").dialog({
	       title:"그룹찾기",
	       modal:true,
	       width:500,
	       height:600,
		   show:"clip",
		   hide:"clip",
		   buttons:{
				"찾기":function(){
					var url="<%=cp%>/group/list";
					var query=$('form[name=findForm]').serialize();
					$.ajax({
						type:"post",
						url :url,
						data : query,
						dataType:"json",
						success:function(data){
							if(data.res=="false")
							{
								listPage(1);
							}
							else {
							
								listPage(1);
							}
							
						},
						error:function(e) {
					    	  console.log(e.responseText);
					    }
					
				});	
				},"취소":function(){
					$(this).dialog("close");
				}
			}
	    });
}
function grouplist(){
	
	var url="<%=cp%>/group/myGrouplist";
	$.get(url, function(data) {
		$("#myGroupList").html(data);
	});
    $("#myGroup").dialog({
       title:"내그룹",
       modal:true,
       width:500,
       height:600,
	   show:"clip",
	   hide:"clip",
	   buttons:{
			"닫기":function(){
				$(this).dialog("close");
			}
		}
    });
}
function map(){
	alert("맵");
}
function option(){
	alert("설정");
}
function listPage(page) {
	var url="<%=cp%>/group/list";

	$.get(url,{page:page}, function(data) {
		$("#grouplist").html(data);
		
	});
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
				<img src="<%=cp%>/res/images/mm.png" style="width: 135px; height: 135px;">
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
<form name = "createdForm">
이름:<input type="text" id="groupName" name="groupName" class="form-control"><br>
소개:<input type="text" id="introduce" name="introduce" class="form-control"><br>
장소:<input type="text" id="place" name="place" class="form-control"><br>
키워드:<input type="text" id="keyword" name="keyword" class="form-control"><br>
프로필 사진:<input type="text" id="profile" name="profile" class="form-control"><br>
</form>
</div>

<div id="divGroupFinder" style = "display:none;">

<div>
    <!-- 새로고침  -->
	<div style="float: left; width: 15%; min-width: 85px;">
		<button type="button" class="btn btn-default btn wbtn" onclick="listPage(1);" >
			<span class="glyphicon glyphicon-repeat"></span>
		</button>
	</div>
	<div style="float: left; width: 60%; min-width: 85px;">
		<form name = "findForm">
			<select name="searchKey" class="form-control" style = "width: 35% ; float: left; margin-right: 5%;">
			<option value="name">이름</option>
			<option value="place">장소</option>
			<option value="keyword">키워드</option>
			</select>
			<input type="text" name="searchValue" id="searchValue" class="form-control" style = "width: 60%;float: left;"><br>
		</form>
	</div>
	<!--그룹만들기  -->
	<div style="float: left; width: 15%; min-width: 85px; text-align: right;">
			<button type="button" class="btn btn-default btn wbtn" onclick="maker();">
				<img src="<%=cp%>/res/images/maker.png" style="width: 20px; height: 20px;">
			</button>
	</div>
	<div id="grouplist"></div>
</div>

</div>
<div id="myGroup" style = "display:none;">
<div id="myGroupList">
</div>
</div>