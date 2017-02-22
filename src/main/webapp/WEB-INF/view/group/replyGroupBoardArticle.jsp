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
	var url="<%=cp%>/group/reply/answer/created";
	$.get(url,{replyBoardNum:replyBoardNum, pageNo:pageNo},function(data){
		 $("#groupReplyBoard").html(data);
		 
	 });
}

</script>	

		<h2 class="text-center" style="margin-top: 100px;">
		${dto.groupName}그룹의&nbsp; 질문과&nbsp;&nbsp;답변<br> 
		</h2>

		<table style="width: 600px; margin: 20px auto 0px; ">
			  <tr>
			  <td colspan="2" height="3" bgcolor="#8B8A94" align="center">
			  ${dto.created}||&nbsp;게시물 번호:${dto.replyBoardNum}&nbsp;||&nbsp;&nbsp;조회수[${dto.hitcount}]</td></tr>
			
			  <tr align="left" height="40"> 
			      <td width="100" bgcolor="#A8ACB3" align="center">제 목</td>
			      <td width="500" style="padding-left:10px;">      
			      	${dto.subject}
			      
			      </td>
			  </tr>	
			   <tr align="left" height="40"> 
			      <td width="100" bgcolor="#A8ACB3" style="text-align: center;">내용  </td>
			      <td width="500" style="padding-left:10px;">      
			      	${dto.content}
			      </td>

			  </tr>

	 		 <tr align="left" height="40" >
			    <td width="100" bgcolor="#A8ACB3" style="text-align: center;">이전글</td>
			    <td width="500" style="padding-left:10px;">  
			       <c:if test="${not empty beforeReadDto}">
			              <a href="javascript:articleReplyBoard('${beforeReadDto.replyBoardNum}');">${beforeReadDto.subject}</a>
					</c:if>
				</td>
			</tr>
	
			
			<tr align="left" height="40">
			    <td width="100" bgcolor="#A8ACB3" style="text-align: center;">다음글</td>
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
			     <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">    
			      <input type="button" value=" 게시물삭제 " class="btn" onclick="deleteReplyBoard('${dto.replyBoardNum}');">
			      </c:if>
			      <input type="button" value="게시물답변" class="btn" onclick="submitReplyAnswer('${dto.replyBoardNum}','${page}');">
			    </td>
			
			    <td align="right">
			           <input type="button" value=" 리스트 " class="btn" onclick="replyBoardList(pageNo);">
			    </td>
			</tr>
			</table>		
