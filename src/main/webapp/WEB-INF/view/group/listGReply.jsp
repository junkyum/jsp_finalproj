<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
//글보기 후 밑에 나오는 답글 리스트
%>

<c:if test="${GReplyCount!=0}">
<div style="clear: both; padding-top: 20px;">
<div style="float: left;"><span style="color: #3EA9CD; font-weight: bold;">댓글 ${GReplyCount}개</span></div>

</div>
<c:forEach var="GRP" items="${listGReply}">
<!-- 리플 내용 리스트 시작 -->
<div style="margin-top:5px; padding: 10px;">
<span>아이디:${GRP.userId}</span><br>
<span>${GRP.created}</span>
<div >내   용:${GRP.content}<br>
<c:if test="${sessionScope.member.userId==GRP.userId || sessionScope.member.userId=='admin'}">		   
<a onclick='deletePhotoReply("${GRP.replyNum}", "${pageNo}");'>삭제하기</a>
</c:if></div>
<div style="min-height: 30px;" id="kimch">
<div style="float: left;">
<button type="button" class="btn btnGroupAnwerLaout" data-replyNum='${GRP.replyNum}'>
<img src="<%=cp%>/res/images//REPLY.png" style = "width: 25px;">
<span id="answerCount${GRP.replyNum}">${GRP.answerCount}</span> </button>
</div>   
<!-- 좋아 싫어 있는 버튼 -->
<div style="float: right;">
<button type="button" onclick="sendReplyLike('${GRP.replyNum}', '1')">좋아요
<span id="likeCount${GRP.replyNum}">${GRP.likeCount}</span></button>

<button type="button" onclick="sendReplyLike('${GRP.replyNum}', '0')">싫어요
<span id="disLikeCount${GRP.replyNum}">${GRP.disLikeCount}</span></button>
        </div>                           
 </div>
<div class="GroupReplyAnswer" style="display: none;">  
<div id="listReplyAnswer${GRP.replyNum}" class="answerGList"></div>

<div style='clear: both; padding: 10px 10px;'>
<div style='float: left; width: 5%;'>└</div>
<div style='float: left; width:95%'>
<textarea id="answerContent${GRP.replyNum}" cols='72' rows='10' class='boxTA' style='width:500px; height: 70px;'></textarea>
     </div>
</div>

<div style='padding: 0px 10px 10px; text-align: right;'>
<button type='button' class='btn' onclick="sendGReplyAnswer('${GRP.replyNum}','${GRP.gallyNum}');">답  변</button>
</div>
</div>
             
</div>  

</c:forEach>


<div style="clear: both; padding-top: 10px; text-align: center;">
${paging}   
</div>
</c:if>