<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.bodyFrame2{
	padding-top: 10px;
}

@media (min-width: 768px) {
  .bodyFrame2 {
    min-height: 600px;
  }
}

.body-title {
    color: #424951;
    padding-bottom: 5px;
    margin: 0 0 20px 0;
    border-bottom: 1px solid #dddddd;
}
.body-title h3{
	min-width:300px;
    font-family: "Malgun Gothic", "Nanum Gothic", "Dotum";
    font-weight: bold;
    margin: 0 0 -5px 0;
    padding-bottom: 5px;
    display: inline-block;
    border-bottom: 3px solid #424951;
}

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

.bbs-reply {
    font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.bbs-reply-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
</style>

<script type="text/javascript">
//-------------------------------------
//댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/tphoto/listReply";
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
		,url:"<%=cp%>/tphoto/createdReply"
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



//좋아요/싫어요 추가
function tsendLike(num, tphotoLike) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(tphotoLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	
	var params="num="+num;
	params+="&tphotoLike="+tphotoLike;

	$.ajax({
		type:"POST"
		,url:"<%=cp%>/tphoto/tphotoLike"
		,data:params
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="true") {
				countLike(num);
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
	var url="<%=cp%>/tphoto/tcountLike";
	$.post(url, {num:num}, function(data){
		var tlikeCountId="#tlikeCount"+num;
		var tlikeCount=data.tlikeCount;
		
		$(tlikeCountId).html(tlikeCount);
	}, "JSON");
}

//좋아요/싫어요 추가
function tsendLike(num, tphotoLike) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return false;
	}

	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(tphotoLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	
	var params="num="+num;
	params+="&tphotoLike="+tphotoLike;

	$.ajax({
		type:"POST"
		,url:"<%=cp%>/tphoto/tphotoLike"
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



////////////////////////////////////////////////////////////
//리플
//좋아요/싫어요 개수
function countLike(repleNum) {
	var url="<%=cp%>/tphoto/countLike";
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
		,url:"<%=cp%>/tphoto/repleLike"
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
		var url="<%=cp%>/tphoto/deleteReply";
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

//-------------------------------------
function deletePhoto()  {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
  var num = "${dto.num}";
  var page = "${page}";
  var params = "num="+num+"&page="+page;
  var url = "<%=cp%>/tphoto/delete?" + params;

  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updatePhoto() {
<c:if test="${sessionScope.member.userId==dto.userId}">
  var num = "${dto.num}";
  var page = "${page}";
  var params = "num="+num+"&page="+page;
  var url = "<%=cp%>/tphoto/update?" + params;

  location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!=dto.userId}">
 alert("게시물을 수정할 수  없습니다.");
</c:if>
}

</script>

<div class="bodyFrame2" style="margin: 0px auto 20px;">
   <div class="body-title" style="text-align: center; margin-top: 50px">
          <h3><span class=""></span>   PORTFOLIO
</h3>
    </div>
    
    
    <div class="table-responsive" style="clear: both; min-height: 500px; overflow: visible;">
        <div class="bbs-article">
            <table class="table">
                 <thead>
                     <tr>
                         <th colspan="3" style="text-align: left;">
                               <span style="font-weight: bold;">${dto.subject}</span>
                         </th>
                     </tr>
                <thead>
                 <tbody>
                     <tr>
                         <td style="text-align: left;">
                                                    이름 : ${dto.userName}
                         </td>
                         <td style="text-align: right;">
                          ${dto.created}
                         </td>
                         <td style="text-align: right;">
                          ${dto.hitCount}
                         </td>
                     </tr>
                     
                     <tr style="border-bottom:none;">
                         <td colspan="3" style="text-align: center;">
                             <img src="<%=cp%>/uploads/tphoto/${dto.imageFilename}" style="max-width:100%; height:auto; resize:both;">
                         </td>
                     </tr>
                     
                     <tr>
                         <td colspan="3" style="min-height: 30px;">
                              ${dto.content}
                         </td>
                     </tr>
                     <tr>
                         <td colspan="3">
                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
                              <c:if test="${not empty preReadDto }">
                                  <a href="<%=cp%>/tphoto/article?${params}&num=${preReadDto.num}">${preReadDto.subject}</a>
                              </c:if>					
                         </td>
                     </tr>
                     <tr>
                         <td colspan="3" style="border-bottom: #d5d5d5 solid 1px;">
                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
                              <c:if test="${not empty nextReadDto }">
                                  <a href="<%=cp%>/tphoto/article?${params}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
                              </c:if>
                         </td>
                     </tr>                                          
                </tbody>
                <tfoot>
                	<tr>
                		<td>
<c:if test="${sessionScope.member.userId==dto.userId}">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="updatePhoto();">수정</button>
</c:if>
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">	                		    
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="deletePhoto();">삭제</button>
</c:if>                		    
                		</td>
                		<td align="right">
                		 <button type="button" class="btn btn-default btn-sm wbtn" onclick="tsendLike('${dto.num}', '1')"><span class="glyphicon glyphicon-hand-up"></span> 좋아요 <span id="tlikeCount${dto.num}">${dto.tlikeCount}</span></button>
                        
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tphoto/list?${params}';"> 목록으로 </button>
                		</td>
                	</tr>
                </tfoot>
            </table>
       </div>
       
       <div class="bbs-reply">
           <div class="bbs-reply-write">
               <div style="clear: both;">
           	       <div style="float: left;"><span style="font-weight: bold;">댓글쓰기</span></div>
           	       <div style="float: right; text-align: right;"></div>
               </div>
               <div style="clear: both; padding-top: 10px;">
                   <textarea id="content" class="form-control" rows="3" placeholder="인터넷은 우리가 함께 만들어가는 소중한 공간입니다.  댓글 작성 시 타인에 대한 배려와 책임을 담아주세요."></textarea>
               </div>
               <div style="text-align: right; padding-top: 10px;">
                   <button type="button" class="btn btn-default btn-sm wbtn" onclick="sendReply();"> 댓글등록 <span class="glyphicon glyphicon-ok"></span></button>
               </div>           
           </div>
       
           <div id="listReply"></div>
       </div>
   </div>

</div>