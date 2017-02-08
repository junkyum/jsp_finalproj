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
	
	document.getElementById("mk_indiv_friend").style.width="25%";
	$("#mk_indiv_friend").delay(1000).animate({
		left:0
	},"clip")
	$("#mk_indiv_friend").show("slide",1000);
	
	$(function(){
		$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			var active=$(this).attr("aria-controls");
			friend(active);
		});
	});
	function friend(mode) {
	var url="<%=cp%>/"+mode;
		$.get(url, {dumi:new Date().getTime()}, function(data){
			var s=$.trim(data);
			if(s=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;
			}
			var id="#tabFriendList";
			if(mode=="add")
				id="#tabFriendAdd";
			else if(mode=="block")
				id="#tabFriendBlock";
			$(id).html(data);
		});
	}
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
					var f = document.createdForm;
				    var formData = new FormData(f);
					$.ajax({
						type:"post",
						url :"<%=cp%>/group/created",
						processData: false,
						contentType: false,
						data : formData,
						dataType:"json",
						beforeSend:jkcheck,
						success:function(data){
							if(data.res=="false"){
							   alert("안만들어짐");					
							}else {
								$('#groupName').val("");
								$('#introduce').val("");
								$('#place').val("");
								$('#keyword').val("");
								$('#upload').val("");
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
					var searchKey=$('#searchKey').val();
					var searchValue=$('#searchValue').val();
					$.get(url,{searchKey:searchKey,searchValue:searchValue}, function(data) {
						$("#grouplist").html(data);
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
	var searchKey=$('#searchKey').val();
	var searchValue=$('#searchValue').val();
	$.get(url,{page:page,searchKey:searchKey,searchValue:searchValue}, function(data) {
		$("#grouplist").html(data);
	});
}
function listClear(page) {
	var url="<%=cp%>/group/list";
	$.get(url,{page:page}, function(data) {
		$("#grouplist").html(data);
		
	});
}
function jkcheck(){
	var f = document.createdForm;
	if(!f.groupName.value) {
		alert('이름을 입력하세요');
		f.upload.focus();
		return false;
	}
	if(!f.introduce.value) {
		alert('소개를 입력하세요');
		f.upload.focus();
		return false;
	}
	if(!f.place.value) {
		alert('장소를 입력하세요');
		f.upload.focus();
		return false;
	}
	if(!f.keyword.value) {
		alert('키워드를 입력하세요');
		f.upload.focus();
		return false;
	}
	if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
		alert('이미지 파일만 가능합니다. !!!');
		f.upload.focus();
		return false;
	}
	return true;
}
</script>


<style type="text/css">
#mk_content {
	text-align: center;
	float : left;
	width: 100%;
	height:500px;
}
#mk_indiv {
	text-align: center;
	height: 100%;
	float: left;
	padding-top: 20px;	
}
.mk_indiv_in {
	display: inline-block;
}
#mk_group {
	text-align: center;
	height: 100%;
	float: left;	
	padding-top: 20px;
}
.mk_group_in {
	display: inline-block;
}
#mk_indivMenu {
	text-align: center;
	height: 100%;
	float: left;	
	padding-top: 50px;
	display: none;
}
#mk_groupMenu {
	text-align: center;
	height: 100%;
	float: left;
	padding-top: 50px;
	display: none;	
}
#mk_indiv_friend {
	text-align: center;
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
		<div role="button"  style="width: 100%; height: 40px">
			<ul class="mk_nav-tabs" role="tablist">
				<li role="button" class="active" style="width: 61px">
					<a href="#tabFriendList" aria-controls="list" role="tab" data-toggle="tab">친구목록</a>
				</li>
				<li role="button" style="width: 61px">
					<a href="#tabFriendAdd" aria-controls="add" role="tab" data-toggle="tab">친구추가</a>
				</li>
				<li role="button" style="width: 61px">
					<a href="#tabFriendBlock" aria-controls="block" role="tab" data-toggle="tab">차단관리</a>
				</li>
			</ul>
		</div>
		<div class="tab-content" style="padding: 5px; margin-top: 15px;">
				<!--  친구 목록 ///  신청받은 목록 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
				<div role="tabpanel" class="tab-pane active" id="tabFriendList">
					<!--  친구 목록 -->
					<div style="float: left; width: 49%; height: 400px;">
						<div class="listFriend" style="height: 380px;">
								
						</div>
						<div style="clear: both; padding-top: 10px;">
							<button type="button" class="btn btn-default btn-sm wbtn"
								onclick="">쪽지</button>
						</div>
					</div>
					<!-- 신청받은 목록 -->
					<div style="float: right; width: 49%; height: 400px;">
						<div class="listFriend" style="height: 380px;">
							
						</div>
						<div style="clear: both; padding-top: 10px;">
							<button type="button" class="btn btn-default btn-sm wbtn"
								onclick="friendAccept();">수락</button>
							<button type="button" class="btn btn-default btn-sm wbtn"
								onclick="friendDenial();">거절</button>
						</div>
					</div>
				</div>
				<!-- 친구 검색  ////  신청 목록  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<div role="tabpanel" class="tab-pane" id="tabFriendAdd">
					<!-- 친구 검색 -->
					<div style="float: left; width: 49%; height: 400px;">
						<select id="friendKey" class="form-control"
							style="float: left; width: 40%; height: 30px; font-size: 13px">
							<option value="userId">ID</option>
							<option value="userName">이름</option>
						</select>
						<div class="input-group" style="float: right; width: 60%">
							<input type="text" id="friendValue" class="form-control input-sm"
								placeholder=""> <span class="input-group-btn">
								<button type="button" class="btn btn-default btn-sm wbtn"
									id="friendSearchButton" onclick="friendSearch();">검색</button>
							</span>
						</div>
						<div id="friendSearchList" class="listFriend" style="clear: both; height: 166px;">
							
						</div>
					</div>
					<!-- 신청 목록 -->
					<div id="friendAskList" class="listFriend">
						
					</div>
				</div>
				<!-- 친구 목록   ///  차단 목록  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<div role="tabpanel" class="tab-pane" id="tabFriendBlock">
					<!--  친구 목록 -->
					<div style="float: left; width: 49%; height: 400px;">
						<div class="listFriend" style="height: 380px;">
							
						</div>
						<div style="clear: both; padding-top: 10px;">
							<button type="button" class="btn btn-default btn-sm wbtn"
								onclick="friendBlock();">차단</button>
							<button type="button" class="btn btn-default btn-sm wbtn"
								onclick="friendDelete()';">삭제</button>
						</div>
					</div>
					<div style="float: right; width: 49%; height: 400px;">
						<div class="listFriend" style="height: 380px;">
							
						</div>
						<div style="clear: both; padding-top: 10px;">
							<button type="button" class="btn btn-default btn-sm wbtn"
								onclick="friendBlockAccept()';">차단 해제</button>
							<button type="button" class="btn btn-default btn-sm wbtn"
								onclick="friendBlockDelete()';">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	
	
	
</div><!-- 전체  div -->






<div id="divGroupMaker" style = "display:none;">
<form name = "createdForm" enctype="multipart/form-data">
이름:<input type="text" id="groupName" name="groupName" class="form-control"><br>
소개:<input type="text" id="introduce" name="introduce" class="form-control"><br>
장소:<input type="text" id="place" name="place" class="form-control"><br>
키워드:<input type="text" id="keyword" name="keyword" class="form-control"><br>
프로필 사진:<input type="file" id="upload" name="upload" class="form-control"><br>
</form>
</div>

<div id="divGroupFinder" style = "display:none;">

<div>
    <!-- 새로고침  -->
	<div style="float: left; width: 15%; min-width: 85px;">
		<button type="button" class="btn btn-default btn wbtn" onclick="listClear(1);" >
			<span class="glyphicon glyphicon-repeat"></span>
		</button>
	</div>
	<div style="float: left; width: 60%; min-width: 85px;">
		<form name = "findForm">
			<select id= "searchKey" name="searchKey" class="form-control" style = "width: 35% ; float: left; margin-right: 5%;">
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