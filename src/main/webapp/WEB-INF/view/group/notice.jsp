<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
.bestbig {
	margin:0 auto;
	width: 900px;
/* 	height: 680px; */
	/* border: 1px solid #5D5D5D; */
}

.bigdiv {
	width: 890px;
	min-height: 150px;
	margin: 0 auto;
	margin-bottom: 10px;
	padding: 5px;
	float: left;
	font-family: 나눔고딕, "맑은 고딕";
	border: 1px solid #5D5D5D;
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
/* 	border: 1px solid #5D5D5D; */
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
	width:620px; 
	height:35px; 
	background:url(bg-gradient.png) repeat-x; 
	position:absolute; 
	bottom:0; 
	left:0;	
}

.read-more {
	text-align: right;
	width: 625px;
	min-height: 25px;
}

.readbtn{ 
	padding-right:22px; 
	background:url(icon-arrow.gif) no-repeat 100% 50%;
}
.readbtn:hover {color:#000;}

</style>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#kmmodalCheck").click(function(){
		var subject = $("#kmsubject").val().trim();
		var content = $("#kmcontent").val().trim();
		if(subject !=null && content !=null){
			var f = document.gNotice;	
				f.action = "<%=cp%>/notice/created";			
			 f.submit();
		}
	});	
});


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


<%-- function updateNoG(num){
	
	var f = document.gNotice;
	var page = "${page}";

	f.action = "<%=cp%>/notice/update?num="+num+"&page="+page;
	f.submit();
}
 --%>

	

	
function deleteNoG(num){
		var page = "${page}";
	    var params = "num="+num+"&page="+page;
	    var url = "<%=cp%>/notice/delete?" + params;
	    
	    if(confirm("공지사항을 삭제 하시 겠습니까 ? "))
	    	location.href=url;
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

		<div style="clear: both; height: 50px; line-height: 30px;">
			
		</div>

 		<c:forEach var = "dto" items="${noticeList }">
			<div class="bigdiv" >
				<div class="smalldiv" id="smalldiv">
					${dto.subject }
					<div class="overlay">
						<div class="overtext">${dto.created }<br>
						<button type="button" class="btn btn-default" id="kmUpdatebtn" onclick="updateNoG(${dto.num});" data-num="${dto.num }" data-toggle="modal" data-target="#kmModal"><span class="glyphicon glyphicon-refresh"></span></button>
						<button type="button" class="btn btn-default" id="kmDeleteBtn" onclick="deleteNoG(${dto.num});"><span class="glyphicon glyphicon-trash"></span></button>
						</div>
					</div>
				</div>
				<div id="smsmdiv">
					<div class="middlediv" id="middlediv${dto.num}" data-num="${dto.num}">
					<div id="read-more" class="read-more">
						<%-- <c:if test="${}"> --%>
							<input type="button" class="readbtn" id="readbtn${dto.num }"onclick="layoutview(${dto.num});"  >
						<%-- </c:if> --%>
					</div>
						${dto.content }
						<div id="gradient" ></div>
					</div>
					
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
					data-toggle="modal" data-target="#kmModal" data-mode="created">
					<span class="glyphicon glyphicon glyphicon-pencil"></span>
					
				</button>

			</div>
        </div>
		
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
					<input type="text" name="subject" id="kmsubject"  class="form-control input"
						placeholder="제목을 입력해주세요." required="required"><br>
					<textarea name="content" id="kmcontent" class="form-control" rows="15"
						required="required"></textarea>
					<br> <input type="file" name="upload" id="file"	class="form-control input"><br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" id="kmmodalCheck">
						<span class="glyphicon glyphicon-ok" ></span>
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

