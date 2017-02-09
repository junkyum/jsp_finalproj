<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
/* 
	등록-> 완료
	삭제-> 완료
	수정-> 미완
*/
%>
<script type="text/javascript">
function submitReplyOK() {
	var subject=$("#chSubject").val();
	var content=$("#chContent").val();
	var groupName="${groupName}";
	if(!subject){
		 $("#chSubject").focus();
         return;
	}
	if(!content){
		 $("#chContent").focus();
        return;
	}
	
	var mode="${mode}";

	var query="subject="+subject;
	query+="&content="+content;
	query+="&groupName="+groupName;
	if(mode=="created"){
		var url="<%=cp%>/group/reply/created"

	} else if (mode=="update"){
		var url="<%=cp%>/group/reply/update"
		var replyBoardNum="${dto.replyBoardNum}";
			query+="&replyBoardNum=x`"+replyBoardNum;
	}
	
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="false"){
				console.log("실패했다");
			} else {
				console.log("입력했어요");
			replyBoardList(pageNo);
			}
		
		}
		,error:function(e) {
			console.log(e.responseText);
		}
		
	});
}

function submitReplyAnswerOK() {
	var subject=$("#chSubject").val();
	var content=$("#chContent").val();
	var groupName="${dto.groupName}";
	var page="${page}";
	var groupNumber="${dto.groupNumber}";
	var orderNo="${dto.orderNo}";
	var depth="${dto.depth}";
	var parent="${dto.replyBoardNum}";
	if(!subject){
		 $("#chSubject").focus();
         return;
	}
	if(!content){
		 $("#chContent").focus();
        return;
	}

	var url="<%=cp%>/group/reply/answer/created";
 	var query="subject="+subject+"&content="+content+"&groupName="+groupName+"&groupNumber="+groupNumber;
	query+="&orderNo"+orderNo+"&depth="+depth+"&parent="+parent;
	

	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="false"){
				console.log("실패했다");
			} else {
				console.log("입력했어요");
			replyBoardList(pageNo);
			}
		
		}
		,error:function(e) {
			console.log(e.responseText);
		}
		
	});
		
}


</script>

<br><br>
<form name="replyBoardForm">
				<h2 class="text-center">[${groupName}]&nbsp;그룹의&nbsp; 질문&nbsp;&nbsp;과&nbsp;&nbsp;답변<br> 
				<i class="glyphicon glyphicon-info-sign"></i> 궁금한 점은 이곳에 작성, 성심껏 답변 해드리겠습니다.</h2>

		<table style="width: 600px; margin: 20px auto 0px; border-spacing: 0px;">
			  <tr><td colspan="2" height="3" bgcolor="#507CD1"></td></tr>
			
			  <tr align="left" height="40"> 
			      <td width="100" bgcolor="#EEEEEE" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td width="500" style="padding-left:10px;">      
			      <input type="hidden" name="${groupName}" value="${groupName}">
			      <input type="text" id="chSubject" name="chSubject" size="75" maxlength="100" class="boxTF" value="${dto.subject}">
			      </td>
			  </tr>	
			  <tr align="left"> 
			      <td width="100" bgcolor="#EEEEEE" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td width="500" valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea id="chContent" name="chContent" cols="75" rows="12">${dto.content}</textarea>
			      </td>
			  </tr>
		</table>
		<table>
			<tr>
				<td>
					<div style="margin-left: 450px; border-bottom:10px;">
					<c:if test="${mode !='reply'}">
					 <input type="button" value=" ${mode=='created'?'등  록':'수정완료'} " class="btn" onclick="submitReplyOK();">
					 <input type="button" value=" ${mode=='created'?'리스트가기':'수정취소'} " class="btn" onclick="replyBoardList(pageNo);">
					 </c:if>
					 <c:if test="${mode=='reply'}">
					 <input type="button" value=" 답  변 " class="btn" onclick="submitReplyAnswerOK();">
					 <input type="button" value=" 답변 취소" class="btn" onclick="replyBoardList(pageNo);">
					 </c:if>
      				 <input type="reset" value=" 다시입력 " class="btn">
					</div>
					 <c:if test="${mode=='update'}">
						<input type="hidden" name="replyBoardNum" value="${dto.replyBoardNum}">
						<input type="hidden" name="pageNo" value="${pageNo}">
					</c:if>
					<c:if test="${mode=='reply'}">
						<input type="hidden" name="page" value="${page}">
                        <input type="hidden" name="groupNumber" value="${dto.groupNumber}">
                        <input type="hidden" name="orderNo" value="${dto.orderNo}">
                        <input type="hidden" name="depth" value="${dto.depth}">
                        <input type="hidden" name="parent" value="${dto.replyBoardNum}">
                        <input type="hidden" name="groupName" value="${dto.groupName}">
					</c:if>
				</td>
			</tr>
		</table>
</form>
