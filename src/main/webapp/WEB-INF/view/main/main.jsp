<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    	String cp = request.getContextPath();
%>
<script type="text/javascript">
$(document).ready(function(){
	$('#friend_page').click(function() {
		$("#mk_friend").load("friend/friend");
		document.getElementById("mk_indiv").style.width="49%";
		document.getElementById("mk_indivMenu").style.width="0";
		document.getElementById("mk_group").style.width="0";
		document.getElementById("mk_groupMenu").style.width="0";
		document.getElementById("note_mk").style.display="none";
		document.getElementById("mk_friend").style.width="49%";
		document.getElementById("mk_friend").style.float="left";
		$("#mk_friend").delay(1000).animate({
			left:0
		},"clip")
		$("#mk_friend").show("slide",1000);
	});
	
	$('#mk_note').click(function() {
		$("#note_mk").load("note/note");
		document.getElementById("mk_indiv").style.width="49%";
		document.getElementById("mk_indivMenu").style.width="0";
		document.getElementById("mk_group").style.width="0";
		document.getElementById("mk_groupMenu").style.width="0";
		document.getElementById("mk_friend").style.display="none";
		document.getElementById("note_mk").style.width="33%";
		document.getElementById("note_mk").style.float="left";
		$("#note_mk").delay(1000).animate({
			left:0
		},"clip")
		$("#note_mk").show("slide",1000);
	});
	
});

function mk_main_indiv() {
	document.getElementById("mk_indiv").style.width="49%";
	document.getElementById("mk_indivMenu").style.width="49%";
	document.getElementById("mk_group").style.width="0";
	document.getElementById("mk_groupMenu").style.width="0";
	document.getElementById("note_mk").style.display="none";
	document.getElementById("mk_friend").style.display="none";
	$("#mk_indivMenu").delay(1000).animate({
		left:0
	},"clip")
	$("#mk_indivMenu").show("slide",1000);
}
function mk_main_group() {
	document.getElementById("mk_indiv").style.width="0";
	document.getElementById("mk_indivMenu").style.width="0";
	document.getElementById("mk_group").style.width="49%";
	document.getElementById("mk_groupMenu").style.width="49%";
	document.getElementById("note_mk").style.display="none";
	document.getElementById("mk_friend").style.display="none";
	$("#mk_groupMenu").delay(1000).animate({
		left:0
	},"clip")
	$("#mk_groupMenu").show("slide",1000);
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
	width: 49%;
	height: 500px;
	float: left;
	padding-top: 20px;	
}
.mk_indiv_in {
	display: inline-block;
}
#mk_group {
	text-align: center;
	width: 49%;
	height: 500px;
	float: left;	
	padding-top: 20px;
}
.mk_group_in {
	display: inline-block;
}
#mk_indivMenu {
	text-align: center;
	width: 49%;
	height: 500px;
	float: left;	
	padding-top: 50px;
	display: none;
}
#mk_groupMenu {
	text-align: center;
	width: 49%;
	height: 500px;
	float: left;
	padding-top: 50px;
	display: none;	
}
#_mk_friend {
	text-align: center;
	width: 33%;	
	height: 500px;
	float: left;	
	padding-top:50px;
}
#note_mk {
	text-align: center;
	width: 49%;	
	height: 500px;
	float: left;	
	padding-top:50px;
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
	<!-- 개인 -->
	<div id="mk_indiv">
		<div class="mk_indiv_in">
			<button type="button" onclick="mk_main_indiv();"  class="btn_mk"  style="background-color:#FFFFFF; border: 0px;">
				<img src="<%=cp%>/res/images/indiv.png" style="width: 60%; height: 240px;">
			</button>
		</div>
	</div>
	
		
	<!-- 그룹 -->
	<div id="mk_group">
		<div class="mk_group_in">
			<button type="button" onclick="mk_main_group();"  class="btn_mk" style="background-color:#FFFFFF; border: 0px;" >
				<img src="<%=cp%>/res/images/group.jpg" style="width: 80%;">
			</button>
		</div>
	</div>
	
	<!-- 개인 메뉴바 -->
	<div id="mk_indivMenu">
		<div>
			<a id=friend_page>
				<img src="<%=cp%>/res/images/img_A.png" style="width: 25%; height: 135px;">
			</a>
		
			<a id=mk_note>
				<img src="<%=cp%>/res/images/img_B.png" style="width: 25%; height: 135px;">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/tboard/list">
				<img src="<%=cp%>/res/images/img_C.png" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/tphoto/list">
				<img src="<%=cp%>/res/images/img_D.png" style="width: 25%; height: 135px;">
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
	<div id="mk_friend"></div>
	<div id="note_mk"></div>
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