<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
	/* 
		정보 들록후 리스트뿌려준다.
	*/
%>

	
<table style="width: 1000px; margin: 20px auto 0px; border-spacing: 0px;">
   <tr height="35">
      <td align="left" width="50%">
        <form name="groupReplyBoardForm" method="post">
            <select name="searchKeyC" id="searchKeyC" class="selectField" >
                  <option value="subject">제목</option>
                  <option value="content">내용</option>
                  <option value="created">등록일</option>
            </select>
            <input type="text" name="searchValueC"  id="searchValueC" class="boxTF" >
            <input type="button" value=" 탐  색 " class="btn" onclick="searchReplyList()">
        </form>
      </td>
      <td align="right">
     	 <input type="button" value=" 새로고침 " class="btn" onclick="replyBoardList(pageNo);">
          <input type="button" value=" 글올리기 " class="btn" onclick="submitReply();">
      </td>
   </tr>
</table>


<div style="clear: both; height: 30px; line-height: 30px;">
            <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
            <div style="float: right;">&nbsp;</div>
   	</div>
<table style="width: 1000px; margin: 0px auto; border-spacing: 0px;">
  <tr align="center" bgcolor="#507CD1" height="30"> 
      <td width="60" style="color: #ffffff;">번호 </td>
      <td width="350" style="color: #ffffff;">제목</td>
      <td width="100" style="color: #ffffff;">작성자</td>
      <td width="80" style="color: #ffffff;">작성일</td>
      <!-- <td width="60" style="color: #ffffff;">조회수</td> -->
  </tr>
 
</table>

 <c:if test="${dataCount != 0 }">
 <c:forEach var="dto" items="${leplyLlist}">
	<table style="width: 1000px; margin: 0px auto; border-spacing: 0px; border: 1px solid;">
	   <tr align="left"  height="30"> 
	      <td width="60" style="border: 1px solid;">${dto.listNum} </td>
	      <td width="350" style="border: 1px solid;">
  				<c:forEach var="n" begin="1" end="${dto.depth}">
  					&nbsp;
  				</c:forEach>
  				<c:if test="${dto.depth!=0}">
                     <img src="<%=cp%>/res/images/re.gif">
                </c:if>
               <a href="javascript:articleReplyBoard('${dto.replyBoardNum}');">${dto.subject}</a> 
  		  </td>
	      <td width="100" style="border: 1px solid;">${dto.userId} </td>
	      <td width="80" style="border: 1px solid;">${dto.created}</td>
	 <%--      <td width="60" style="border: 1px solid;">${dto.hitcount}</td> --%>
	  </tr>
	</table>
	</c:forEach>
  </c:if>


		<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
            <c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
        </div> 
