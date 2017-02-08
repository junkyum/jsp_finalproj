<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();

%>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".replyBtn1").click(function() {
	      $("#replyBtn2").dialog({
	         title:"등록하기",
	         modal:true,
	         width:400,
	         height:400
	          
	      });
	   });
});
//submitReply 
function backReply() {
	$("#replyBtn2").dialog("close");
	/* listPage(1); */
	$("#groupName").val("");
	$("#chSubject").val("");
	$("#chContent").val("");

}

function submitReply() {
	$("#span3").hide();
	$("#span4").hide();
	
	if(!$("#chSubject").val()){
		$("#chSubject").focus();
		$("#span3").show();
		return;
	}
	
	if(!$("#chContent").val()){
		$("#chContent").focus();
		$("#span4").show();
		return;
	}
	
}



</script>



<div style="margin:0px; padding:0px; width: 1150px; height: 600px;  border: 1px solid red;">
		<table class="table table-hover" style="margin: 0px; padding: 0px;">
			<thead>
				<tr style="margin: auto;">
					<th class="text-center" style="width: 100px;">번호</th>
					<th class="text-center" style="width: 100px;">제목</th>
					<th class="text-center" style="width: 100px;">작성자</th>
					<th class="text-center" style="width: 100px;">등록일</th>
					<th class="text-center" style="width: 70px;">조회수</th>
				</tr>
			</thead>
		</table>
		<div id="replyBoard"></div>
		
		
		<div style="clear: both; margin-top: 0px; height: 30px;">
					<div style="float: left; min-width: 85px; text-align: right;">
						<div class="replyBtn1"><!-- 버튼이 들어가있는  div -->
							<button type="button"><div>답변형 등록하기</div></button>
						</div>
					</div>
			</div>
	
</div>


		<div class="replyBtn2" id="replyBtn2" style="display: none; padding:0px; margin: 0px; width: 350px; height: 350px;">
		    <form method="post" name="replyForm" id="replyForm">
				<div style="height: 400px; width: 400px; border: 1px solid black;">
					<h3 style="margin-top: 10px; margin-left: 150px;">그룹 명 :??????</h3>
					 <%-- <input type="hidden" name="groupName" value="${groupName}"> --%>
						<input type="text" name="groupName">
						<div style="margin-top: 10px;">
							<h4 style="float: left; margin: 0px;">재 목 :&nbsp;</h4>
							<input type="text" name="chSubject" id="reSubject" value="" placeholder="내용을 입력하세요" style="clear: both;">
							<span id="span3" style="display: none;">내용좀 입력하세요</span>
						</div>
						
						<div>
							<h4>내 용 : <span style="display: none;" id="span4">내용좀 입력하세요</span></h4> 
							<textarea rows="5" name="chContent" id="chContent" required="required" style="width: 300px; height: 100px;"></textarea>
						</div>		
				<div style="margin-left: 100px; margin-top: 20px; float: left; " >
					<button type="button" id="btnOk" name="btnOk" onclick="submitReply();" >등록하기</button>
					
					<button type="button" onclick="backReply();">취소</button>
				</div>
				</div>
		    </form>	
		</div>

	