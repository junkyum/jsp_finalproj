<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
$(function(){
	listPage(1);
});

/* 글보기 할떄 리스트 나오게끔 해주는것   */
function listPage(pageNo){
	var url="<%=cp%>/group/photo/listGReply";
	var gallyNum="${dto.gallyNum}";	
	$.get(url, {gallyNum:gallyNum, pageNo:pageNo}, function(data){
		$("#listGReply").html(data);
	
	});
}

//대댓글 리스트 뿌려주기위해서.
function listReplyAnswer(replyAnswer){
	var listReplyAnswerId="#listReplyAnswer"+replyAnswer;	
	var url="<%=cp%>/group/photo/listReplyAnswer";
	$.get(url, {replyAnswer:replyAnswer}, function(data){
		$(listReplyAnswerId).html(data);
	});
}
//댓글별 답글 갯수   a작스?  안된다.
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
		var $divGReplyAnswer = $(this).parent().parent().next();
		/* 이부분이  listReply안있는  .btnR의 아버지 의 아버지div의 다음 것 을 지칭 한다.
		div class=GroupReplyAnswer  을 지칭한다.
		*/
		var $answerGList = $divGReplyAnswer.children().children().eq(0);
		/* <div id='listReplyAnswer${vo.replyNum}' 을 의미한다 listReply의 */
		
		var isVisible = $divGReplyAnswer.is(':visible');
		//보여주기위해서
		var replyNum = $(this).attr("data-replyNum");
		//해당답글 번호.
			
		if(isVisible) {
			$divGReplyAnswer.hide();
		} else {
			$divGReplyAnswer.show();
			//답변 버튼눌럿을떄도 리스트나오게 하는것
			listReplyAnswer(replyNum);
			//countAnswer(replyAnswer);
		}
		
	});
});



//댓글 단것의 답글을 달았을떄  사용하는 것(미완성)//실시간으로 카운트 증가안함@
//답글의 갯수
function sendGReplyAnswer(replyNum) {

	var userId="${sessionScope.member.userId}";
	var gallyNum ="${dto.gallyNum}";
	var content=$("#answerContent"+replyNum).val().trim();

	if(! content){
		$("#answerContent"+replyNum).focus();
		return;
	}
	
	var query="gallyNum="+gallyNum;
	query+="&userId="+userId;
	query+="&content="+content;
	query+="&replyAnswer="+replyNum;
	
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
				
				
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
		
	});	
}
////사진의 댓들을 단것을 삭제하기 위해만든것
function deleteReply(replyNum, pageNo) {
	var userId="${sessionScope.member.userId}";

	if(confirm("댓글 삭제 하시겟습니까?")){
		var url="<%=cp%>/group/photo/deleteReply";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data) {
				var loginChk= data.loginChk;
				
				if(loginChk=="false"){
					console.log("들어가냐??");
				} else {
					listPage(pageNo);
				}
			
		}, "json");	
	}
}
/////////////////////////////////////////////////////
//댓글결 답글 삭제 -->
function deleteReplyAnswerList(replyNum, replyAnswer) {
	var userId="${sessionScope.member.userId}";

	
	if(confirm("게시물을 삭제하시겠습니까 ??????????? ")) {	
		var url="<%=cp%>/group/photo/deleteReplyAnswer";
		$.post(url, {replyNum:replyNum, userId:userId}, function(data) {
			var loginChk=data.loginChk;
			if(loginChk=="false"){
				alert("실패임...");
			}else {
				listReplyAnswer(replyAnswer);
				countAnswer(replyAnswer);
			}
		}, "json");	
	}	
}






</script>
<style type="text/css">
#kim_article {
	display: block;
}
#kim_update {
	display:none;
}

</style>
<form name="dialogForm" method="post" enctype="multipart/form-data" id="dialogForm">
		
		<div id="kim_article">	
			<div style=" margin-top: 10px; width: 50%; margin: auto;"> 올린시간: ${dto.created}</div>
		<!-- 사진 -->
		<div style=" width: 550px; height: 340px; margin-top:5px; margin-left: 5px">
			<img class="img-responsive" src="<%=cp%>/uploadf/photo/${dto.imageFilename}" style="width: 550px; height: 340px;" border="0">
		</div>
			<!-- 작성자Id@ 좋아요수 -->
		<div style="clear: both; margin-top: 0px; height: 30px; margin-top: 15px;">
			<div style="float: left; margin-left:50px; min-width: 85px; margin-top: 30px; margin: auto;"> 작성자 :${dto.userId} </div>
		</div> 
		<!-- 그룹이른@ 올린시간  -->
		<div style="clear: both; margin-top: 0px; height: 30px; margin-top: 15px;">
			<div style="float: left; margin-left:50px; width: 50%; min-width: 85px; margin-top: 30px; margin: auto;"> 그룹 이름:${dto.groupName} </div>
		</div> 
	
			<h3 style="margin:auto; margin-top: 0px;">재 목: ${dto.subject}</h3>
		<div style="width: 570px; height: 100px; border: 1px solid black;">
		<!-- 재목@내용 -->
			<div style=" width: 50%;">
				<span>${dto.content}</span>
			</div>
			<input type="hidden" name="groupNum" value="${dto.gallyNum}">
				<!-- ,이렇게 타입 히든해서 안하면 컨트롤러에서 dto.groupNum 넘을 받아올수없다. --> 
		</div>
 </div>
 
 
 	<div id="kim_update">
		<div style=" width: 550px; height: 330px; margin-top:5px; margin-left: 5px">
		<img class="img-responsive" src="<%=cp%>/uploadf/photo/${dto.imageFilename}" style="width: 550px; height: 330px;" border="0">
		
		</div>
		수정 사진:<input type="file" name="upload" id="imageFilename" >
				<input type="hidden" name="imageFilename" value="${dto.imageFilename}">
		<div style="width: 50%;">
				<input type="text" name="subject" id="subject" value="${dto.subject}" style="clear: both;">
		</div>
		<textarea rows="5" name="content" id="content" required="required" style="width: 300px; height: 100px;">${dto.content}</textarea>
		<input type="hidden" name="gallyNum" value="${dto.gallyNum}">
		<div style="margin-top: 30px; margin-right: 30px;">      
		        		
				<button type="button" onclick="updateOK(${dto.gallyNum});">수정완료번튼</button>  	                 
				<button type="button" onclick="javascript:location.href='<%=cp%>/groupGally/list';">취소</button>			                 
		</div>
		
	</div>	
 
		<div style="margin-top: 30px; margin-right: 30px;"> 
			<c:if test="${sessionScope.member.userId==dto.userId}">	  		
				<button type="button" onclick="updatePhoto();"  class="btn btn-info btn-sm">수정</button>  	
			</c:if>   
			<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">            
				<button type="button"  onclick="deletePhoto(${dto.gallyNum});" class="btn btn-info btn-sm">삭제</button>
			</c:if>
			<button type="button" onclick="listPage('1')">리스트가기</button>	
	</div>
		
		<!--  리플 달려고 해논곳 -->		
	<div style="width: 570px; height: 200px; border: 1px solid black; margin-top: 10px; clear: both;">
	 
			<div>
					<h3 style="margin-left:100px; margin:auto; margin-top: 0px;">댓글쓰기 </h3>
					<div style="clear: both; padding-top: 10px;">
		             <textarea id="answerContent" class="form-control" rows="3"></textarea>
		            </div>
					<div style="text-align: right; padding-top: 10px;">           
		                   <button type="button" class="btn btn-primary btn-sm" onclick='GReply("${dto.gallyNum}");'> 댓글등록 <span class="glyphicon glyphicon-ok"></span></button>
		            </div>
		            
		           	
		    </div>
	</div>

		<div id="listGReply"></div>
</form>