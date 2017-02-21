<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String cp=request.getContextPath();

%>
<script type="text/javascript">
$(function(){
	listPageAnswer(1);
});

/* 글보기   댓글의!!!  할떄 리스트 나오게끔 해주는것   */
function listPageAnswer(pageNo){
	var url="<%=cp%>/group/photo/listGReply";
	var gallyNum="${dto.gallyNum}";	

	$.get(url, {gallyNum:gallyNum, pageNo:pageNo}, function(data){
		$("#listGReply").html(data);
		//밑에 있는 div에 listGReply.jsp 를 뿌릴것이다.  
	});
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
<div style=" margin-top: 10px; width: 100%">
<img class="img-responsive" src="<%=cp%>/uploadf/photo/${dto.imageFilename}" class="img-responsive" style="margin: auto;">
</div>
<h3 style="text-align: center; margin-bottom: 10px;">제목:${dto.subject}</h3>
<hr>
<div style="float: left;"> 작성자 :${dto.userId}<br></div>
<div style="float: right;"> 올린시간:${dto.created}</div>
<div style="clear: both;"></div>
<hr>
<div style="clear:both; width: 570px; height: 100px;">
<div style=" width: 50%;">
<span>내용: ${dto.content}<br></span>
</div>
<input type="hidden" name="groupNum" value="${dto.gallyNum}">
</div>
<div style="margin-top: 30px; margin-right: 30px;"> 
<c:if test="${sessionScope.member.userId==dto.userId}">	  		
<button type="button" onclick="updatePhoto();"  class="btn btn-info btn-sm">수정</button>  	
</c:if>   
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">            
<button type="button"  onclick="deletePhoto(${dto.gallyNum});" class="btn btn-info btn-sm">삭제</button>
</c:if>
<button type="button" class="btn btn-default btn-sm wbtn" onclick="updateCancel();">리스트가기</button>	
<button type="button" class="btn btn-default btn-sm wbtn" onclick="groupGallyLike('${dto.gallyNum}', '1')"><span class="glyphicon glyphicon-hand-up"></span> 좋아요 <span id="gallyLikeCount${dto.gallyNum}">${dto.gallyLikeCount}</span></button>            
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
<button type="button" onclick="updateOK(${dto.gallyNum});">수정</button>
</c:if>  	                 
<button type="button" onclick="updateCancel()">취소</button>			                 
</div>
</div>
<div>
<span>댓글</span>
<input type="text" id="answerContent" class="form-control">
<button type="button" class="btn btn-default btn-sm wbtn" onclick='GReply("${dto.gallyNum}");'> 댓글등록 <span class="glyphicon glyphicon-ok"></span></button>
</div>
<div id="listGReply"></div>
</form>