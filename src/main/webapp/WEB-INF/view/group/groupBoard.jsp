<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
	String groupName = request.getParameter("groupName");
	String userId = request.getParameter("userId");
%>
<style>
.gbbestbig {
	margin: 0 auto;
	width: 900px;
	/* 	height: 680px; */
}
</style>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	gboardlistPage(1);
});

function gboardlistPage(page) {
	var groupName = "<%=groupName%>";
	var url="<%=cp%>/group/groupBoardList";
	$.get(url, {page:page,}, function(data){
		$("#gblistlayout").html(data);
	});
}


</script>

<div class="gbbestbig">
		<table class="table table-hover">
			<thead>
				<tr>
					<th style="width: 70px;">번호</th>
					<th>제목</th>
					<th class="text-center" style="width: 100px;">작성자</th>
					<th class="text-center" style="width: 100px;">등록일</th>
					<th class="text-center" style="width: 70px;">조회수</th>
				</tr>
			</thead>
		</table>
		<div id="gblistlayout"></div>
		
</div>





<div class="modal fade" id="myModalGboard" role="dialog">
		<!-- 모달 Div 이걸 따로 빼야하는지 그냥 둬도 되는건지 내일 물어보기!  -->
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">
						<span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;
						게시물을 작성합니다.
					</h4>
				</div>
				<div class="modal-body">
					<input type="text" name="subject" class="form-control input"
						placeholder="제목을 입력해주세요." required="required"><br>
					<textarea name="content" class="form-control" rows="15"
						required="required"></textarea>
					<br> <input type="file" name="upload"
						class="form-control input"><br> <input type="text"
						name="subject" class="form-control input" placeholder="태그를 입력해주세요.">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<span class="glyphicon glyphicon-ok"></span>
					</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
				</div>
			</div>
		</div>
	</div>
