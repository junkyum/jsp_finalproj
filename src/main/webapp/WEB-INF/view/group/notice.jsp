<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style>
.bestbig {
   margin: 0 auto;
   width: 900px;
   /*    height: 680px; */
   /*    border: 1px solid #5D5D5D; */
}
</style>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
$(function(){
   noticeListpage(1);
   $('[data-toggle="tooltip"]').tooltip();
});

function noticeListpage(page) {
   var url="<%=cp%>/group/noticeList";
   var num="${dto.num}";
   var groupName = "${groupName}";
   var userId = "${userId}";
   $.post(url, {num:num, pageNo:page, groupName:groupName, userId:userId}, function(data){
      $("#noticeListlayout").html(data);
      $("#gnsearchKeykm").val();
      $("#gnsearchValuekm").val();
   });
}


function mkmmodalCheck(){
   var page = "${page}";
   var url = "<%=cp%>/group/notice/created";
   var subject = $("#kmsubject").val().trim();
   var content = $("#kmcontent").val().trim();
   var groupName= "${groupName}";
   if(!subject){
      $("#kmsubject").focus();
      return;
   }
   
   var query ="subject="+subject+"&content="+content+"&groupName="+groupName;
   
   var groupNotiF = document.gNotice;
   var gnformDate = new FormData(groupNotiF);
      $.ajax({
         type:"post",
         url :url,
         processData: false,
         contentType: false,
         data : gnformDate,
         dataType:"json",
         success:function(data){
            var result = data.result;
            if(data.result=="true"){
               $("#kmsubject").val("");
               $("#kmcontent").val("");
               $("#kmgnfile").val("");            
               noticeListpage(1);               
            }else {
               alert("추가 안됌 여기 어떻ㄱㅔ 바꿀지 생각해 보기! ");
            }
            
         },error:function(e) {
               console.log(e.responseText);
            }
      
   });   
}

function updateNoG(num,page){
		var userId = "${dto.userId}";
	    $('#myModalUpdate .modal-body').empty();
		var url="<%=cp%>/group/gboard/update?boardNum="+boardNum+"&page="+page+"&userId="+userId;
		$("#myModalUpdate .modal-body").load(url, function() {
		    $("#myModalUpdate .modal-title").html('정보 수정');
	   	    $("#myModalUpdate").modal('show');
			$("input[name='name']").focus();
		});
   
} 

function groupNoticeUpdateOk(){
   var page = "${page}";
   var num= "${dto.num}";
   var url = "<%=cp%>/group/notice/update";
   var subject = $("#updateSubjectNotice").val().trim();
   var content = $("#updateContentNotice").val().trim();
   var groupName= "${groupName}";
   
   var dialogNoticeUpdateForm = document.dialogNoticeUpdateForm;
   var updateNoticeForm = new FormData(dialogNoticeUpdateForm);
      $.ajax({
         type:"post",
         url :url,
         processData: false,
         contentType: false,
         data : updateNoticeForm,
         dataType:"json",
         success:function(data){
            var result = data.result;
            if(data.result=="true"){
               $("#updateSubjectNotice").val("");
               $("#updateContentNotice").val("");
               $("#updateFileNotice").val("");      
               $("#myModalNoticeUpdate").hide();
               noticeListpage(page);   
            }else {
               alert("121231432추가 안됌 여기 어떻ㄱㅔ 바꿀지 생각해 보기! ");
            }
            
         },error:function(e) {
               console.log(e.responseText);
            }
      
   });   
}
   
function deleteNoG(num,page,fileNum){   
   if(confirm("공지사항을 삭제 하시겠습니까 ? ")){
      var url ="<%=cp%>/group/notice/delete";
      $.post(url, {num:num, page:page, fileNum:fileNum}, function(data){
         var state = data.state;
         if(state =="true"){
            noticeListpage(page);
         }else {
            alert("파일 삭제 실패했당 다시 확인해보시용  ");
         }
      }, "json");
   }
}

function noticelayoutview(num) {
   var s=$("#middlediv"+num);
   var aa = 130;
   var ma = 900;
      if(s.height()==aa){
         s.animate({"max-height" : ma});
         $("#gradient").fadeOut();
      }else {
         s.animate({"max-height" : aa});
         $("#gradient").fadeIn();
      }
}

function gnSearchList(){
   var url="<%=cp%>/group/noticeList";
   var searchKey=$('#gnsearchKeykm').val();
   var searchValue=$('#gnsearchValuekm').val();
   var groupName="${groupName}";
   var userId = "${userId}";
   $.post(url, {searchKey:searchKey, searchValue:searchValue, groupName:groupName, userId:userId}, function(data) {
      $("#noticeListlayout").html(data);
      $("#searchValue").val("");
      
   });
}

</script>

</head>
<body>
   <div class="bestbig">
      <div style="clear: both; height: 50px; line-height: 30px;"></div>
      <div id="noticeListlayout"></div>
   </div>



   <div class="modal fade" id="kmNoticeModal" role="dialog">
      <form name="gNotice" method="POST" enctype="multipart/form-data">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <h4 class="modal-title">
                     <span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;공지사항을 작성합니다.
                  </h4>
               </div>
               <div class="modal-body">
                  <input type="text" name="subject" id="kmsubject"
                     class="form-control input" placeholder="제목을 입력해주세요."
                     required="required"><br>
                  <textarea name="content" id="kmcontent" class="form-control"
                     rows="15" required="required"></textarea>
                  <br> <input type="file" name="upload" id="kmgnfile"
                     class="form-control input"><br>
                  <input type="hidden" name="groupName" value="${groupName }">
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal"
                     id="kmmodalCheck" onclick="mkmmodalCheck();">
                     <span class="glyphicon glyphicon-ok"></span>
                  </button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">
                     <span class="glyphicon glyphicon-remove"></span>
                  </button>
               </div>
            </div>
         </div>
      </form>
   </div>
   
   
<div class="modal fade" id="myModalNoticeUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel" style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">수정</h4>
      </div>
      <div class="modal-body"></div>
    </div>
  </div>
</div>
   
   
</body>
