<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
.bestbig {
	margin: 0 auto;
	width: 900px;
	/* 	height: 680px; */
	/* 	border: 1px solid #5D5D5D; */
}
</style>
<link rel="stylesheet"
	href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css"
	type="text/css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/group/noticeList";
	var num="${dto.num}";
	$.get(url, {num:num, pageNo:page}, function(data){
		$("#listlayout").html(data);
	});
}

function mkmmodalCheck(){
	var page = "${page}";
	var url = "<%=cp%>/group/notice/created";
	var subject = $("#kmsubject").val().trim();
	var content = $("#kmcontent").val().trim();
	if(!subject){
		$("#kmsubject").focus();
		return;
	}
	
	var query ="subject="+subject+"&content="+content;
	
		$.ajax({
			type:"post",
			url :url,
			data : query,
			dataType:"json",
			success:function(data){
				var result = data.result;
				if(data.result=="true"){
					listPage(1);					
				}else {
					alert("추가 안됌 여기 어떻ㄱㅔ 바꿀지 생각해 보기! ");
				}
				
			},error:function(e) {
		    	  console.log(e.responseText);
		      }
		
	});	
}

function updateNoG(num) {	
	var page = "${page}";
	var query = "num="+num+"&page="+page;
	var url = "<%=cp%>/notice/update";
	
	$.ajax({
		type:"post",
		url :url,
		data: query,
		dataType:"json",
		success:function(data){
			$("#kmsubject").val("나는");
			$("#kmcontent").val("경미");
		},error:function(e) {
	    	  console.log(e.responseText);
	      }
	});
}

	
function deleteNoG(num,page){	
	if(confirm("공지사항을 삭제 하시겠습니까 ? ")){
		var url ="<%=cp%>/group/notice/delete";
		$.post(url, {num:num}, function(data){
			var state = data.state;
			if(state =="loginFail"){
				alert("로그인화면으로 돌아가는 메소드 ");
			}else {
				listPage(page);
			}
		}, "json");
	}
}



/* function layoutview(num) {
	var s=$("#middlediv"+num);
	s.css("max-height", "900px");
} */ 

function layoutview(num) {
	var s=$("#middlediv"+num);
	var aa = 130;
	var ma = 900;
		if(s.height()==aa){
			s.animate({"max-height" : ma});
			$("#gradient").fadeOut();
			/* s.css("max-height", "900px");	 */		
		}else {
			s.animate({"max-height" : aa});
			$("#gradient").fadeIn();
/* 			s.css("max-height", "130px"); */
		}
}



</script>

</head>
<body>
	<div class="bestbig">

		<div style="clear: both; height: 50px; line-height: 30px;"></div>

		<div id="listlayout"></div>
	</div>



	<div class="modal fade" id="kmModal" role="dialog">
		<form name="gNotice" method="POST" enctype="multipart/form-data">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">
							<span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;
							공지사항을 작성합니다.
						</h4>
					</div>
					<div class="modal-body">
						<input type="text" name="subject" id="kmsubject"
							class="form-control input" placeholder="제목을 입력해주세요."
							required="required"><br>
						<textarea name="content" id="kmcontent" class="form-control"
							rows="15" required="required"></textarea>
						<br> <input type="file" name="upload" id="file"
							class="form-control input"><br>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							id="kmmodalCheck" onclick="mkmmodalCheck();">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>

