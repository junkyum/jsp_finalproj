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

//글을 등록할것이다.  submitReply
function submitReply() {
	var groupName="${groupName}"
	 var url="<%=cp%>/group/reply/created";
	 $.get(url,{groupName:groupName},function(data){
		 $("#groupReplyBoard").html(data);
	 });
	 
}

function articleReplyBoard(replyBoardNum) {
	alert("눌렷음    |"+replyBoardNum);
	var url="<%=cp%>/group/reply/article";
	var query="pageNo="+pageNo+"&searchKeyC="+searchKeyC+"&searchValueC="+searchValueC;
	query+="&replyBoardNum="+replyBoardNum;
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
				alert(" 들어갓");
			$("#groupReplyBoard").html(data);
		}
		,error:function(e) {
			alert(" 오류남");
			console.log(e.responseText);
		}
		
	});
	
}


</script>


<body>
  <div id="groupReplyBoard"></div>
</body>
	