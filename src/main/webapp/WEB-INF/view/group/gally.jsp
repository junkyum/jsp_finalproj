<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();

%>
<!-- groupGally/gally   이게 맨처음 겔러리 페이지 -->
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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
//수정@글보기  숨기고 보이고 하는거.
function updatePhoto(){
		document.getElementById("kim_article").style.display="none";
		document.getElementById("kim_update").style.display="block";	
}

/* 이게 listGally.jsp를 출력하게 해주는 곳 */
$(function(){
	listPage(1);
});
function listPage(page) {
	var url="<%=cp%>/groupGally/list";
    var groupName="${groupName}";
	$.get(url,{pageNo:page, groupName:groupName}, function(data) {
		$("#gallyLayout").html(data);
		$('#searchKeyK').val("");
		$('#searchValueK').val("");
	});
}
/*  -------------------------------*/

//사진삭제하는곳
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

///수정 하는곳
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
					alert("작업 실패 !!!");		
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
//등록창 누르는 상태에서 취소를 눌럿을떄.
function finsh() {
	$("#chk2").dialog("close");
	listPage(1);
	$("#groupName").val("");
	$("#subject").val("");
	$("#content").val("");
	$("#imageFilename").val("");
}

//사진등록 
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
	if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
		alert('이미지 파일만 가능합니다. !!!');
		f.upload.focus();
		return false;
	}
	

    var formData = new FormData(f);
    
	alert(formData);
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
					alert("작업 실패 !!!");
				
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

//글보기후 모달띠이우는곳
function updateDialog(gallyNum) {
     var url="<%=cp%>/group/photo/article?gallyNum="+gallyNum;
     $('#gallyMyModal .modal-body').empty();

	$('#gallyMyModal .modal-body').load(url, function() {
		$('#gallyMyModal .modal-title').html('정보');
		$('#gallyMyModal').modal('show');
		$("input[name='name']").focus();
	});
}

function updateCancel() {
	$('#gallyMyModal').modal('hide');
}

function updateOk() {
	alert("ok");
}
////////////////////////////////////////////////////////////////////
//리플 등록
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
				alert("리플등록 실패");
			} else{
				listPageAnswer(1);

			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}
////////////////////////////
//원하는 개시물을 찾을떄 사용
function findGally(){

	var dlg;
    dlg=$("#findGroupGally").dialog({// 모달 뜬다.
       title:"그룹찾기",// 모달 뜬후 나오는 창.
       modal:true,
		width:500,
	    height:200,
	    show:"clip",
		hide:"clip",
	    buttons:{
			"찾기":function(){
				var url="<%=cp%>/groupGally/list";
				alert($('#searchValueK').val());
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
    });
   
}

</script>

<!-- 댓글@대댓글에 관련된것 -->
<script type="text/javascript">

/* 글보기   댓글의!!!  할떄 리스트 나오게끔 해주는것   */

//대댓글 리스트 뿌려주기위해서.
function listReplyAnswer(replyAnswer){
	var listReplyAnswerId="#listReplyAnswer"+replyAnswer;	
	var url="<%=cp%>/group/photo/listReplyAnswer";
	$.get(url, {replyAnswer:replyAnswer}, function(data){
		$(listReplyAnswerId).html(data);
	});
}
//게시물 밑에 답글 밑에 답글의 갯수를 새는곳 
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

//답글 버튼 누르는 액션
$(function(){
	
	$("body").on("click", ".btnGroupAnwerLaout", function(){
		var $divGroupReplyAnswer = $(this).parent().parent().next();
		/* 이부분이  listReply안있는  .btnR의 아버지 의 아버지div의 다음 것 을 지칭 한다.
		div class=GroupReplyAnswer =   ?GroupReplyAnswer  이전에 이상한 거엿음 외거런지 확인해서. 을 지칭한다.
		*/
		var $answerGList = $divGroupReplyAnswer.children().children().eq(0);
		/* <div id='listReplyAnswer${vo.replyNum}' 을 의미한다 listReply의 */
		
		var isVisible = $divGroupReplyAnswer.is(':visible');
		//보여주기위해서
		var replyNum = $(this).attr("data-replyNum");
		//해당답글 번호.
	
		if(isVisible) {
			$divGroupReplyAnswer.hide();
			
		} else if (!isVisible){
			$divGroupReplyAnswer.show();
		
			//답변 버튼눌럿을떄도 리스트나오게 하는것 listPageAnswer
			listReplyAnswer(replyNum);//대댓글 리스트
			countAnswer(replyNum);
		}
		
	});
});



//게시판 밑에 답글 밑에 답글 등록하는 메소드
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
				//등록해도 리스트 나오게 한는것
				listReplyAnswer(replyNum);
				countAnswer(replyNum);
			
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
		
	});	
}

////사진의 댓들을 단것을 삭제하기 위해 만든곳
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
/////////////////////////////////////////////////////
//댓글별 답글 삭제   
function deleteReplyAnswerList(replyNum, replyAnswer) {
	var userId="${sessionScope.member.userId}";

	
	if(confirm("댓글별 답글을 삭제하시겠습니까 ??????????? ")) {	
		var url="<%=cp%>/group/photo/deleteReplyAnswer";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data) {
			var loginChk=data.loginChk;
			if(loginChk=="false"){
				alert("댓글별답글 삭제 실패");
			}else {
				listReplyAnswer(replyAnswer);
				countAnswer(replyAnswer);
			}
		}, "json");	
	}	
}

//게시물 답글의 좋아요@싫어요 추가시키는 곳
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
				alert("들어감");
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

//게시물 답글의 좋아요@싫어요 갯수 새는곳
function groupCountLike (replyNum) {
	var url="<%=cp%>/group/photo/groupCountLike";
	$.post(url, {replyNum:replyNum}, function(data){
		var likeCountId="#likeCount"+replyNum;
		var disLikeCountId="#disLikeCount"+replyNum;
		var likeCount=data.likeCount;
		var disLikeCount=data.disLikeCount;
		  alert(disLikeCount+"       "+likeCount);
		  
		$(likeCountId).html(likeCount);
		$(disLikeCountId).html(disLikeCount);
	}, "JSON");
	
}

/* 사진의 좋아요를 추가 시키는곳 */
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
				alert("들어감");
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


/* 사진의 좋아요의 갯수 세는곳 */
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
								<img src="<%=cp%>/res/images/btn.png"
									style="width: 50px; height: 50px; position: relative; top: 10pk;">
								<div>등록하기</div>
							</button>
						</div>
					</div>
			</div>
		</div> 
		<!-- 맨처음 main.jsp에서 컨트롤러에있는 gally 메소드로 가서 가지고올꺼 가지고오고 그룹/겔러리 로가서  위쪽에 있는  groupGrally/lisy 로가서
		맨처음 패이지를 뿌려준다.  난 맨처음 시작하는 동시에 메인 바꾸고@컨트롤러 가서 조작 하고@ 리스트 페이지 펀션 만들고@  리턴으로 listGally 만들고 뿌려주면 됨
		리스트G겔러리에 그냥 대충 끄적 거려노면 될듯  일단 등록먼저 만들고..-->
		${groupName}
		<div id="gallyLayout"> </div>
</div>		

	
	<!-- 등록하기 눌럿을떄 나오는 팝업 창 -->
		<div class="chk2" id="chk2" style="display: none; padding:0px; margin: 0px; width: 500px; height: 500px;">
		    <form method="post" name="photoForm" id="photoForm" enctype="multipart/form-data" >
				<div style="height: 300px; width: 480px; border: 1px solid black;">
					<h3 style="margin-top: 10px; margin-left: 150px;">그룹 명 : ${groupName} </h3>
					 <input type="hidden" name="groupName" value="${groupName}">
		
						<div style="margin-top: 10px;">
							<h4 style="float: left; margin: 0px;">재 목 :&nbsp;</h4>
							<input type="text" name="subject" id="subject" value="" placeholder="내용을 입력하세요" style="clear: both;">
							<span id="span1" style="display: none;">내용좀 입력하세요</span>
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
	

	
	<!-- 글보기 눌럿을떄 팝업 창을 띠우기 위해서 만든 것. -->
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