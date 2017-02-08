<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
//이곳에서 수정@삭제@등록 할것이다 
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
	//alert(subject+","+content+","+mode)
	var query="subject="+subject;
	query+="&content="+content;
	query+="&groupName="+groupName;
	if(mode=="created"){
		var url="<%=cp%>/group/reply/created"
		
		var pageNo=1;
		var searchKeyC="subject";
		var searchValueC="";
	}
	
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="false"){
				alert("실패했다");
			} else {
				alert("들어갓다!붕아");
			}
		
			replyBoardList(pageNo);
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
				<i class="glyphicon glyphicon-info-sign"></i> 궁금한 점은 이곳에 글을 남겨 주시면 성심껏 답변 해드리겠습니다.</h2>

		<table style="width: 600px; margin: 20px auto 0px; border-spacing: 0px;">
			  <tr><td colspan="2" height="3" bgcolor="#507CD1"></td></tr>
			
			  <tr align="left" height="40"> 
			      <td width="100" bgcolor="#EEEEEE" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td width="500" style="padding-left:10px;">      
			      <input type="hidden" name="${groupName}" value="${groupName}">
			      <input type="text" id="chSubject" name="chSubject" size="75" maxlength="100" class="boxTF" value="#">
			      </td>
			  </tr>	
			  <tr align="left"> 
			      <td width="100" bgcolor="#EEEEEE" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td width="500" valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea id="chContent" name="chContent" cols="75" rows="12"></textarea>
			      </td>
			  </tr>
		</table>
		<table>
			<tr>
				<td>
					<div style="margin-left: 450px; border-bottom:10px;">
					 <input type="button" value=" ${mode=='created'?'등  록':'수정완료'} " class="btn" onclick="submitReplyOK();">
      				 <input type="reset" value=" 다시입력 " class="btn">
					 <input type="button" value=" ${mode=='created'?'리스트가기':'수정취소'} " class="btn" onclick="replyBoardList(pageNo);">
					</div>
				</td>
			</tr>
		</table>
</form>

