<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
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
<c:forEach var="dto" items="${list}">
    <div class="panel-group" id="accordion${dto.num}" role="tablist" aria-multiselectable="true" style="margin-bottom:5px;">
        <div class="panel panel-defaul">
            <div class="panel-heading" role="tab" id="heading${dto.num}">
                <h4 class="panel-title" style="font-size: 14px;">
                    <span class="glyphicon glyphicon-search" style="display: inline-block; width: 100px; font-weight: bold;">&nbsp;[${dto.classify}]</span> : &nbsp;&nbsp;
                    <a data-toggle="collapse" data-parent="#accordion${dto.num}" href="#collapse${dto.num}" aria-expanded="true" aria-controls="collapse${dto.num}">
                         ${dto.subject}
                    </a>
                </h4>
            </div>
            <div id="collapse${dto.num}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${dto.num}">
                <div class="panel-body">
                      &nbsp;&nbsp;&nbsp;&nbsp; A :  ${dto.content}
                        <c:if test="${sessionScope.member.userId=='admin'}">
                            <div style="padding-top: 5px;">
                                <hr>
			                    <a href="<%=cp%>/tfaq/update?num=${dto.num}&pageNo=${pageNo}&category=${tab}">수정</a>&nbsp;|
			                    <a href="<%=cp%>/tfaq/delete?num=${dto.num}&pageNo=${pageNo}&category=${tab}">삭제</a>
                            </div>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
            <c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
</div>        
