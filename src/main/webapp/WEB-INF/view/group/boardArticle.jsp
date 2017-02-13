<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
.container {
	width: 900px;
	height: 680px;
	border: 1px solid #5D5D5D;
}
</style>
<script type="text/javascript">
$(function(){
	gboardReplyListpage(1);
});

function gboardReplyListpage(page){
	var url="<%=cp%>/group/gboard/listReply";
	var boardNum="${dto.boardNum}";
	$.get(url, {boardNum:boardNum, page:page}, function(data){
		$("#groupBoardListReply").html(data);
	});
}

function updateGBoard(boardNum,page) {
	var url="<%=cp%>/group/gboard/update?boardNum="+boardNum+"&page="+page;
	alert(boardNum);
	$("#myModalUpdate .modal-body").load(url, function() {
	    $("#myModalUpdate .modal-title").html('정보 수정');
		$("#myModalUpdate").modal('show');
		$("input[name='name']").focus();
	});
}

/* function updateCancel() {
	$('#myModalUpdate').modal('hide');
}

function updateOk() {
	alert("ok");
}
 */
</script>
<head>
</head>
<body>
<div class="bodyFrame2">
    
    
    <div class="table-responsive" style="clear: both;">
        <div class="bbs-article">
				<table class="table">
					<thead>
						<tr>
							<th colspan="2" style="text-align: center;">${dto.subject }
							</th>
						</tr>
					<thead>
						<tr>
							<td style="text-align: left;">글쓴이 : ${dto.userId }</td>
							<td style="text-align: right;">${dto.created } | 조회 :
								${dto.hitCount }</td>
						</tr>
						<tr>
							<td colspan="2" style="height: 230px;">${dto.content }</td>
						</tr>
						<tr>
							<td colspan="2">
								<c:if test="${dto.fileSize > 0 }">
									<span>첨부</span> : 
							<a href="<%=cp%>/group/gboard/download?boardNum=${dto.boardNum}">
									${dto.originalFilename}(<fmt:formatNumber value="${dto.fileSize/1024}" pattern="0.0" /> KB) 
									<span class="glyphicon glyphicon-save"></span>
							</a></c:if></td>
							<td colspan="2">
								<button type="button" class="btn btn-default btn-sm wbtn" onclick="groupBoardLike('${dto.boardNum}', '1')">
									<span class="glyphicon glyphicon-hand-up"></span>
									<span id="boardLikeCount${dto.boardNum}">${dto.boardLikeCount}</span></button>
							</td>
						</tr>
							
						<tr>
	                         <td colspan="2">
	                              <span class="glyphicon glyphicon-triangle-top"></span>
	                              <c:if test="${not empty preReadDto }">	                              		
	                              		<a onclick="articleGroupBoard(${preReadDto.boardNum},${page});">${preReadDto.subject }</a>
	                              </c:if>
	                         </td>
	                     </tr>
	                     <tr>
	                         <td colspan="2" >
	                              <span class="glyphicon glyphicon-triangle-bottom"></span>
	                               <c:if test="${not empty nextReadDto }">
	                              		<a onclick="articleGroupBoard(${nextReadDto.boardNum},${page});">${nextReadDto.subject }</a>
	                              </c:if>
	                         </td>
	                     </tr>
	                	<tr>
	                		<td>
	                		<c:if test="${sessionScope.member.userId==dto.userId}">
	                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="updateGBoard(${dto.boardNum},${page });">수정</button>
	                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="deleteBoard(${dto.boardNum},${page },${dto.fileNum });">삭제</button>
	                		</c:if>
	                		</td>
	                		<td align="right">
	                		    <button type="button" class="btn btn-default btn-sm wbtn" 
	                		    	onclick="groupBaordListGo(${page});">
	                		    	<span class="glyphicon glyphicon-list"></span>
	                		     </button>
	                		</td>
	                	</tr>
				</table>
				

 <!-- 리플 달기 디쟌  -->
	
		<div id="groupBoardListReply" style="width:600px; margin: 0px auto;"></div>
		
				<table style="margin: 0px auto; border-spacing: 0px;">
					<tr height="50">
						<td align="left">
							<textarea rows="5" cols="85" class="boxTF" id="gboardReplyContent" style="width: 600px; height: 45px;"></textarea>
						</td>
						<td width="80" align="right">
							<button type="button" id="btngboardReplySend" onclick="gboardsendReply(${dto.boardNum})"
								class="btn" style="width: 60px; height: 52px;">등록</button>
						</td>
					</tr>
				</table>
       </div>
   </div>
</div>


<div class="modal fade" id="myModalUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel" style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">수정</h4>
      </div>
      <div class="modal-body"></div>
    </div>
  </div>
</div>
</body>

