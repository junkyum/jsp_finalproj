<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.table th, .table td {
    font-weight: normal;
    border-top: none;
}
.table thead tr th{
     border-bottom: none;
} 
.table thead tr{
    border: #d5d5d5 solid 1px;
     background: #eeeeee; color: #787878;
} 
.table td {
    border-bottom: #d5d5d5 solid 1px;
}
.table td a{
    color: #000;
}
</style>

<script type="text/javascript">
function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/tqna/list";
		f.submit();
}
</script>

<div class="bodyFrame2" style="margin: 0 auto; margin-top: 100px;">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-question-sign"></span> 질문과답변 </h3>
    </div>
    

    <div>
<c:if test="${dataCount!=0 }">
        <div style="clear: both; height: 30px; line-height: 30px;">
            <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
            <div style="float: right;">&nbsp;</div>
        </div>

        <div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th class="text-center" style="width: 70px;">번호</th>
                        <th >제목</th>
                        <th class="text-center" style="width: 100px;">글쓴이</th>
                        <th class="text-center" style="width: 100px;">날짜</th>
                        <th class="text-center" style="width: 70px;">조회수</th>
                    </tr>
                </thead>
                <tbody>
    <c:forEach var="dto" items="${list}">
                    <tr>
                        <td class="text-center">${dto.listNum}</td>
                        <td>
                            <c:forEach var="n" begin="1" end="${dto.depth}">
                                &nbsp;&nbsp;
                            </c:forEach>
                            <c:if test="${dto.depth!=0}">
                                <img src='<%=cp%>/res/images/re.gif'>
                            </c:if>
                            <a href='${urlArticle}&qnaNum=${dto.qnaNum}'>${dto.subject}</a>
                        </td>
                        <td class="text-center">${dto.userName}</td>
                        <td class="text-center">${dto.created}</td>
                        <td class="text-center">${dto.hitCount}</td>
                    </tr>
     </c:forEach>                    
                </tbody>
            </table>
        </div>
</c:if>

        <div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
            <c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
        </div>        
        
        <div style="clear: both;">
        		<div style="float: left; width: 20%; min-width: 85px;">
        		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tqna/list';">새로고침</button>
        		</div>
        		<div style="float: left; width: 60%; text-align: center;">
        		     <form name="searchForm" method="post" class="form-inline">
						  <select class="form-control input-sm" name="searchKey" >
						      <option value="subject">제목</option>
						      <option value="userName">작성자</option>
						      <option value="content">내용</option>
						      <option value="created">등록일</option>
						  </select>
						  <input type="text" class="form-control input-sm input-search" name="searchValue">
						  <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchList();"><span class="glyphicon glyphicon-search"></span> 검색</button>
        		     </form>
        		</div>
        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
        		    <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/tqna/created';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 글쓰기</button>
        		</div>
        </div>
        
    </div>
    
</div>