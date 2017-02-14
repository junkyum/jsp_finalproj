<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();

%>
<style type="text/css">
.imgLayout{
	width: 200px;
	height: 230px;
	padding: 5px 5px 5px;
	margin: 5px;
	border: 1px solid #DAD9FF;
	float: left;
	margin-right: 120px;

}

.subject {
     width:190px;
     height:25px;
     line-height:25px;
     margin:5px auto 0px;
     border-top: 1px solid #DAD9FF;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
     text-align: center;
}

a:hover {
   text-decoration: none;
}
h4{
    margin: 0px; 
   margin-top: 5px;
}
</style>

<!-- a작스로 파일저장시 필요한거, -->
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 위에있는거 모달 띠워주는것 -->
<script type="text/javascript">
$(function(){
	$(".chk1").click(function() {
	      $("#chk2").dialog({
	         title:"등록하기",
	         modal:true,
	         width:500,
	         height:500
	      });
	   });
});
function updatePhoto(){
		document.getElementById("kim_article").style.display="none";
		document.getElementById("kim_update").style.display="block";	
}
$(function(){
	listPage(1);
});
function listPage(page) {
	var url="<%=cp%>/groupGally/list";
    var groupName="${groupName}";
	$.get(url,{pageNo:page, groupName:groupName}, function(data) {
		$("#gallyLayout").html(data);

	});
}
function deletePhoto(gallyNum) {
	var url="<%=cp%>/group/photo/delete";	
	var query="gallyNum="+gallyNum;
	if(confirm("게시물 삭제 하시겟습니까?")){
			$.ajax({
				type:"post"
				,url:url
				,data:query
				,dataType:"json"
				,success:function(data) {
					var state=data.state;
					if(state=="false") {
						$('#gallyMyModal').modal('hide');
						listPage(1);
					} else{
						listPage(1);
					}			
				}
				,error:function(e) {
					console.log(e.responseText);
				}
			});
	}
}
function finsh() {
	$("#chk2").dialog("close");
	listPage(1);
	$("#groupName").val("");
	$("#subject").val("");
	$("#content").val("");
	$("#imageFilename").val("");
}
function send(){
	$("#span1").hide();
	$("#span2").hide();
	if(!$("#subject").val()){
		$("#subject").focus();
		$("#span1").show();
		return;
	}
	if(!$("#content").val()){
		$("#content").focus();
		$("#span2").show();
		return;
	}
	var f = document.photoForm;
    var formData = new FormData(f);
	  $.ajax({
			 type:"post"
			 ,url:"<%=cp%>/group/photo/created"
			 ,processData: false  // file 전송시 필수
	         ,contentType: false  // file 전송시 필수
	         ,data: formData
			 ,dataType:"json"
			 ,success:function(data) {
				var state=data.state;
				if(state=="false")
					console.log("작업 실패 !!!");
				
				$("#chk2").dialog("close");
				listPage(1);
				 
				$("#groupName").val("");
				$("#subject").val("");
				$("#content").val("");
				$("#imageFilename").val("");			
			}
			 
			,error:function(e) {
				console.log(e.responseText);
			}
			
		});

}
function updateDialog(gallyNum) {
     var url="<%=cp%>/group/photo/article?gallyNum="+gallyNum;
     $('#gallyMyModal .modal-body').empty();

	$('#gallyMyModal .modal-body').load(url, function() {
		$('#gallyMyModal .modal-title').html('정보');
		$('#gallyMyModal').modal('show');
		$("input[name='name']").focus();
	});
}
function updateOK(gallyNum) {
  var f=document.dialogForm;
  var formData = new FormData(f);
	  $.ajax({
			 type:"post"
			 ,url:"<%=cp%>/group/photo/update"
			 ,processData: false  // file 전송시 필수
	         ,contentType: false  // file 전송시 필수
	         ,data: formData
			 ,dataType:"json"
			 ,success:function(data) {
				var state=data.state;
				if(state=="false"){
					console.log("작업 실패 !!!");		
				} else {
				$('#gallyMyModal').modal('hide');
				listPage(1);
				$("#groupName").val("");
				$("#subject").val("");
				$("#content").val("");
				$("#imageFilename").val("");	
				}
			}
			,error:function(e) {
				console.log(e.responseText);
			}
			
		});
   
}
function updateCancel() {
	$('#gallyMyModal').modal('hide');
}
function GReply(gallyNum) {
	var userId="${sessionScope.member.userId}";
	var content=$("#answerContent").val().trim();
	if(!content) {
		$("#answerContent").focus();
		return;
	}
	var query="gallyNum="+gallyNum;
	query+="&content="+content;
	query+="&replyAnswer=0";
	query+="&userId="+userId;
	$.ajax({
		type:"post"
		,url:"<%=cp%>/group/photo/createdGReply"
		,data:query
		,dataType:"json"
		,success:function(data) {
			$("#answerContent").val("");
			
			var loginChk=data.loginChk;
	
			if(loginChk=="false") {
				console.log("리플등록 실패");
			} else{
				listPageAnswer(1);

			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}
function findGally(){
	var dlg;
    dlg=$("#findGroupGally").dialog({
       title:"그룹찾기",
       modal:true,
		width:500,
	    height:200,
	    show:"clip",
		hide:"clip",
	    buttons:{
	    	buttons:{
				"찾기":function(){
					var url="<%=cp%>/groupGally/list";
		
					var searchKeyK=$('#searchKeyK').val();
					var searchValueK=$('#searchValueK').val();
					var groupName="${groupName}";
					$.post(url, {searchKeyK:searchKeyK, searchValueK:searchValueK, groupName:groupName}, function(data) {
						$(dlg).dialog("close");
						$("#gallyLayout").html(data);
						$("#searchValueK").val("");
						
					});
					
					
				}, "취소":function() {
					$(this).dialog("close");
				}
				
				
			}
	    }
    	});
   
}

</script>
<script type="text/javascript">
function listReplyAnswer(replyAnswer){
	var listReplyAnswerId="#listReplyAnswer"+replyAnswer;	
	var url="<%=cp%>/group/photo/listReplyAnswer";
	$.get(url, {replyAnswer:replyAnswer}, function(data){
		$(listReplyAnswerId).html(data);
	});
}
function countAnswer(replyAnswer) {
	var url="<%=cp%>/group/photo/replyCountAnswer";
	$.post(url, {replyAnswer:replyAnswer}, function(data){
		var count="("+data.count+")";

		var answerCountId="#answerCount"+replyAnswer;
		var answerGlyphiconId="#answerGlyphicon"+replyAnswer;
		
		$(answerCountId).html(count);
		$(answerGlyphiconId).removeClass("glyphicon-triangle-bottom");

	}, "JSON");
}
$(function(){
	
	$("body").on("click", ".btnGroupAnwerLaout", function(){
		var $divGroupReplyAnswer = $(this).parent().parent().next();
		var $answerGList = $divGroupReplyAnswer.children().children().eq(0);
		var isVisible = $divGroupReplyAnswer.is(':visible');
		var replyNum = $(this).attr("data-replyNum");
		if(isVisible) {
			$divGroupReplyAnswer.hide();
		} else if (!isVisible){
			$divGroupReplyAnswer.show();
			listReplyAnswer(replyNum);
			countAnswer(replyNum);
		}
		
	});
});
function sendGReplyAnswer(replyNum, gallyNum) {
	var userId="${sessionScope.member.userId}";
	var content=$("#answerContent"+replyNum).val().trim();
	if(! content){
		$("#answerContent"+replyNum).focus();
		return;
	}
	var query="gallyNum="+gallyNum;
	query+="&userId="+userId;
	query+="&content="+content;
	query+="&replyAnswer="+replyNum;
	console.log(query);
	var url="<%=cp%>/group/photo/insertGReplyAnswer";
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			$("#answerContent"+replyNum).val("");
			var loginChk=data.loginChk;
			if(loginChk=="false") {
				console.log("안들어감");
			} else {
				console.log("들어감");
				listReplyAnswer(replyNum);
				countAnswer(replyNum);
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
		
	});	
}
function deletePhotoReply(replyNum, pageNo) {
	var userId="${sessionScope.member.userId}";
	if(confirm("댓글을  삭제 하시겟습니까?")){
		var url="<%=cp%>/group/photo/deletePhotoReply";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data) {
				var loginChk= data.loginChk;
				if(loginChk=="false"){
					console.log("들어가냐??");
				} else {
					listPageAnswer(pageNo);
				}
		}, "json");	
	}
}
function deleteReplyAnswerList(replyNum, replyAnswer) {
	var userId="${sessionScope.member.userId}";
	if(confirm("답글을 삭제하시겠습니까 ?")) {	
		var url="<%=cp%>/group/photo/deleteReplyAnswer";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data) {
			var loginChk=data.loginChk;
			if(loginChk=="false"){
				console.log("답글 삭제 실패");
			}else {
				listReplyAnswer(replyAnswer);
				countAnswer(replyAnswer);
			}
		}, "json");	
	}	
}
function sendReplyLike(replyNum, gallryReplyLike) {
	var userId="${sessionScope.member.userId}";
	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(gallryReplyLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	var query="replyNum="+replyNum;
	query+="&gallryReplyLike="+gallryReplyLike;
	var url="<%=cp%>/group/photo/gallryReplyLike";
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				console.log("들어감");
				groupCountLike(replyNum);
			} else if(state=="false") {
					alert("한번만 할수있다.");
			} else if(state=="loginFail") {
					login();
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}
function groupCountLike (replyNum) {
	var url="<%=cp%>/group/photo/groupCountLike";
	$.post(url, {replyNum:replyNum}, function(data){
		var likeCountId="#likeCount"+replyNum;
		var disLikeCountId="#disLikeCount"+replyNum;
		var likeCount=data.likeCount;
		var disLikeCount=data.disLikeCount;
		$(likeCountId).html(likeCount);
		$(disLikeCountId).html(disLikeCount);
	}, "JSON");
}
function groupGallyLike(gallyNum, gallyLike) {
	var userId="${sessionScope.member.userId}";
	var msg="사진 괜찬아요???";
	if(gallyLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	var query="gallyNum="+gallyNum;
	query+="&gallyLike="+gallyLike;
	var url= "<%=cp%>/group/photo/gallyLike"
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			var state=data.state;
			if(state=="true") {
				console.log("들어감");
				groupGallyLikeCount(gallyNum)
			} else if(state=="false") {
				alert("선택은 한번만!!");
			} 
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}
function groupGallyLikeCount(gallyNum) {
	var url="<%=cp%>/group/photo/groupGallyLikeCount";
	$.post(url, {gallyNum:gallyNum}, function(data){
		var gallyLikeCountId="#gallyLikeCount"+gallyNum;
		var gallyLikeCount=data.gallyLikeCount;
		$(gallyLikeCountId).html(gallyLikeCount);
	}, "JSON");
}
</script>
<div style="margin:0px; padding:0px; width: 1200px; height: 600px; ">
	 	<div>
			<div style="clear: both; margin-top: 0px; height: 30px;">
					<div style="float: left; min-width: 85px; text-align: right;">
						<div class="chk1"><!-- 버튼이 들어가있는  div -->
							<button type="button">
								<img src="<%=cp%>/res/images/btn.png" style="width: 50px; height: 50px; position: relative; top: 10pk;">	
							</button>
						</div>
					</div>
			</div>
		</div> 
		<div id="gallyLayout"></div>
</div>
<div class="chk2" id="chk2" style="display: none; padding:0px; margin: 0px; width: 500px; height: 500px;">
    <form method="post" name="photoForm" id="photoForm" enctype="multipart/form-data" >
		<div style="height: 300px; width: 480px; border: 1px solid black;">
			<h3 style="margin-top: 10px; margin-left: 150px;" >그룹 명 : ${groupName}</h3>
			 <input type="hidden" name="groupName" value="${groupName}">
				<div style="margin-top: 10px;">
					<h4 style="float: left; margin: 0px;">재 목 :&nbsp;</h4>
					<input type="text" name="subject" id="subject" value="" placeholder="내용을 입력하세요" style="clear: both;">
					<span id="span1" style="display: none;" >내용좀 입력하세요</span>
				</div>
				<div>
					<h4>내 용 : <span style="display: none;" id="span2">내용좀 입력하세요</span></h4> 
					<textarea rows="5" name="content" id="content" required="required" style="width: 300px; height: 100px;"></textarea>
				</div>		
		</div>
		<div style="margin: 0px;margin-left : 40px; margin-top: 10px; width: 300px; height: 50px; border: 1px solid black;" >
			<input type="file" name="upload" id="imageFilename" >
		</div>
		<div style="margin-left: 100px; margin-top: 20px; float: right; " >
			<button type="button" id="btn" name="btn" onclick="send();" >등록하기</button>
			<button type="button" onclick="finsh();">취소</button>
		</div>
    </form>	
</div>
<div class="modal fade" id="gallyMyModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">
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
<div style="margin-top: 14px; display: none;" id="findGroupGally" >	
	<div style="float: left; width: 60%; min-width: 85px;">	
	<form name = "findGallyForm">
			<select id= "searchKeyK" name="searchKeyK" class="form-control" style = "width: 35% ; float: left; margin-right: 5%;">
				<option value="subject">제목</option>
				<option value="content">내용</option>
				<option value="created">등록일</option>
			</select>
			<input type="text" name="searchValueK" id="searchValueK" class="form-control" style = "width: 60%;float: left;"><br>
		</form>
	</div>
</div>