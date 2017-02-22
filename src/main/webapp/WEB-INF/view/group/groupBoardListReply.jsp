<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<c:if test="${ReplydataCount!=0}">
	<div style="clear: both; padding-top: 20px;">
	    <div style="float: left;"><span style="color: #3EA9CD; font-weight: bold;">댓글 ${ReplydataCount}개</span> </div>
	    <div style="float: right; text-align: right;"></div>
	</div>
	<c:forEach var="dto" items="${gboardReplyList}">
	<div style="clear:both; margin-top:5px; padding: 10px; border: #d5d5d5 solid 1px; min-height: 130px;">
	        <div style="clear: both;">
	            <div style="float: left;"> ${dto.created}</div>
	            <div style="float: right;  text-align: rigth;">
					<c:if test="${sessionScope.member.userId==dto.userId }">		   
		               <a onclick='deleteBoardReply("${dto.replyNum}","${page}");'>댓글삭제</a>
					</c:if>	 
	            </div>
	        </div>
	        <div style="clear: both; padding: 5px 0 5px 0px;  min-height: 70px;"> 
	        ${dto.content}<br>>
	        </div>
	        <div style="clear: both; min-height: 30px;" id="kimch">      
	            <div style="float: left;">
						<button type="button" class="btn btnGroupReplyAnwerLaout" data-replyNum='${dto.replyNum}'>답글
						<span id="gbAnswerCount${dto.replyNum}">${dto.answerCount}</span> </button>
	            </div>   
	            <div style="float: right;">
	            	<button type="button" onclick="kmSendReplyLike('${dto.replyNum}', '1')">
	            	<span id="kmLikeCount${dto.replyNum}">좋아요 (${dto.likeCount})</span></button>
	            	
	            	<button type="button" onclick="kmSendReplyLike('${dto.replyNum}', '0')">
	            	<span id="kmDisLikeCount${dto.replyNum}">싫어요 (${dto.disLikeCount})</span></button>
	            </div>                           
	        </div>
	       <div class="GroupReplyAnswerkm" style="display: none;">  
	        	<div>
		        	<div id="kmListReplyAnswer${dto.replyNum}" class="answerGroupBoardList"></div>
		        	<div style='clear: both; padding: 10px 10px;'>
		                <div style='float: left; width: 5%;'>└</div>
		                <div style='float: left; width:95%'>
					<textarea id="gboardAnswerContent${dto.replyNum}" cols='72' rows='10' class='boxTA' style='width:500px; height: 70px;'></textarea>
		                 </div>
		            </div>
		             <div style='padding: 0px 10px 10px; text-align: right;'>
			                <button type='button' class='btn' onclick="gboardSendGReplyAnswer('${dto.replyNum}','${dto.boardNum}');">답  변</button>
			         </div>			         
	        	</div>
	        </div>	                     
	    </div>  
	</c:forEach>
<tr height='30'>
    <td colspan='4' align='center'>
    ${paging}
</td>
</tr>

</c:if>