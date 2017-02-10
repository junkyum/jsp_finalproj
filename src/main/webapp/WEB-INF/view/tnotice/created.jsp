<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.bs-write table {
	width: 100%;
	border: 0;
	border-spacing: 0;
}

.table tbody tr td {
	border-top: none;
	font-weight: normal;
	font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.bs-write table td {
	padding: 3px 3px 3px 3px;
}

.bs-write .td1 {
	min-width: 100px;
	min-height: 30px;
	color: #666;
	vertical-align: middle;
}

.bs-write .td2 {
	
}

.bs-write .td3 {
	
}

.bs-write .td4 {
	
}
</style>

<script type="text/javascript">
  function check() {
        var f = document.tnoticeForm;

    	var str = f.subject.value;
        if(!str) {
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            f.content.focus();
            return false;
        }

        var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/tnotice/created";
    	else if(mode=="update")
    		f.action="<%=cp%>/tnotice/update";

    	// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송
        return true;
 }
  
  //동적으로 추가된 태그도 이벤트 처리 가능
$(function(){
	$("body").on("change", "input[name=upload]", function(){
		if(! $(this).val()) {
			return;	
		}
		
		var b=false;
		$("input[name=upload]").each(function(){
			if(! $(this).val()) {
				b=true;
				return;
			}
		});
		if(b)
			return;

		var $tr, $td, $input;
		
	    $tr=$("<tr>");
	    $td=$("<td>", {class:"td1", html:"첨부"});
	    $tr.append($td);
	    $td=$("<td>", {class:"td3", colspan:"3"});
	    $input=$("<input>", {type:"file", name:"upload", class:"form-control input-sm", style:"height: 35px;"});
	    $td.append($input);
	    $tr.append($td);
	    
	    $("#tb").append($tr);
	});
});
  
  <c:if test="${mode=='update'}">
  function deleteFile(fileNum) {
		var url="<%=cp%>/tnotice/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "JSON");
  }
</c:if>

</script>

<div class="mk_bodyFrame2" style="margin: 0 auto; width: 1000px; padding-top: 10px;">
	<div class="mk_body-title">
		<h3>공지사항</h3>
	</div>

	<div>
		<form name="tnoticeForm" method="post" onsubmit="return check();" enctype="multipart/form-data">
			<div class="bs-write">
				<table class="table" border="1">
					<tbody id="tb">
						<tr>
							<td class="td1">작성자명</td>
							<td class="td2 col-md-5 col-sm-5">
								<p class="form-control-static">${sessionScope.member.userName}</p>
							</td>
							<td class="td1" align="center">공지여부</td>
							<td class="td2 col-md-5 col-sm-5">
								<div class="checkbox">
									<label> 
										<input type="checkbox" name="notice" value="1" ${dto.notice==1 ? "checked='checked' ":"" }> 공지
									</label>
								</div>
							</td>
						</tr>

						<tr>
							<td class="td1">제목</td>
							<td colspan="3" class="td3">
								<input type="text" name="subject" class="form-control input-sm" value="${dto.subject}" required="required">
							</td>
						</tr>

						<tr>
							<td class="td1" colspan="4" style="padding-bottom: 0px;">내용</td>
						</tr>
						<tr>
							<td colspan="4" class="td4">
								<textarea name="content" class="form-control" rows="15" required="required">${dto.content}
								</textarea>
							</td>
						</tr>

						<tr>
							<td class="td1">첨부</td>
							<td colspan="3" class="td3">
								<input type="file" name="upload" class="form-control input-sm" style="height: 35px;">
							</td>
						</tr>
					</tbody>

					<c:if test="${mode=='update'}">
						<c:forEach var="vo" items="${listFile}">
							<tr id="f${vo.fileNum}">
								<td class="td1">첨부파일</td>
								<td colspan="3" class="td3">
									${vo.originalFilename} | 
									<a href="javascript:deleteFile('${vo.fileNum}');">삭제</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>

					<tfoot>
						<tr>
							<td colspan="4" style="text-align: center; padding-top: 15px;">
								<button type="submit" class="btn btn-default btn-sm wbtn">
									확인 
									<!-- 체크 그림 -->
									<!-- <span class="glyphicon glyphicon-ok"></span> -->
								</button>
								<button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tnotice/list';">
									취소
								</button> 
								<c:if test="${mode=='update'}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="num" value="${dto.num}">
								</c:if>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</form>
	</div>
</div>
