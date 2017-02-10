<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.table td {
    font-weight: normal;
    border-top: none;
}
.table .note-header{
    border: #d5d5d5 solid 1px;
    background: #eeeeee; color: #787878;
}
.articleContent{
  display: inline-block; width: max-500px;  position:relative; top:5px;
  white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
}
</style>

<script type="text/javascript">
$(function(){
	var mode="${mode}";
	var page="${pageNo}";
	var searchKey="${searchKey}";
	var searchValue="${searchValue}";
	
   $("#btnArticleList").click(function(){
		var url="<%=cp%>/note/list";
		$.get(url, {mode:mode, pageNo:page, searchKey:searchKey, searchValue:searchValue}, function(data){
			var s=$.trim(data);
			if(s=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;	
			}
			
			var id;
			if(mode=="listReceive") {
				id="#tabListReceive";
				$("#tabListSend").html("");
			} else {
				id="#tabListSend";
				$("#tabListReceive").html("");
			}
			$(id).html(data);			
			
		});
   });
   
   $("#btnArticleDelete").click(function(){
		var num="${dto.num}";
	   
		if(! confirm("게시물을 삭제 하시 겠습니까 ? ")) {
			return;
		}
		
		var url="<%=cp%>/note/delete";
		$.post(url, {nums:num, mode:mode, pageNo:page, searchKey:searchKey, searchValue:searchValue}, function(data){
			var s=$.trim(data);
			if(s=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;	
			}
			
			var id;
			if(mode=="listReceive") {
				id="#tabListReceive";
				$("#tabListSend").html("");
			} else {
				id="#tabListSend";
				$("#tabListReceive").html("");
			}
			$(id).html(data);
		});
   });
});

function articleView(num) {
	var mode="${mode}";
	var page="${pageNo}";
	var searchKey="${searchKey}";
	var searchValue="${searchValue}";
	
	var url="<%=cp%>/note/article";

	$.post(url, {num:num, mode:mode, pageNo:page, searchKey:searchKey, searchValue:searchValue}, function(data){
		var s=$.trim(data);
		if(s=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;	
		}
		
		var id;
		if(mode=="listReceive") {
			id="#tabListReceive";
			$("#tabListSend").html("");
		} else {
			id="#tabListSend";
			$("#tabListReceive").html("");
		}
		$(id).html(data);
	});
	
}

function sendReplyModal() {
	$("#replyContent").val("");
	$('#noteReplyModal').modal('show');
}

function sendReplyOk() {
	var content=$.trim($("#replyContent").val());
	if(! content) {
		alert("내용을 입력 하세요...");
		$("#replyContent").focus();
		return;
	}
	
	$('#noteReplyModal').modal('hide');
	
	var url="<%=cp%>/note/send";
	var query="content="+content;
	query += "&userIds=${dto.sendUserId}";
	query += "&parent=${dto.num}";
    $.ajax({
    	type:"POST",
    	url:url,
    	data:query,
    	dataType:"json",
    	success:function(data){
        	var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/member/login";
				return;
			}
			
			// articleView("${dto.num}");
    	}
   	});
}
</script>

<div style="height: 40px; line-height: 40px;">
    <c:if test="${mode=='listReceive'}">
        <button type="button" class="btn btn-default btn-sm" onclick="sendReplyModal();">답장</button>
    </c:if>
    <button type="button" class="btn btn-default btn-sm" id="btnArticleDelete">삭제</button>
    <c:if test="${empty preDto}">
        <button type="button" class="btn btn-default btn-sm disabled">이전</button>
    </c:if>
    <c:if test="${not empty preDto}">
        <button type="button" class="btn btn-default btn-sm" onclick="articleView('${preDto.num}');">이전</button>
    </c:if>
    <c:if test="${empty nextDto}">
        <button type="button" class="btn btn-default btn-sm disabled">다음</button>
    </c:if>
    <c:if test="${not empty nextDto}">
        <button type="button" class="btn btn-default btn-sm" onclick="articleView('${nextDto.num}');">다음</button>
    </c:if>
    <button type="button" class="btn btn-default btn-sm" id="btnArticleList">리스트</button>
</div>
<div class='table-responsive' style='clear: both; padding-top: 5px;'>
    <table class='table'>
           <tr class='note-header'>
               <td style='width: 50%;'>
                   <c:if test="${mode=='listReceive'}">
                            보낸사람 : ${dto.sendUserName}[${dto.sendUserId}]
                   </c:if>
                   <c:if test="${mode=='listSend'}">
                            받는사람 : ${dto.receiveUserName}[${dto.receiveUserId}]
                   </c:if>
               </td>
               <td style='width: 50%; text-align: right;'>
                   <c:if test="${mode=='listReceive'}">
                            받은날짜 : ${dto.sendDay}
                   </c:if>
                   <c:if test="${mode=='listSend'}">
                            보낸날짜 : ${dto.sendDay}
                   </c:if>
               </td>
           </tr>
           <tr style='height: 70px;'>
               <td colspan='2'>
                    ${dto.content}
               </td>
           </tr>
           <tr style='height: 25px;'>
               <td colspan='2'>
                    이전 : 
                   <c:if test="${not empty preDto}">
                       <span class="articleContent">
                           [${mode=='listReceive' ? preDto.sendUserName : preDto.receiveUserName}]
                           <a href="javascript:articleView('${preDto.num}');">${preDto.content}</a>
                        </span>
                   </c:if>
               </td>
           </tr>
           <tr style='height: 25px; border-bottom: 1px solid #ddd;'>
               <td colspan='2'>
                    다음 : 
                   <c:if test="${not empty nextDto}">
                       <span class="articleContent">
                           [${mode=='listReceive' ? nextDto.sendUserName : nextDto.receiveUserName}]
                           <a href="javascript:articleView('${nextDto.num}');">${nextDto.content}</a>
                       </span>
                   </c:if>
               </td>
           </tr>
       </table>
</div>

<c:if test="${mode=='listReceive'}">
<div class="modal fade" id="noteReplyModal" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content modal-sm"  style="min-width: 400px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="replyModalLabel" style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">답장 보내기</h4>
      </div>
      <div class="modal-body">
          <div>
              <textarea id="replyContent"  class="form-control" rows="3"></textarea>
          </div>
          <div style="padding-top:5px; text-align: right;">
              <button type="button" class="btn btn-primary" onclick="sendReplyOk();"> 보내기 <span class="glyphicon glyphicon-ok"></span></button>
          </div>
      </div>
    </div>
  </div>
</div>
</c:if>
