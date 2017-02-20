<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
       String cp = request.getContextPath();
%>
<script type="text/javascript">
function maker(){
       $("#divGroupMaker").dialog({
          title:"그룹만들기",
          modal:true,
          width:400,
          height:700,
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
function friend(){
	location.href="<%=cp%>/friend/friend"
}
function note(){
	$("#note_mk").load("note/note");
    $("#note_mk").dialog({
       title:"쪽지",
       modal:true,
       width:550,
       height:500
    });
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
function leftNav() {
    document.getElementById("leftnav").style.width = "50%";
}
function rightNav() {
    document.getElementById("rightnav").style.width = "50%";
}
function closeNav() {
    document.getElementById("leftnav").style.width = "0";
    document.getElementById("rightnav").style.width = "0";
}

</script>

<style type="text/css">
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
.cc {
  position: relative;
  width: 50%;
  margin: 0 auto 0;
}

.im {
  display: block;
  width: 100%;
  margin: 0;
}

.ol {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color: black;
}

.cc:hover .ol {
  opacity: 0.2;
}

.text {
  color: white;
  font-size: 20px;
  position: absolute;
  top: 55%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
}
.button{
 border: none;
 background: none;
}
.leftnav {
    height: 66%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 5%;
    right: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
    text-align: center;
    opacity: 0.7;
}
.rightnav {
    height: 66%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 5%;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
    text-align: center;
    opacity: 0.7;
}

.leftnav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 40px;
    color: #818181;
    display: block;
    transition: 0.3s
    
}
.rightnav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 40px;
    color: #818181;
    display: block;
    transition: 0.3s
}

.leftnav a:hover, .offcanvas a:focus{
    color: #f1f1f1;
}
.rightnav a:hover, .offcanvas a:focus{
    color: #f1f1f1;
}

.leftnav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}
.rightnav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}
</style>

<div style = "width: 100%;">
<div class="cc" style="float: left;" >
  <img src="<%=cp%>/res/images/back_1_1.png" class="im"  >
  <div class="ol"></div>
    <button class="text button" onclick="leftNav()"><img src="<%=cp%>/res/images/personal.png" ></button>
</div>

<div class="cc" style="float: left;">
  <img src="<%=cp%>/res/images/back_1_2.png"  class="im" >
  <div class="ol"></div>
   <button class="text button" onclick="rightNav()"><img src="<%=cp%>/res/images/group.png" ></button>
</div>

</div>

<div style = "width: 100%; border:1px solid lightgray; ">
<div class="cc" style="float: left; width: 25%; padding: 1%;" >
  <img src="<%=cp%>/res/images/bgcolor.png" class="im"  >
  <div class="ol"></div>
     <a href="<%=cp%>/tnotice/list" class="text">
     <img src="<%=cp%>/res/images/Notice.png" >
     </a>
</div>

<div class="cc" style="float: left; width: 25%; padding: 1%;" >
  <img src="<%=cp%>/res/images/bgcolor.png"  class="im" >
  <div class="ol"></div>
   <a href="<%=cp%>/tqna/list" class="text">
   <img src="<%=cp%>/res/images/qna.png" >
   </a>

</div>

<div class="cc" style="float: left; width: 25%; padding: 1%;">
  <img src="<%=cp%>/res/images/bgcolor.png"  class="im" >
  <div class="ol"></div>
    <a href="<%=cp%>/tfaq/faq" class="text">
   <img src="<%=cp%>/res/images/FNQ.png" >
   </a>
</div>
<div class="cc" style="float: left; width: 25%; padding: 1%;">
  <img src="<%=cp%>/res/images/bgcolor.png"  class="im" >
  <div class="ol"></div>
    <a href="<%=cp%>/tboard/list" class="text">
   <img src="<%=cp%>/res/images/Board.png" >
   </a>
</div>
</div>

<div id="leftnav" class="leftnav">
  <a onclick="friend();">친구</a>
  <a onclick="note();">쪽지</a>
  <a href="<%=cp%>/sch/sch">스케줄</a>
  <a onclick="closeNav()">닫기</a>
</div>
<div id="rightnav" class="rightnav">
  <a onclick="maker();">그룹만들기</a>
  <a onclick="finder();">그룹찾기</a>
  <a onclick="grouplist();">내그룹</a>
  <a onclick="closeNav()">닫기</a>
</div>
<div id="divGroupMaker" style = "display:none;">
<form name = "createdForm" enctype="multipart/form-data">
이름:<input type="text" id="groupName" name="groupName" class="form-control"><br>
소개:<input type="text" id="introduce" name="introduce" class="form-control"><br>
장소:<input type="text" id="place" name="place" class="form-control"><br>
키워드:<input type="text" id="keyword" name="keyword" class="form-control"><br>
프로필 사진:<input type="file" id="upload" name="upload" class="form-control"><br>
</form>
</div>

<div id="divGroupFinder" style = "display:none;"><div>
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
<div id="note_mk" style = "display:none;"></div>
<div id="myGroup" style = "display:none;">
<div id="myGroupList">
</div>
</div>