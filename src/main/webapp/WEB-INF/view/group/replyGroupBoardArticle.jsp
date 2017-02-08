<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
	//전체적인 리스트 뿌리는 곳!!!
%>


				<h2 class="text-center">[${dto.groupName}]&nbsp;그룹의&nbsp; 질문&nbsp;&nbsp;과&nbsp;&nbsp;답변<br> 
				<i class="glyphicon glyphicon-info-sign"></i> 궁금한 점은 이곳에 글을 남겨 주시면 성심껏 답변 해드리겠습니다.</h2>

		<table style="width: 600px; margin: 20px auto 0px; border-spacing: 0px; border: 2px solid;">
			  <tr><td colspan="2" height="3" bgcolor="#D4F4FA" align="center">${dto.created}||&nbsp;리플 번호=[${dto.replyBoardNum}]</td></tr>
			
			  <tr align="left" height="40" style="border: 1px solid;"> 
			      <td width="100" bgcolor="#EEEEEE" align="center">제 목 </td>
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
	 
		</table>
		
		<table style="width: 600px; margin: 0px auto; border-spacing: 0px;">
			<tr height="35">
			    <td width="50%" align="left">
			          <input type="button" value=" 게시판수정 " class="btn" onclick="#;">
			          <input type="button" value=" 게시판삭제 " class="btn" onclick="#">
			    </td>
			
			    <td align="right">
			           <input type="button" value=" 리스트 " class="btn" onclick="replyBoardList(pageNo);">
			    </td>
			</tr>
			</table>		
