<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
	
%>

<style>
.bigdiv {
	width: 890px;
	min-height: 150px;
	margin: 0 auto;
	margin-bottom: 10px;
	padding: 5px;
	float: left;
	font-family: 나눔고딕, "맑은 고딕";
	/* 	border: 1px solid #5D5D5D; */
}

.middlediv {
	width: 625px;
	float: left;
	text-align: left;
	vertical-align: middle;
	display: table-cell;
	font-family: 나눔고딕, "맑은 고딕";
	overflow: hidden;
	position: relative;
	max-height: 130px;
}

#smalldiv {
	position: relative;
	min-height: 130px;
	padding: 20px;
	width: 250px;
	float: left;
	font-size: 20px;
	
}

.smalldiv ul {
	list-style: none;
	font-family: 나눔고딕, "맑은 고딕";
}

.overlay {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	height: 100%;
	width: 100%;
	opacity: 0;
	transition: .5s ease;
	background-color: white;
}

.smalldiv:hover .overlay {
	opacity: 1;
}

.overtext {
	color: black;
	font-size: 20px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
}

#gradient {
	width: 620px;
	height: 35px;
	position: absolute;
	bottom: 0;
	left: 0;
}

.read-more {
	text-align: right;
	width: 625px;
	min-height: 25px;
	display: block;
}
.readbtn:hover {
	color: #000;
}

</style>

<c:forEach var="dto" items="${noticeList }">
	<div class="bigdiv">
		<div class="smalldiv" id="smalldiv">
			${dto.subject }
			<div class="overlay">
				<div class="overtext">${dto.created }<br>
					<c:if test="${userId==sessionScope.member.userId}">
						<button type="button" class="btn btn-default" id="kmUpdatebtn" 
							onclick="updateNoG(${dto.num}, ${page });">
							<span class="glyphicon glyphicon-refresh"></span>
						</button>
					
						<button type="button" class="btn btn-default" id="kmDeleteBtn"
							onclick="deleteNoG(${dto.num},${page },${dto.fileNum });">
							<span class="glyphicon glyphicon-trash"></span>
						</button>
					</c:if>
				</div>
			</div>
		</div>
		<div id="smsmdiv">
			<div class="middlediv" id="middlediv${dto.num}" data-num="${dto.num}">
				<div id="read-more" class="read-more">
					<c:if test="${dto.content.length() > 180 || dto.content.indexOf('<br>')>=5 }">
						<button type="button" class="btn btn-default-sm btn-xs" id="readbtn${dto.num }"
							onclick="noticelayoutview(${dto.num});" >
							<span class="glyphicon glyphicon-resize-full"></span>
						</button>
					</c:if>
					<c:if test="${dto.fileCount > 0}">
						<a href="<%=cp%>/group/notice/download?num=${dto.num}">
							<button type="button" class="btn btn-default-sm btn-xs" 
										data-toggle="tooltip" data-placement="right" title="${dto.originalFilename } (<fmt:formatNumber value="${dto.fileSize/1024 }" pattern="0.00"/>KB)" id="fileNotice">							
									<span class="glyphicon glyphicon-save"></span>					
							</button>	
						</a>
					</c:if>			
				</div>
				${dto.content }
				
				<div id="gradient"></div>
			</div>

		</div>
	</div>
</c:forEach>


<div style="clear: both;">
	<div class="paging"
		style="text-align: center; min-height: 50px; line-height: 50px;">
		<c:if test="${dataCount==0 }">등록된 게시물이 없습니다.</c:if>
		<c:if test="${dataCount!=0 }">${paging}</c:if>
	</div>

			<div style="float: left; width: 20%; min-width: 85px;">
		<button type="button" class="btn btn-default btn wbtn">
			<span class="glyphicon glyphicon-repeat"></span>
			<!-- 새로고침  -->
		</button>
	</div>
	<div style="float: left; width: 60%; text-align: center;">
		<form name="searchForm" method="post" class="form-inline">
			<select class="form-control input-sm" name="searchKey" id="gnsearchKeykm">
				<option value="subject">제목</option>
				<option value="content">내용</option>
				<option value="created">등록일</option>
			</select> <input type="text" class="form-control input-sm input-search"
				name="searchValue" id="gnsearchValuekm">
			<button type="button" class="btn btn-default btn btn-search"
				onclick="gnSearchList();">
				<span class="glyphicon glyphicon-search"></span>
			</button>
		</form>
	</div>
	<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
		<c:if test="${userId==sessionScope.member.userId}">
			
			<button type="button" class="btn btn-default btn wbtn" id="btnpen"
				data-toggle="modal" data-target="#kmNoticeModal" >				
				<span class="glyphicon glyphicon glyphicon-pencil"></span>
			</button>
		</c:if>
	</div>
</div>

<div class="modal fade" id="myModalUpdateNotice" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel" style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">수정</h4>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">       
		<button type="button" onclick="groupNoticeUpdateOk(${page});" data-dismiss="modal">수정</button>
		<button type="button" data-dismiss="modal">취소</button>			                 
	  </div>
    </div>
  </div>
</div>
</body>
