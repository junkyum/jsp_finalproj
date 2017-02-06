<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
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
function deleteTNotice() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==dto.userId}">
  var num = "${dto.num}";
  var page = "${page}";
  var params = "num="+num+"&page="+page;
  var url = "<%=cp%>/tnotice/delete?" + params;

  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!=dto.userId}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateTNotice() {
<c:if test="${sessionScope.member.userId==dto.userId}">
  var num = "${dto.num}";
  var page = "${page}";
  var params = "num="+num+"&page="+page;
  var url = "<%=cp%>/tnotice/update?" + params;

  location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!=dto.userId}">
 alert("게시물을 수정할 수  없습니다.");
</c:if>
}

</script>

<div class="mk_bodyFrame2" style="margin : 0 auto; width:1000px; padding-top: 10px;">
    <div class="mk_body-title">
		<h3>
			공지사항 
		</h3>
    </div>
    
    <div class="mk_alert-info" style="margin : 0 auto; background:#B2EBF4; width:800px; text-align: center">
    	 중요한 일정 및 알림, 이벤트 등은 공지사항 통해 고객님께 알려 드립니다.
    </div>

    
    <div class="table-responsive" style="clear: both;">
        <div class="bbs-article">
            <table class="table">
                 <thead>
                     <tr>
                         <th colspan="2" style="text-align: center;">
                                ${dto.subject}
                         </th>
                     </tr>
                <thead>
                
                 <tbody>
                     <tr>
                         <td style="text-align: left;">
                             이름 : ${dto.userName}
                         </td>
                         <td style="text-align: right;">
                          ${dto.created}<i></i>조회 ${dto.hitCount}
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="height: 230px;">
                              ${dto.content}
                         </td>
                     </tr>
                     
<c:forEach var="vo" items="${listFile}">
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">첨부</span> :
                                  <a href="<%=cp%>/tnotice/download?fileNum=${vo.fileNum}"><span class="glyphicon glyphicon-download-alt"></span> ${vo.originalFilename}</a>
                                  (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
                         </td>
                     </tr>
</c:forEach>
                     
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
                              <c:if test="${not empty preReadDto }">
                                  <a href="<%=cp%>/tnotice/article?${params}&num=${preReadDto.num}">${preReadDto.subject}</a>
                              </c:if>					
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
                              <c:if test="${not empty nextReadDto }">
                                  <a href="<%=cp%>/tnotice/article?${params}&num=${nextReadDto.num}">${nextReadDto.subject}</a>
                              </c:if>
                         </td>
                     </tr>                                          
                </tbody>
                
                <tfoot>
                	<tr>
                		<td>
<c:if test="${sessionScope.member.userId==dto.userId}">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="updateTNotice();">수정</button>
</c:if>
<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">	                		    
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="deleteTNotice();">삭제</button>
</c:if>                		    
                		</td>
                		<td align="right">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tnotice/list?${params}';"> 목록으로 </button>
                		</td>
                	</tr>
                </tfoot>
            </table>
       </div>

   </div>

</div>