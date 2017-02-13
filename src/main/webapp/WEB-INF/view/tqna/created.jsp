<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
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
        var f = document.boardForm;

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
    		f.action="<%=cp%>/tqna/created";
     	else if(mode=="reply")
            f.action="<%=cp%>/tqna/reply";
    	else if(mode=="update")
    		f.action="<%=cp%>/tqna/update";

    	// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송
        return true;
 }
</script>

<div class="bodyFrame2" style="margin: 0 auto; margin-top: 80px;">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-question-sign"></span> 질문과답변 </h3>
    </div>
    
    <div>
        <form name="boardForm" method="post" onsubmit="return check();">
            <div class="bs-write">
                <table class="table">
                    <tbody>
                        <tr>
                            <td class="td1">작성자명</td>
                            <td class="td2 col-md-5 col-sm-5">
                                <p class="form-control-static">${sessionScope.member.userName}</p>
                            </td>
                            <td class="td1" align="center"></td>
                            <td class="td2 col-md-5 col-sm-5">
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1">제목</td>
                            <td colspan="3" class="td3">
                                <input type="text" name="subject" class="form-control input-sm" value="${dto.subject}" required="required">
                            </td>
                        </tr>
                        <tr>
                            <td class="td1" colspan="5" style="padding-bottom: 0px;">내용</td>
                        </tr>
                        <tr>
                            <td colspan="5" class="td5">
                            	<textarea name="content" class="form-control" rows="15" required="required">${dto.content}</textarea>
                            </td>
                        </tr>
                    </tbody>
                    
                    <tfoot>
                        <tr>
                            <td colspan="4" style="text-align: center; padding-top: 15px;">
                                  <button type="submit" class="btn btn-primary"> 확인 <span class="glyphicon glyphicon-ok"></span></button>
                                  <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/tqna/list';"> 취소 </button>
                                  
                                  <c:if test="${mode=='reply'}">
                                      <input type="hidden" name="page" value="${page}">
                                      <input type="hidden" name="groupNum" value="${dto.groupNum}">
                                      <input type="hidden" name="orderNo" value="${dto.orderNo}">
                                      <input type="hidden" name="depth" value="${dto.depth}">
                                      <input type="hidden" name="parent" value="${dto.qnaNum}">
                                  </c:if>
                                  <c:if test="${mode=='update'}">
                                      <input type="hidden" name="page" value="${page}">
                                      <input type="hidden" name="qnaNum" value="${dto.qnaNum}">   
                                  </c:if>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </form>
    </div>
</div>
