<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
	//전체적인 리스트 뿌리는 곳!!!
%>
<script type="text/javascript">
function updateReplyBoard(replyBoardNum) {

	var url="<%=cp%>/group/reply/update";
	var pageNo= "${page}";
	$.get(url, {replyBoardNum:replyBoardNum, pageNo:pageNo}, function(data) {
		$("#groupReplyBoard").html(data);
	});
}
function submitReplyAnswer(replyBoardNum, pageNo) {
	alert("처음")
	var url="<%=cp%>/group/reply/answer/created";
	$.get(url,{replyBoardNum:replyBoardNum, pageNo:pageNo},function(data){
		 $("#groupReplyBoard").html(data);
	 });
}

</script>	

				<h2 class="text-center">[${dto.groupName}]&nbsp;그룹의&nbsp; 질문&nbsp;&nbsp;과&nbsp;&nbsp;답변<br> 
				<i class="glyphicon glyphicon-info-sign"></i> 궁금한 점은 이곳에 글을 남겨 주시면 성심껏 답변 해드리겠습니다.</h2>

		<table style="width: 600px; margin: 20px auto 0px; border-spacing: 0px; border: 2px solid;">
			  <tr><td colspan="2" height="3" bgcolor="#D4F4FA" align="center">
			  ${dto.created}||&nbsp;리플 번호=[   ]&nbsp;||&nbsp;&nbsp;방문자수[${dto.hitcount}]</td></tr>
			
			  <tr align="left" height="40" style="border: 1px solid;"> 
			      <td width="100" bgcolor="#EEEEEE" align="center">제 목 [${page}]</td>
			      <td width="500" style="padding-left:10px;">      
			      	${dto.subject}
			      
			      </td>
			  </tr>	
			   <tr align="left" height="40"> 
			      <td width="100" bgcolor="#EEEEEE" style="text-align: center;">내용  </td>
			      <td width="500" style="padding-left:10px;">      
			      	${dto.content}
			      </td>

			  </tr>

	 		 <tr align="left" height="40" style="border: 1px solid;">
			    <td width="100" bgcolor="#EEEEEE" style="text-align: center;">이전글</td>
			    <td width="500" style="padding-left:10px;">  
			       <c:if test="${not empty beforeReadDto}">
			              <a href="javascript:articleReplyBoard('${beforeReadDto.replyBoardNum}');">${beforeReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
	
			
			<tr align="left" height="40">
			    <td width="100" bgcolor="#EEEEEE" style="text-align: center;">다음글</td>
			    <td width="500" style="padding-left:10px;">  
			       <c:if test="${not empty afterReadDto}">
			              <a href="javascript:articleReplyBoard('${afterReadDto.replyBoardNum}');">${afterReadDto.subject}</a>
					</c:if>
			    </td>
			</tr>
		</table>
	
		<table style="width: 600px; margin: 0px auto; border-spacing: 0px;">
			<tr height="35">
			    <td width="50%" align="left">
			    <c:if test="${sessionScope.member.userId==dto.userId}">	
			          <input type="button" value=" 게시판수정 " class="btn" onclick="updateReplyBoard('${dto.replyBoardNum}');">
			     </c:if> 
			     <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">    
			          <input type="button" value=" 게시판삭제 " class="btn" onclick="deleteReplyBoard('${dto.replyBoardNum}');">
			      </c:if>
			      <input type="button" value="게시물답변" onclick="submitReplyAnswer('${dto.replyBoardNum}','${page}');">
			    </td>
			
			    <td align="right">
			           <input type="button" value=" 리스트 " class="btn" onclick="replyBoardList(pageNo);">
			    </td>
			</tr>
			</table>		
