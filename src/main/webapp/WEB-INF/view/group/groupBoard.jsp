<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
.gbbestbig {
	margin: 0 auto;
	width: 900px;
	/* 	height: 680px; */
}
</style>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
$(function(){
	groupBoardListpage(1);
});

function groupBoardListpage(page) {	
	
	var url="<%=cp%>/group/groupBoardList";
	var boardNum = "${dto.boardNum}";
	var groupName = "${groupName}";
	var userId = "${userId}";
	$.get(url, {boardNum:boardNum, page:page, groupName:groupName, userId:userId}, function(data){
		$("#gblistlayout").html(data);
		$("#gnsearchKeykm").val();
		$("#gnsearchValuekm").val();
	});
}
   
function gboardSearchList(){
	var url="<%=cp%>/group/groupBoardList";
	var searchKey=$('#gbsearchKeykm').val();
	var searchValue=$('#gbsearchValuekm').val();
	var groupName="${groupName}";
	var userId = "${userId}";
	$.post(url, {searchKey:searchKey, searchValue:searchValue, groupName:groupName, userId:userId}, function(data) {
		$("#gblistlayout").html(data);
		$("#searchValue").val("");
		
	});
}

function mkmgroupBoardCheck(){
	var page = "${page}";
	var url = "<%=cp%>/group/gboard/created";
	var subject = $("#gbsubjectkm").val().trim();
	var content = $("#gbcontentkm").val().trim();
	var keyword = $("#gbkeywordkm").val();
	var groupName= "${groupName}";
	if(!subject){
		$("#gbsubjectkm").focus();
		return;
	}
	
	var groupBodF = document.gBoard;
	var gbformData = new FormData(groupBodF);
		$.ajax({
			type:"post",
			url :url,
			processData: false,
			contentType: false,
			data : gbformData,
			dataType:"json",
			success:function(data){
				var result = data.result;
				if(data.result=="true"){
					$("#gbsubjectkm").val("");
					$("#gbcontentkm").val("");
					$("#gbfilekm").val("");
					$("#gbkeywordkm").val("");				
					groupBoardListpage(1);					
				}else {
					alert("추가 안됌 여기 어떻ㄱㅔ 바꿀지 생각해 보기! ");
				}
				
			},error:function(e) {
		    	  console.log(e.responseText);
		      }
		
	});	
}

function articleGroupBoard(boardNum,page){
	var url="<%=cp%>/group/gboard/boardArticle";
	var searchKey = "${searchKey}";
	var searchValue = "${searchValue}";
	var groupName = "${groupName}";
	var query="boardNum="+boardNum+"&page="+page+"&groupName="+groupName+"&searchKey="+searchKey+"&searchValue="+searchValue;
	
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
			$("#gblistlayout").html(data);
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}


function deleteBoard(boardNum,page,fileNum) {
	
	var url="<%=cp%>/group/gboard/delete";	
	var query="boardNum="+boardNum+"&page="+page+"&fileNum="+fileNum;
	
	if(confirm("게시물 삭제 하시겟습니까?")){
			$.ajax({
				type:"post"
				,url:url
				,data:query
				,dataType:"json"
				,success:function(data) {
		
					var state=data.state;			
					if(state=="false") {						
						groupBoardListpage(page);
					} else{
						alert("삭제ㄴㄴ");
					}			
				}
				,error:function(e) {
					console.log(e.responseText);
				}
			});
	}
}



 function groupBaordListGo(page){
	groupBoardListpage(page);
} 
 

function gboardsendReply(boardNum){
	var userId="${sessionScope.member.userId}";
	var content = $("#gboardReplyContent").val().trim();
	if(! content){
		$("#gboardReplyContent").focus();
		return;
	}
	var query = "boardNum="+boardNum+"&content="+content+"&replyAnswer=0"+"&userId="+userId;
	
	$.ajax({
		type:"POST",
		url:"<%=cp%>/group/gboard/insertReply",
		data:query,
		dataType:"JSON",
		success:function(data){
			$("#gboardReplyContent").val("");
			var state = data.state;
			if(state =="true"){
				gboardReplyListpage(1);				
			} else{
				alert("댓글 남기는거 실패함 어떻게할지 생각중임 ")
			}
		}
	});
}
function kmListReplyAnswer(replyAnswer){
	var listReplyAnswerkm="#kmListReplyAnswer"+replyAnswer;	
	var url="<%=cp%>/group/gboard/listReplyAnswer";
	$.get(url, {replyAnswer:replyAnswer}, function(data){
		$(listReplyAnswerkm).html(data);
	});
}

function countAnswerkm(replyAnswer) {
	var url="<%=cp%>/group/gboard/replyCountAnswer";
	$.post(url, {replyAnswer:replyAnswer}, function(data){
		var count="("+data.count+")";

		var answerCountkm="#gbAnswerCount"+replyAnswer;
		var answerGlyphiconkm="#answerGlyphicon"+replyAnswer;
		
		$(answerCountkm).html(count);
		$(answerGlyphiconkm).removeClass("glyphicon-triangle-bottom");

	}, "JSON");
}

$(function(){	
	$("body").on("click", ".btnGroupReplyAnwerLaout", function(){
		var $divGroupReplyAnswerkm = $(this).parent().parent().next();
		/* 이부분이  listReply안있는  .btnR의 아버지 의 아버지div의 다음 것 을 지칭 한다.
		div class=GroupReplyAnswer =   ?GroupReplyAnswer  이전에 이상한 거엿음 외거런지 확인해서. 을 지칭한다.
		*/
		var $answerGroupBoardList = $divGroupReplyAnswerkm.children().children().eq(0);
		/* <div id='listReplyAnswer${vo.replyNum}' 을 의미한다 listReply의 */
		
		var isVisible = $divGroupReplyAnswerkm.is(':visible');
		//보여주기위해서
		var replyNum = $(this).attr("data-replyNum");
		//해당답글 번호.
	
		if(isVisible) {
			$divGroupReplyAnswerkm.hide();
			
		} else if (!isVisible){
			$divGroupReplyAnswerkm.show();
		
			//답변 버튼눌럿을떄도 리스트나오게 하는것 listPageAnswer
			kmListReplyAnswer(replyNum);//대댓글 리스트
			countAnswerkm(replyNum);
		}
		
	});
});

function gboardSendGReplyAnswer(replyNum, boardNum) {
	var userId="${sessionScope.member.userId}";
	var content=$("#gboardAnswerContent"+replyNum).val().trim();
	
	if(! content){
		$("#gboardAnswerContent"+replyNum).focus();
		return;
	}
	var query="boardNum="+boardNum+"&userId="+userId+"&content="+content+"&replyAnswer="+replyNum;
	
	console.log(query);	
	var url="<%=cp%>/group/gboard/insertReplyAnswer";

	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			$("#gboardAnswerContent"+replyNum).val("");
			
			var loginChk=data.loginChk;
			if(loginChk=="false") {
				console.log("안들어감");
				
			} else {
				console.log("들어감");
				//등록해도 리스트 나오게 한는것
				kmListReplyAnswer(replyNum);
				countAnswerkm(replyNum);
			
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
		
	});	
}

function deleteBoardReply(replyNum, page) {
	var userId="${sessionScope.member.userId}";
    	
	if(confirm("댓글을  삭제 하시겟습니까?")){
		var url="<%=cp%>/group/gboard/deleteBoardReply";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data) {
				var loginChk= data.loginChk;
				if(loginChk=="false"){
					console.log("들어가냐??");
				} else {
					gboardReplyListpage(page);
				}
			
		}, "json");	
	}
}

function deletegboardReplyAnswerList(replyNum, replyAnswer) {
	var userId="${sessionScope.member.userId}";

	
	if(confirm("댓글별 답글을 삭제하시겠습니까 ??????????? ")) {	
		var url="<%=cp%>/group/gboard/deleteReplyAnswer";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data) {
			var loginChk=data.loginChk;
			if(loginChk=="false"){
				alert("댓글별답글 삭제 실패");
			}else {
				kmListReplyAnswer(replyAnswer);
				countAnswerkm(replyAnswer);
			}
		}, "json");	
	}	
}
//게시물 답글의 좋아요@싫어요 추가시키는 곳
function kmSendReplyLike(replyNum, boardReplyLike) {
	var userId="${sessionScope.member.userId}";
	
	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(boardReplyLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	var query="replyNum="+replyNum+"&boardReplyLike="+boardReplyLike;
	var url="<%=cp%>/group/gboard/boardReplyLike";
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
				
			var state=data.state;
			if(state=="true") {
				groupgboardCountLike(replyNum);
				gboardReplyListpage(1);
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
//게시물 답글의 좋아요, 싫어요 갯수 세는곳 
function groupgboardCountLike (replyNum) {
	var url="<%=cp%>/group/gboard/groupgboardCountLike";
	$.post(url, {replyNum:replyNum}, function(data){
		var likeCountkm="#kmLikeCount"+replyNum;
		var disLikeCountkm="#kmDisLikeCount"+replyNum;
		var kmLikeCount=data.kmLikeCount;
		var kmDisLikeCount=data.kmDisLikeCount;
		$(likeCountkm).html(kmLikeCount);
		$(disLikeCountkm).html(kmDisLikeCount);
	}, "JSON");
}

//게시물의 좋아요 추가 시키는 곳 
function groupBoardLike(boardNum, boardLike) {
	var userId="${sessionScope.member.userId}";
	
	var msg="사진 괜찬아요???";
	if(boardLike==1)
		msg="게시물에 공감하십니까 ?";
	
	if(! confirm(msg))
		return false;
	var query="boardNum="+boardNum+"&boardLike="+boardLike;
	var url= "<%=cp%>/group/gboard/boardLike";
		
	$.ajax({
		type:"POST"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
				
			var state=data.state;
			if(state=="true") {
				groupBoardLikeCount(boardNum)
			} else if(state=="false") {
				alert("선택은 한번만!!");
			} 
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}
// 게시물 좋아요 
function groupBoardLikeCount(boardNum) {
	alert("1="+boardNum);
	var url="<%=cp%>/group/gboard/groupBoardLikeCount";
	alert("1="+boardNum+"asdasdas");
	$.post(url, {boardNum:boardNum}, function(data){
		var boardLikeCountId="#boardLikeCount"+boardNum;
		alert("2="+boardLikeCountId);
		var boardLikeCount=data.boardLikeCount;
		alert("3="+boardLikeCount);
		$(boardLikeCountId).html(boardLikeCount);
	}, "JSON");
}

function gboardDeleteFile(fileNum) {
	var url="<%=cp%>/group/gboard/deleteFile";
	$.post(url, {fileNum:fileNum}, function(data){
		$("#f"+fileNum).remove();
	}, "JSON");
}

$(function(){
	$("body").on("change", "input[name=upload]", function(){
		if(! $(this).val()) {
			return;	
		}
		
		var b=false;
		$("input[name=upload]").each(function(){
			if(! $(this).val()) {
				b=true;
				return;
			}
		});
		if(b)
			return;

		var $p, $input;
		
	    $p=$("<p>", {class:"p",  html:"첨부"});
	    $input=$("<input>", {type:"file", name:"upload", class:"form-control input-sm", style:"height: 35px;"});
	    $p.append($input);
	    
	    $("#p").append($p);
	});
});


function updateBoard(boardNum){
	alert("SDf"+boardNum);
	$("#myModalGboardUpdate").show();
	
} 

function groupBoardUpdateOk(){
	var page = "${page}";
	var boardNum= "${dto.boardNum}";
	var url = "<%=cp%>/group/gboard/update";
	var subject = $("#updateSubjectkm").val().trim();
	var content = $("#updateContentkm").val().trim();
	var keyword = $("#updateKeywordkm").val();
	var groupName= "${groupName}";

	
	var dialogUpdateForm = document.dialogUpdateForm;
	var updateForm = new FormData(dialogUpdateForm);
		$.ajax({
			type:"post",
			url :url,
			processData: false,
			contentType: false,
			data : updateForm,
			dataType:"json",
			success:function(data){
				var result = data.result;
				if(data.result=="true"){
					alert("121231432추가 안됌 여기 어떻ㄱㅔ 바꿀지 생각해 보기! ");
				}else {
					$("#updateSubjectkm").val("");
					$("#updateContentkm").val("");
					$("#updateFilekm").val("");
					$("#updateKeywordkm").val("");				
					$("#myModalGboardUpdate").hide();
					groupBoardListpage(page);	
				}
				
			},error:function(e) {
		    	  console.log(e.responseText);
		      }
		
	});	
}
</script>



<div class="gbbestbig">

	 <div id="gblistlayout"></div>
	
	
	
	
	<div class="modal fade" id="myModalGboard" role="dialog">
	<form name="gBoard" method="POST" enctype="multipart/form-data">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
					<h4 class="modal-title">
						<span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;
						게시물을 작성합니다.
					</h4>
				</div>
				<div class="modal-body">
					<input type="text" name="subject" id="gbsubjectkm" class="form-control input"
						placeholder="제목을 입력해주세요." required="required"><br>
					<textarea name="content" id="gbcontentkm" class="form-control" rows="15"
						required="required"></textarea>
					<br> <input type="file" name="upload" id="gbfilekm"
						class="form-control input"><br> 
					<input type="hidden" name="groupName" value="${groupName }">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
							id="kmgroupBoardCheck" onclick="mkmgroupBoardCheck();">
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
	
</div>
