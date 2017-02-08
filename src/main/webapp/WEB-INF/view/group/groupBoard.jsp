<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
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
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page) {	
	var url="<%=cp%>/group/groupBoardList";
	var boardNum = "${dto.boardNum}";
	var groupName = "${groupName}";
	var userId = "${userId}";
	$.get(url, {boardNum:boardNum, page:page, groupName:groupName, userId:userId}, function(data){
		$("#gblistlayout").html(data);
	});
}

function mkmgroupBoardCheck(){
	var page = "${page}";
	var url = "<%=cp%>/group/gboard/created";
	var subject = $("#gbsubjectkm").val().trim();
	var content = $("#gbcontentkm").val().trim();
	var keyword = $("#gbkeywordkm").val();
	var groupName= "${groupName}";
	if(!subject){
		$("#gbsubjectkm").focus();
		return;
	}
	
	var groupBodF = document.gBoard;
	var gbformData = new FormData(groupBodF);
		$.ajax({
			type:"post",
			url :url,
			processData: false,
			contentType: false,
			data : gbformData,
			dataType:"json",
			success:function(data){
				var result = data.result;
				if(data.result=="true"){
					$("#gbsubjectkm").val("");
					$("#gbcontentkm").val("");
					$("#gbfilekm").val("");
					$("#gbkeywordkm").val("");				
					listPage(1);					
				}else {
					alert("추가 안됌 여기 어떻ㄱㅔ 바꿀지 생각해 보기! ");
				}
				
			},error:function(e) {
		    	  console.log(e.responseText);
		      }
		
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
	<form name="gBoard" method="POST" enctype="multipart/form-data">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">
						<span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;
						게시물을 작성합니다.
					</h4>
				</div>
				<div class="modal-body">
					<input type="text" name="subject" id="gbsubjectkm" class="form-control input"
						placeholder="제목을 입력해주세요." required="required"><br>
					<textarea name="content" id="gbcontentkm" class="form-control" rows="15"
						required="required"></textarea>
					<br> <input type="file" name="upload" id="gbfilekm"
						class="form-control input"><br> 
					<input type="text" name="keywork" id="gbkeyworkkm" class="form-control input" placeholder="태그를 입력해주세요.">
					<input type="hidden" name="groupName" value="${groupName }">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
							id="kmgroupBoardCheck" onclick="mkmgroupBoardCheck();">
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
