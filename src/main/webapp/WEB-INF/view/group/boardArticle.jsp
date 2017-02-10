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
	$.post(url, {boardNum:boardNum, page:page}, function(data){
		$("#groupBoardListReply").html(data);
	});
}

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
							<td style="text-align: left;">이름 : ${dto.userName }</td>
							<td style="text-align: right;">${dto.created } | 조회 :
								${dto.hitCount }</td>
						</tr>
						<tr>
							<td colspan="2" style="height: 230px;">${dto.content }</td>
						</tr>
						<tr>
							<td colspan="2"><span
								style="display: inline-block; min-width: 45px;">첨부</span> : <a
								href="<%=cp%>/group/gboard/download?boardNum=${dto.boardNum}">
									${dto.originalFilename}(<fmt:formatNumber
										value="${dto.fileSize/1024}" pattern="0.0" /> KB) <span
									class="glyphicon glyphicon-save"></span>
							</a></td>
							<td colspan="2">
								<button type="button" class="btn btn-default btn-sm wbtn" onclick="groupBoardLike('${dto.boardNum}', '1')">
									<span class="glyphicon glyphicon-hand-up"></span>
									<span id="boardLikeCount${dto.boardNum}">${dto.boardLikeCount}</span></button>
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




















				<div>
                     <table>
	                     <tr>
	                         <td colspan="2">
	                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
	                              <c:if test="${not empty preReadDto }">
	                              		<a href="<%=cp%>/group/gboard/boardArticle?boardNum=${preReadDto.boardNum}">${preReadDto.subject }</a>
	                              </c:if>
	                         </td>
	                     </tr>
	                     <tr>
	                         <td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
	                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
	                               <c:if test="${not empty nextReadDto }">
	                              		<a href="<%=cp%>/group/gboard/boardArticle?boardNum=${nextReadDto.boardNum}">${nextReadDto.subject }</a>
	                              </c:if>
	                         </td>
	                     </tr>                                          
	               
	                
	                	<tr>
	                		<td>
	                		    <button type="button" class="btn btn-default btn-sm wbtn">수정</button>
	                		    <button type="button" class="btn btn-default btn-sm wbtn"<%--  onclick="deleteBoard('${dto.num}')" --%>>삭제</button>
	                		</td>
	                		<td align="right">
	                		    <button type="button" class="btn btn-default btn-sm wbtn" 
	                		    	onclick="groupBaordListGo(${page});"> 목록으로 </button>
	                		</td>
	                	</tr>
	                	</table>
                </div>
            
       </div>
   </div>
</div>
</body>

