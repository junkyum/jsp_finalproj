<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
function modalCheck() {
	var f = document.gNotice;
	
	
	var mode="${mode}"
	if(mode=="created")
		f.action = "<%=cp%>/notice/created";
	f.submit();
	return true;
	
}
</script>
<style>
.bestbig {
	width: 900px;
	height: 680px;
	/* border: 1px solid #5D5D5D; */
}

.bigdiv {
	width: 890px;
	height: 150px;
	margin: 0 auto;
	margin-bottom: 10px;
	padding: 5px;
	float: left;
	font-family: 나눔고딕, "맑은 고딕";
	/* border: 1px solid #5D5D5D; */
}

.middlediv {
	width: 500px;
	height: 100px;
	padding: 20px;
	float: left;
	text-align: left;
	vertical-align: middle;
	display: table-cell;
	font-family: 나눔고딕, "맑은 고딕";
	/* border: 1px solid #5D5D5D; */
}

.smalldiv {
	position: relative;
	height: 100px;
	padding: 20px;
	width: 250px;
	float: left;
	font-size: 20px;
	/* border: 1px solid #5D5D5D; */
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
</style>
</head>
<body>
	<div class="bestbig">

		<div style="clear: both; height: 50px; line-height: 30px;">
			
		</div>

 		<c:forEach var = "dto" items="${noticeList }">
			<div class="bigdiv">
				<div class="smalldiv">
					${dto.subject }
					<div class="overlay">
						<div class="overtext">${dto.created }</div>
					</div>
				</div>
				<div class="middlediv">
					${dto.content }
				</div>
			</div>
		</c:forEach>
		
		<div style="clear: both;">
		<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
            <c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
        </div>     
		
        		<div style="float: left; width: 20%; min-width: 85px;">
				<button type="button" class="btn btn-default btn wbtn">
					<span class="glyphicon glyphicon-repeat"></span><!-- 새로고침  -->
				</button>
			</div>
        		<div style="float: left; width: 60%; text-align: center;">
        		     <form name="searchForm" method="post" class="form-inline">
						  <select class="form-control input-sm" name="searchKey" >
						      <option value="subject">제목</option>
						      <option value="content">내용</option>
						      <option value="created">등록일</option>
						  </select>
						  <input type="text" class="form-control input-sm input-search" name="searchValue">
						  <button type="button" class="btn btn-default btn btn-search" onclick="searchList();"><span class="glyphicon glyphicon-search"></span></button>
        		     </form>
        		</div>
        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
				<button type="button" class="btn btn-default btn wbtn" id="btnpen"  
					data-toggle="modal" data-target="#kmModal">
					<span class="glyphicon glyphicon glyphicon-pencil"></span>
					
				</button>

			</div>
        </div>
		
	</div>
	
	
<div class="modal fade" id="kmModal" role="dialog">
	<form name="gNotice" action="<%=cp%>/notice/created" method="POST"></form>
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">
						<span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;
						공지사항을 작성합니다.
					</h4>
				</div>
				<div class="modal-body">
					<input type="text" name="subject" id="kmsubject" value="${dto.subject }" class="form-control input"
						placeholder="제목을 입력해주세요." required="required"><br>
					<textarea name="content" id="content" class="form-control" rows="15"
						required="required"></textarea>
					<br> <input type="file" name="upload" id="file"	class="form-control input"><br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" onclick="modalCheck();">
						<span class="glyphicon glyphicon-ok"></span>
					</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">
						<span class="glyphicon glyphicon-remove"></span>
					</button>
				</div>
			</div>
		</div>
	</div>	
</body>

