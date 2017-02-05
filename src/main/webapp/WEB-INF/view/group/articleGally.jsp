<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
//글보그 창 
%>
<script type="text/javascript">
$(function(){
	listPageAnswer(1);
});

/* 글보기   댓글의!!!  할떄 리스트 나오게끔 해주는것   */
function listPageAnswer(pageNo){
	var url="<%=cp%>/group/photo/listGReply";
	var gallyNum="${dto.gallyNum}";	
	alert("리스트1번");
	$.get(url, {gallyNum:gallyNum, pageNo:pageNo}, function(data){
		alert("리스트2번");
		$("#listGReply").html(data);
		//밑에 있는 div에 listGReply.jsp 를 뿌릴것이다.  
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
			alert("숨긴다");
		} else if (!isVisible){
			$divGroupReplyAnswer.show();
			alert("보인다.");
			//답변 버튼눌럿을떄도 리스트나오게 하는것 listPageAnswer
			listReplyAnswer(replyNum);
			countAnswer(replyNum);
			listPageAnswer(1);
		}
		
	});
});



//게시판 밑에 답글 밑에 답글 등록하는 메소드
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
				countAnswer(replyNum);
			
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
		
	});	
}
////사진의 댓들을 단것을 삭제하기 위해만든것  삭제구간.  deletePhotoReply(
function deletePhotoReply(replyNum, pageNo) {
	var userId="${sessionScope.member.userId}";
    	
	if(confirm("댓글 삭제 하시겟습니까?")){
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

//게시물 답글의 좋아요@싫어요 추가시키는 구간
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



function groupGallyLikeCount(gallyNum) {
	var url="<%=cp%>/group/photo/groupGallyLikeCount";
	$.post(url, {gallyNum:gallyNum}, function(data){
		var gallyLikeCountId="#gallyLikeCount"+gallyNum;
		var gallyLikeCount=data.gallyLikeCount;
		
		$(gallyLikeCountId).html(gallyLikeCount);
	}, "JSON");
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
				<span>
				내용: ${dto.content}<br>
				재 목: ${dto.subject}<br>
				올린시간: ${dto.created}<br>
				작성자 :${dto.userId}<br>
				그룹 이름:${dto.groupName}<br>
				사진의 번호:${dto.gallyNum} 
				</span>
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
		      <c:if test="${sessionScope.member.userId==dto.userId}">	 
				<button type="button" onclick="updateOK(${dto.gallyNum});">수정완료번튼</button>
			  </c:if>  	                 
				<button type="button" onclick="updateCancel()">취소</button>			                 
		</div>
		
	</div>	
 
		<div style="margin-top: 30px; margin-right: 30px;"> 
		
			<c:if test="${sessionScope.member.userId==dto.userId}">	  		
				<button type="button" onclick="updatePhoto();"  class="btn btn-info btn-sm">수정</button>  	
			</c:if>   
			
			<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">            
				<button type="button"  onclick="deletePhoto(${dto.gallyNum});" class="btn btn-info btn-sm">삭제</button>
			</c:if>
			<button type="button" onclick="updateCancel();">리스트가기</button>	
			<button type="button" class="btn btn-default btn-sm wbtn" onclick="groupGallyLike('${dto.gallyNum}', '1')"><span class="glyphicon glyphicon-hand-up"></span> 좋아요 <span id="gallyLikeCount${dto.gallyNum}">${dto.gallyLikeCount}</span></button>
                        
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