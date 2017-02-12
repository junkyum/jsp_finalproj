<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.note-send-listFriend{
	clear:both;
	width:180px;
	height:260px;
	text-align: left;
	padding: 5px 5px 5px 5px;
	overflow: scroll;
	border:1px solid #ccc;
}
</style>

<script type="text/javascript">
// 친구 목록 가져오기
$(function(){
	var url = "<%=cp%>/note/listFriend.do";
	var now=new Date();
    $.post(url,{dumi:now.getTime()},function(data){
    	var s=$.trim(data);
		if(s=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;	
		}
		
        $('#noteListFriend').html(s);
  });
});

// 선택 항목 오른쪽으로 보내기 ------------
$(function(){
	$("#noteRightMoveButton").click(function(){
		var str;
	    var chks = $("#noteListFriend input:checked");
		var cnt = chks.length;
		if(cnt==0) {
			alert("보낼 친구를 먼저 선택하세요...")
			return;
		}

	    $.each(chks, function(e, ch) {
	        var userId= $(ch).val();
	        
	        $.each($("#noteListFriend tr"), function() {
		        if($(this).attr("data-tid")==userId) {
		        	str="<tr height='25' data-tid='"+userId+"'>";
		        	str+=$("#noteListFriend tr[data-tid='"+userId+"']").html();
		        	str+="</tr>";
		        	$("#noteListReceive").append(str);
		        	$("#noteListFriend tr[data-tid='"+userId+"']").remove();
		        }
	        });
	    });
		
	});
});

// 오른쪽으로 모두 보내기
$(function(){
	$("#noteRightAllMoveButton").click(function(){
		var str, userId;
        $.each($("#noteListFriend tr"), function() {
        	userId=$(this).attr("data-tid");
        	str="<tr height='25' data-tid='"+userId+"'>";
        	str+=$("#noteListFriend tr[data-tid='"+userId+"']").html();
        	str+="</tr>";
        	$("#noteListReceive").append(str);
        	$("#noteListFriend tr[data-tid='"+userId+"']").remove();
        });
	});
});

// 선택 항목 왼쪽으로 보내기 ------------
$(function(){
	$("#noteLeftMoveButton").click(function(){
		var str;
	    var chks = $("#noteListReceive input:checked");
		var cnt = chks.length;
		if(cnt==0) {
			alert("보내기를 해제할 친구를 먼저 선택하세요...")
			return false;
		}
		
	    $.each(chks, function(e, ch) {
	        var userId= $(ch).val();
	        $.each($("#noteListReceive tr"), function() {
		        if($(this).attr("data-tid")==userId) {
		        	str="<tr height='25' data-tid='"+userId+"'>";
		        	str+=$("#noteListReceive tr[data-tid='"+userId+"']").html();
		        	str+="</tr>";
		        	$("#noteListFriend").append(str);
		        	$("#noteListReceive tr[data-tid='"+userId+"']").remove();
		        }
	        });
	    });
	});
});

// 왼쪽으로 모두 보내기 ------------
$(function(){
	$("#noteLeftAllMoveButton").click(function(){
		var str, userId;
        $.each($("#noteListReceive tr"), function() {
        	userId=$(this).attr("data-tid");
        	str="<tr height='25' data-tid='"+userId+"'>";
        	str+=$("#noteListReceive tr[data-tid='"+userId+"']").html();
        	str+="</tr>";
        	$("#noteListFriend").append(str);
        	$("#noteListReceive tr[data-tid='"+userId+"']").remove();
        });
	});
});

// 쪽지보내기 ------------
function sendNoteOk() {
	var chks = $("#noteListReceive input[type=checkbox]");
	if(chks.length==0) {
		alert("쪽지를 받는 사람이 없습니다.");
		return;
	}
	
	var content=$.trim($("#noteContent").val());
	if(! content) {
		 alert("내용을 입력 하세요 !!!");
		 $("#noteContent").focus();
		 return;
	}
	
	var url="<%=cp%>/note/send";
	var query="content="+content;
	$.each($(chks), function() {
		query += "&userIds="+$(this).val();
	});
  	
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
    		
    		// var state=data.state;
    		$("#noteContent").val("");
    		$('#noteLeftAllMoveButton').trigger('click');
    		alert("메시지를 전송 했습니다.");
    	},
    	error:function(e) {
    		alert(e.responseText);
    	}
    });
}
</script>

<div>
    <div style="clear: both;">
         <div style="float: left; width: 180px;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">친구 목록</span>
             </div>
             <div class="note-send-listFriend">
                 <table style="border-spacing: 0px;">
                     <tbody id="noteListFriend"></tbody>
                 </table>
             </div>
         </div>
         <div style="float: left; width: 40px; line-height: 260px; height: 260px; text-align: ">
             <div class="btn-group-vertical" role="group" aria-label="Vertical button group">
             <button type="button" class="btn btn-default btn-sm" style="width: 40px;" id="noteRightMoveButton">&gt;</button>
             <button type="button" class="btn btn-default btn-sm" style="width: 40px;" id="noteRightAllMoveButton">&gt;&gt;</button>
             <button type="button" class="btn btn-default btn-sm" style="width: 40px;" id="noteLeftMoveButton">&lt;</button>
             <button type="button" class="btn btn-default btn-sm" style="width: 40px;" id="noteLeftAllMoveButton">&lt;&lt;</button>
             </div>
         </div>
         <div style="float: left; width: 180px;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">받는 친구</span>
             </div>
             <div class="note-send-listFriend">
                 <table style="border-spacing: 0px;">
                     <tbody id="noteListReceive"></tbody>
                 </table>
             </div>             
         </div>
    </div>
    <div style="clear: both; max-width: 400px; padding-top:5px;">
        <div>
            <textarea id="noteContent" class="form-control" rows="3"></textarea>
        </div>
        <div style="padding-top:5px; text-align: right;">
            <button type="button" class="btn btn-primary" onclick="sendNoteOk();"> 보내기 <span class="glyphicon glyphicon-ok"></span></button>
        </div>
    </div>
</div>
