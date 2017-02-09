<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style type="text/css">
div.top_box {
	position: relative;
	width: 100%;
	border: 5px solid #dedede;
	margin: 20px 0;
}

ul, menu, dir {
	display: block;
	list-style-type: disc;
	-webkit-margin-before: 1em;
	-webkit-margin-after: 1em;
	-webkit-margin-start: 0px;
	-webkit-margin-end: 0px;
	-webkit-padding-start: 40px;
}
.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover {
    color: #555;
    cursor: default;
    background-color: #ffffff;
    border: 5px solid #777;
    border-bottom-color: transparent;
}
.nav-tabs {
    border-bottom: 1px solid rgba(58, 42, 42, 0.54);
}
</style>
<script type="text/javascript">
 var category="${category}";
var searchValue="${searchValue}";

$(function(){
	var page="${pageNo}";
	if(page=="") page="0";
	
	$('a[data-toggle="tab"]').each(function(){
		var c=$(this).attr("aria-controls");
		
		if(category==c) {
			$(this).parent().addClass("active");
			$("#tabContent"+c).addClass("active");
		} else {
			$(this).parent().removeClass("active");
		}
	});

	listPage(page);
});

// 탭을 선택 한 경우
$(function(){
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		category=$(this).attr("aria-controls");
		searchValue="";
		$("#searchValue").val("");
		
		$("[id^=tabContent]").each(function(){
			$(this).html(""); // 전체를 출력하는 부분과 카테고리별 출력하는부분의 id가 같으므로 기존 정보 지움
		});
		
		listPage(1);
	});	
});

function listPage(page) {
    url="<%=cp%>/tfaq/list";

	var query="pageNo="+page+"&category="+category+"&searchValue="+searchValue;
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,success:function(data) {
			var id="#tabContent"+category;
			$(id).html(data);
		}
	    ,error:function(e) {
	    	alert(e.responseText);
	    }
	});

}

function searchList() {
	searchValue=$("#searchValue").val();
	listPage(1);
} 
</script>

<div class="bodyFrame2" style="margin: 0 auto; margin-top: 80px">
	<div class="body-title">
		<h3>
			<span class="glyphicon glyphicon-search"></span> 자주하는 질문
		</h3>
	</div>

	
	<div class="top_box">
		<ul>
			<li><b>고객센터 : FAQ 게시판</b>입니다.</li>
			<li>자주하는 질문내용들을 정리하였습니다. 원하시는 질문을 클릭하시면 답변내용을 볼 수 있습니다.</li>
			<li>FAQ에서 원하는 답변을 찾지 못하였다면 1:1상담신청에서 문의하시기 바랍니다.</li>
			<li>답변가능 시간은 오전9시부터 오후7이며, 토/일요일 및 공휴일은 휴무 입니다.</li>
		</ul>
	</div>


	<div class="top_box" >

		<form name="searchForm" method="post" class="form-inline" style="padding: 20px 20px 20px 20px ">
		<div class="form-group form-group-lg" align="center">
            <label >궁금하신 사항을 손쉽게 찾아보세요.</label>
            <div class="input-group col-xs-6" style="clear: both; margin-left: 30px;" >
					
					
					
					<input type="text" name="searchValue" id="searchValue"
					class="form-control input-sm input-search"  style="height: 28px; margin-right: 10px" > 
			
				<span class="input-group-btn">
					<button type="button" class="btn btn-info btn-sm btn-search"
						onclick="searchList();">
						<i class="glyphicon glyphicon-search"></i> 검색
					</button>
				</span>
					
			</div>
         </div>
			
			
		</form>

	</div>
   
	    
	    
	<div>
		<div role="tabpanel" >
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#tabContent0"
					aria-controls="0" role="tab" data-toggle="tab">전체</a></li>
				<c:forEach var="dto" items="${listFaqCategory}">
					<li role="presentation"><a
						href="#tabContent${dto.categoryNum}"
						aria-controls="${dto.categoryNum}" role="tab" data-toggle="tab">${dto.classify}</a></li>
				</c:forEach>
			</ul>

			<div class="tab-content" style="padding: 5px; margin-top: 15px;">
				<div role="tabpanel" class="tab-pane active" id="tabContent0"></div>
				<c:forEach var="dto" items="${listFaqCategory}">
					<div role="tabpanel" class="tab-pane"
						id="tabContent${dto.categoryNum}"></div>
				</c:forEach>
			</div>
		</div>

		<div style="clear: both; margin-top: 20px;">
			<div style="float: left; width: 20%; min-width: 85px;">&nbsp;</div>
			<div style="float: left; width: 60%; text-align: center;">
			
			</div>
			<div
				style="float: right; width: 20%; min-width: 85px; text-align: right;">
				<c:if test="${sessionScope.member.userId=='admin'}">
					<button type="button" class="btn btn-default btn-sm wbtn"
						onclick="javascript:location.href='<%=cp%>/tfaq/created';">
						<span class="glyphicon glyphicon glyphicon-pencil"></span> 등록하기
					</button>
				</c:if>
			</div>
		</div>
	</div>

</div>