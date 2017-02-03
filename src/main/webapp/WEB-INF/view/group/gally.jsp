<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<!-- groupGally/gally   이게 맨처음 겔러리 페이지 -->
<style type="text/css">
.imgLayout{
	width: 200px;
	height: 230px;
	padding: 5px 5px 5px;
	margin: 5px;
	border: 1px solid #DAD9FF;
	float: left;
	margin-right: 120px;

}

.subject {
     width:190px;
     height:25px;
     line-height:25px;
     margin:5px auto 0px;
     border-top: 1px solid #DAD9FF;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
     text-align: center;
}

a:hover {
   text-decoration: none;
}
h4{
    margin: 0px; 
   margin-top: 5px;
}
</style>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.form.js"></script>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
//사진삭제하는곳
function deletePhoto(gallyNum) {
	
	var url="<%=cp%>/group/photo/delete";	
	var query="gallyNum="+gallyNum;
	alert(query);

	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {

			var state=data.state;
	
			if(state=="false") {
				$('#myModal').modal('hide');
				listPage(1);
			} else{
				listPage(1);
			}			
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}
//수정@글보기  숨기고 보이고 하는거.
function updatePhoto(){
		document.getElementById("kim_article").style.display="none";
		document.getElementById("kim_update").style.display="block";	
}
///수정 하는곳
function updateOK() {
	
  var f=document.dialogForm;
  var formData = new FormData(f);
  
	  $.ajax({
			 type:"post"
			 ,url:"<%=cp%>/group/photo/update"
			 ,processData: false  // file 전송시 필수
	         ,contentType: false  // file 전송시 필수
	         ,data: formData
			 ,dataType:"json"
			 ,success:function(data) {
				var state=data.state;
				if(state=="false")
					alert("작업 실패 !!!");		 
				$('#myModal').modal('hide');
				listPage(1);//이거 안먹힌다...씨빨.
				 
				$("#groupName").val("");
				$("#subject").val("");
				$("#content").val("");
				$("#imageFilename").val("");			
	
			}
			,error:function(e) {
				console.log(e.responseText);
			}
			
		});
   
}

$(function(){
	listPage(1);
});
/* 이게 listGally.jsp를 출력하게 해주는 곳 */
function listPage(page) {
	var url="<%=cp%>/groupGally/list";

	$.get(url,{pageNo:page}, function(data) {
		$("#listlayout").html(data);
		 //$("#chk2").dialog("close");
	});
}

$(function(){
	$(".chk1").click(function() {
	      $("#chk2").dialog({
	         title:"등록하기",
	         modal:true,
	         width:500,
	         height:500
	          
	      });
	   });
});
//사진등록 
function send(){
	
	$("#span1").hide();
	$("#span2").hide();
	if(!$("#subject").val()){
		$("#subject").focus();
		$("#span1").show();
		return;
	}
	
	if(!$("#content").val()){
		$("#content").focus();
		$("#span2").show();
		return;
	}
	
	var f = document.photoForm;
	if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
		alert('이미지 파일만 가능합니다. !!!');
		f.upload.focus();
		return false;
	}
	
	//var f=$("form")[0];
    var f=document.photoForm;
    var formData = new FormData(f);
	alert(formData+"dd");
	  $.ajax({
			 type:"post"
			 ,url:"<%=cp%>/group/photo/created"
			 ,processData: false  // file 전송시 필수
	         ,contentType: false  // file 전송시 필수
	         ,data: formData
			 ,dataType:"json"
			 ,success:function(data) {
				var state=data.state;
				if(state=="false")
					alert("작업 실패 !!!");
				$("#chk2").dialog("close");
				 
				 
				$("#groupName").val("");
				$("#subject").val("");
				$("#content").val("");
				$("#imageFilename").val("");			
				
				listPage(1);
	
			}
			 
			,error:function(e) {
				console.log(e.responseText);
			}
			
		});

}

//모달띠이우는곳
function updateDialog(gallyNum) {
	var url="<%=cp%>/group/photo/article?gallyNum="+gallyNum;
	
	$('#myModal .modal-body').load(url, function() {
	    $('#myModal .modal-title').html('정보');
		$('#myModal').modal('show');
		$("input[name='name']").focus();
	});
}

function updateCancel() {
	$('#myModal').modal('hide');
}

function updateOk() {
	alert("ok");
}

//리플 등록
function GReply(gallyNum) {
	var userId="${sessionScope.member.userId}";
	var content=$("#answerContent").val().trim();
	
	if(!content) {
		$("#answerContent").focus();
		return;
	}
	
	var query="gallyNum="+gallyNum;
	query+="&content="+content;
	query+="&replyAnswer=0";
	query+="&userId="+userId;
	
	
	$.ajax({
		type:"post"
		,url:"<%=cp%>/group/photo/createdGReply"
		,data:query
		,dataType:"json"
		,success:function(data) {
			$("#answerContent").val("");
			
			var loginChk=data.loginChk;
	
			if(loginChk=="false") {
				alert("들어왔당");
			} else{
				listPage(1);
			}
		}
		,error:function(e) {
			console.log(e.responseText);
		}
	});
}

</script>
<div style="margin:0px; padding:0px; width: 1200px; height: 600px; ">
	
	 	<div>
			<div style="clear: both; margin-top: 0px; height: 30px;">
					<div style="float: left; min-width: 85px; text-align: right;">
						<div class="chk1"><!-- 버튼이 들어가있는  div -->
							<button type="button">
								<img src="<%=cp%>/res/images/btn.png"
									style="width: 50px; height: 50px; position: relative; top: 10pk;">
								<div id="finsh">등록하기</div>
							</button>
						</div>
					</div>
			</div>
		</div> 
		
		
		<div id="listlayout"> </div>
</div>		

	
	<!-- 등록하기 눌럿을떄 나오는 팝업 창 -->
		<div class="chk2" id="chk2" style="display: none; padding:0px; margin: 0px; width: 500px; height: 500px;">
		    <form method="post" name="photoForm" id="photoForm" enctype="multipart/form-data" >
				<div style="height: 300px; width: 480px; border: 1px solid black;">
					<h3 style="margin-top: 10px; margin-left: 220px;">그룹명</h3>
					<div style="width: 200px; height: 50px; margin-left: 30px; background: red;">
					 그릅명: 	<input type="text" id="groupName" name="groupName">
					</div>
						<div style="margin-top: 10px;">
							<h4 style="float: left; margin: 0px;">재 목 :&nbsp;</h4>
							<input type="text" name="subject" id="subject" value="" placeholder="내용을 입력하세요" style="clear: both;">
							<span id="span1" style="display: none;">내용좀 입력하세요</span>
						</div>
						
						<div>
							<h4>내 용 : <span style="display: none;" id="span2">내용좀 입력하세요</span></h4> 
							<textarea rows="5" name="content" id="content" required="required" style="width: 300px; height: 100px;"></textarea>
						</div>		
				</div>

				<div style="margin: 0px;margin-left : 40px; margin-top: 10px; width: 300px; height: 50px; border: 1px solid black;" >
					<input type="file" name="upload" id="imageFilename" >
				</div>
				
				<div style="margin-left: 100px; margin-top: 20px; float: right; " >
					<button type="button" id="btn" name="btn" onclick="send();" >등록하기</button>
					<button type="button" onclick="javascript:location.href='<%=cp%>/groupGally/list';">취소</button>
				</div>
		    </form>	
		</div>
	
	
	
	
	
	<!-- 글보기 눌럿을떄 팝업 창을 띠우기 위해서 만들어논거. -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel" style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">수정</h4>
		      </div>
		      <div class="modal-body"></div>
		    </div>
		  </div>
		</div>
		<!-- ----------------------------------- -->
	

	
	
	
	
	
	
	