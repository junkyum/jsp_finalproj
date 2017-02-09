<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
	//전체적인 리스트 뿌리는 곳!!!
%>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">

var pageNo=1;
var searchKeyC="subject";
var searchValueC="";
/* 위에꺼 안하면 이전@이다음글찾지 못한다. */
$(function(){
	replyBoardList(1);	
});

// 맨처음 글 리스트 뽑아준다.
function replyBoardList(page) {
	var url="<%=cp%>/group/reply/list";
	var query="pageNo="+page+"&searchKeyC="+searchKeyC+"&searchValueC="+searchValueC;
	var groupName="${groupName}"
	
	query+="&groupName="+groupName;
	pageNo=page;
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
			$("#groupReplyBoard").html(data);
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}

//글을 등록할것이다.  처음 겟방식
function submitReply() {
	var groupName="${groupName}"
	 var url="<%=cp%>/group/reply/created";
	 $.get(url,{groupName:groupName},function(data){
		 $("#groupReplyBoard").html(data);
	 });
	 
}

function articleReplyBoard(replyBoardNum) {

	var url="<%=cp%>/group/reply/article";
	var query="pageNo="+pageNo+"&searchKeyC="+searchKeyC+"&searchValueC="+searchValueC;
	query+="&replyBoardNum="+replyBoardNum;
	
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
			console.log("글보기 들어왔어요");
			$("#groupReplyBoard").html(data);
		}
		,error:function(e) {
			console.log(" 오류남");
			console.log(e.responseText);
		}
		
	});
}


//리스트 찾기
function searchReplyList() {
	var url="<%=cp%>/group/reply/list";

	var searchKeyC=$('#searchKeyC').val();
	var searchValueC=$('#searchValueC').val();
	var groupName="${groupName}";

	$.post(url, {searchKeyC:searchKeyC, searchValueC:searchValueC, groupName:groupName}, function(data) {
		$("#groupReplyBoard").html(data);
		$("#searchValueC").val("");	
	});
}

function deleteReplyBoard(replyBoardNum) {
	if(!confirm("위 자료를 삭제 하시겠습니까 ?"))
		return;
	
	var url="<%=cp%>/group/reply/delete";
	var query="replyBoardNum="+replyBoardNum;

	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
		
			var state=data.state;
			if(state=="false")
				console.log("게시물을 삭제 할 수 없습니다. !!!");
				  replyBoardList(pageNo);
		 }
		 ,error:function(e) {
			 console.log(e.responseText);
		}
	});
}




</script>


<body>
  <div id="groupReplyBoard"></div>
</body>
	