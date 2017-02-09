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
	    <div style="float: left;"><span style="color: #3EA9CD; font-weight: bold;">댓글 ${GReplyCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
	    <div style="float: right; text-align: right;"></div>
	</div>

		 <c:forEach var="GRP" items="${listGReply}">
	    <!-- 리플 내용 리스트 시작 -->
		
	    <div style="clear:both; margin-top:5px; padding: 10px; border: #d5d5d5 solid 1px; min-height: 130px;">
	        <div style="clear: both;">
	            <div style="float: left;"> ${GRP.created}</div>
	            <div style="float: right;  text-align: rigth;">
	<c:if test="${sessionScope.member.userId==GRP.userId || sessionScope.member.userId=='admin'}">		   
	               <a onclick='deletePhotoReply("${GRP.replyNum}", "${pageNo}");'> 댓 글삭제하기</a>
	               <!-- 댓글 삭재구간. -->
	</c:if>	  
	            </div>
	        </div>
	       <span>&nbsp;&nbsp;&nbsp;<img src="<%=cp%>/res/images/right.gif">&nbsp;&nbsp;[댓글 아이디]=${GRP.userId}</span>
	        <div style="clear: both; padding: 5px 0 5px 0px;  min-height: 70px;">[내   용]:${GRP.content}</div>
	        <div style="clear: both; min-height: 30px;" id="kimch">
	        
				            <div style="float: left;">
									<button type="button" class="btn btnGroupAnwerLaout" data-replyNum='${GRP.replyNum}'><img src="<%=cp%>/res/images/btn_reply.gif">
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
	        
	        	<div>
	        	
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
	                     
	    </div>  
		
	</c:forEach>


	<div style="clear: both; padding-top: 10px; text-align: center;">
	    ${paging}   
	</div>
</c:if>