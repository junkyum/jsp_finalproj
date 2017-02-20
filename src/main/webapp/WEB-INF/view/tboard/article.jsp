<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
//11
%>

<style type="text/css">
.bbs-article .table {
	margin-top: 15px;
}

.bbs-article .table thead tr, .bbs-article .table tbody tr {
	height: 30px;
}

.bbs-article .table thead tr th, .bbs-article .table tbody tr td {
	font-weight: normal;
	border-top: none;
	border-bottom: none;
}

.bbs-article .table thead tr {
	border-top: #d5d5d5 solid 1px;
	border-bottom: #dfdfdf solid 1px;
}

.bbs-article .table tbody tr {
	border-bottom: #dfdfdf solid 1px;
}

.bbs-article .table i {
	background: #424951;
	display: inline-block;
	margin: 0 7px 0 7px;
	position: relative;
	top: 2px;
	width: 1px;
	height: 13px;
}
</style>

<script type="text/javascript">
function deleteTBoard() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
  var num = "${dto.num}";
  var page = "${page}";
  var params = "num="+num+"&page="+page;
  var url = "<%=cp%>/tboard/delete?" + params;

  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateTBoard() {
<c:if test="${sessionScope.member.userId==dto.userId}">
  var num = "${dto.num}";
  var page = "${page}";
  var params = "num="+num+"&page="+page;
  var url = "<%=cp%>/tboard/update?" + params;

  location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!=dto.userId}">
 alert("게시물을 수정할 수  없습니다.");
</c:if>
}

//-------------------------------------
//댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/tboard/listReply";
	var num="${dto.num}";
	$.post(url, {num:num, pageNo:page}, function(data){
		$("#listReply").html(data);
	});
}

function login() {
	location.href="<%=cp%>/member/login";
}

//댓글 추가
function sendReply() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var num="${dto.num}"; // 해당 게시물 번호
	var content=$.trim($("#content").val());
	if(! content ) {
		alert("내용을 입력하세요 !!! ");
		$("#content").focus();
		return false;
	}
	
	var query="num="+num;
	query+="&content="+content;
	query+="&answer=0";
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/tboard/createdReply"
		,data:query
		,dataType:"json"
		,success:function(data) {
			$("#content").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 등록하지 못했습니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}



// 게시글 좋아요/싫어요 추가
function tbbLike(num, tbbLikeN) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(tbbLikeN==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	
	var params="num="+num;
	params+="&tBoardLike="+tbbLikeN;

	$.ajax({
		type:"POST"
		,url:"<%=cp%>/tboard/tBoardLike"
		,data:params
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="true") {
				tcountLike(num);
			} else if(state=="false") {
				alert("좋아요/싫어요는 한번만 가능합니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

function tcountLike(num) {
	var url="<%=cp%>/tboard/tcountLike";
	$.post(url, {num:num}, function(data){
		var tlikeCountId="#tlikeCount"+num;
		var tlikeCount=data.tlikeCount;
		
		$(tlikeCountId).html(tlikeCount);
	}, "JSON");
}

////////////////////////////////////////////////////////////
//리플
//좋아요/싫어요 개수
function countLike(repleNum) {
	var url="<%=cp%>/tboard/countLike";
	$.post(url, {repleNum:repleNum}, function(data){
		var likeCountId="#likeCount"+repleNum;
		var disLikeCountId="#disLikeCount"+repleNum;
		var likeCount=data.likeCount;
		var disLikeCount=data.disLikeCount;
		
		$(likeCountId).html(likeCount);
		$(disLikeCountId).html(disLikeCount);
	}, "JSON");
}

//좋아요/싫어요 추가
function sendLike(repleNum, repleLike) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(repleLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	
	var params="repleNum="+repleNum;
	params+="&repleLike="+repleLike;

	$.ajax({
		type:"POST"
		,url:"<%=cp%>/tboard/repleLike"
		,data:params
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="true") {
				countLike(repleNum);
			} else if(state=="false") {
				alert("좋아요/싫어요는 한번만 가능합니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

//댓글 삭제
function deleteReply(repleNum, page) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/tboard/deleteReply";
		$.post(url, {repleNum:repleNum, mode:"reply"}, function(data){
		        var state=data.state;

				if(state=="loginFail") {
					login();
				} else {
					listPage(page);
				}
		}, "json");
	}
}

</script>

<div class="mk_bodyFrame2"
	style="margin: 0 auto; width: 1000px; padding-top: 10px;">
	<div class="mk_body-title">
		<h3>일반 게시판</h3>
	</div>
	<div class="table-responsive" style="clear: both;">
		<div class="bbs-article">
			<table class="table" border="1">
				<thead>
					<tr>
						<th colspan="2" style="text-align: center;">${dto.subject}</th>
					</tr>
				<thead>
				<tbody>
					<tr>
						<td style="text-align: left;">이름 : ${dto.userName}</td>
						<td style="text-align: right;">${dto.created}<i></i>좋아요 ${dto.tlikeCount}<i></i>조회
							${dto.hitCount}
						</td>
					</tr>
					<tr>
						<td colspan="2" style="height: 230px;">${dto.content}</td>
					</tr>

					<c:forEach var="vo" items="${listFile}">
						<tr>
							<td colspan="2">
								<span style="display: inline-block; min-width: 45px;">첨부</span> : 
								<a href="<%=cp%>/tboard/download?fileNum=${vo.fileNum}">
									<span class="glyphicon glyphicon-download-alt"></span>
									${vo.originalFilename}
								</a> (
								<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00" /> KByte)
							</td>
						</tr>
					</c:forEach>

					<tr>
						<td colspan="2">
							<div class="bbs-reply">
								<div class="bbs-reply-write">
									<div style="clear: both;">
										<div style="float: left;">
											<span style="font-weight: bold;">댓글쓰기</span>
										</div>
										<div style="float: right; text-align: right;"></div>
									</div>
									<div style="clear: both; padding-top: 10px;">
										<textarea id="content" class="form-control" rows="3"
											placeholder="인터넷은 우리가 함께 만들어가는 소중한 공간입니다.  댓글 작성 시 타인에 대한 배려와 책임을 담아주세요."></textarea>
									</div>
									<div style="text-align: right; padding-top: 10px;">
										<button type="button" class="btn btn-default btn-sm wbtn"
											onclick="sendReply();">
											댓글등록 <span class="glyphicon glyphicon-ok"></span>
										</button>
									</div>
								</div>

								<div id="listReply"></div>
							</div>
						</td>
					</tr>

					<tr>
						<td colspan="2">
							<span style="display: inline-block; min-width: 45px;">이전글</span> : 
							<c:if test="${not empty preReadDto }">
								<a href="<%=cp%>/tboard/article?${params}&num=${preReadDto.num}">${preReadDto.subject}</a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
							<span style="display: inline-block; min-width: 45px;">다음글</span> : 
							<c:if test="${not empty nextReadDto }">
								<a href="<%=cp%>/tboard/article?${params}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
							</c:if>
						</td>
					</tr>
				</tbody>
		
				
				<tfoot>
					<tr>
						<td>
							<c:if test="${sessionScope.member.userId!=dto.userId}">
								<button type="button" class="btn btn-default btn-sm wbtn" onclick="tbbLike('${dto.num}', '1')">좋아요</button>
							</c:if>
							<c:if test="${sessionScope.member.userId==dto.userId}">
								<button type="button" class="btn btn-default btn-sm wbtn" onclick="updateTBoard();">수정</button>
							</c:if> 
							<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
								<button type="button" class="btn btn-default btn-sm wbtn" onclick="deleteTBoard();">삭제</button>
							</c:if>
						</td>
						<td align="right">
							<button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tboard/list?${params}';">
								목록으로</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>

	</div>

</div>