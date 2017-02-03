<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
	<c:if test="${dataCount !=0}">
	 &nbsp;&nbsp;총${dataCount}개&nbsp;(${page}현제/${total_page}전체페이지) 
		<c:forEach var="dto" items="${list}" varStatus="status">
		
				<c:if test="${status.index==0}">
                 <c:out value="<div style='clear: both; max-width:1000px; margin: 0px auto; margin-right: 50px;'>" escapeXml="false"/>
                 </c:if>
                 <c:if test="${status.index!=0 && status.index%3==0}">
                        <c:out value="</div><div style='clear: both; max-width:1000px; margin: 0px auto; margin-right: 50px;'>" escapeXml="false"/>
                 </c:if>
                 
			<div class="imgLayout">
	                  <div class="onePoto">
						<a href="javascript:updateDialog('${dto.gallyNum}')">
						<img class="img-responsive" src="<%=cp%>/uploadf/photo/${dto.imageFilename}" style="width: 190px; height: 170px;" border="0">
						</a>
						</div>
					<div class="file-name">
						<span class="file-name" style="margin-left: 50px;">재  목  : ${dto.subject}</span>
						 <br> <small style="margin-left: 50px;">리스트번호  : ${dto.listNum}</small>
					</div>
			   </div>
		</c:forEach>
		<c:if test="${n>0&&n%3!=0}">
		        <c:forEach var="i" begin="${n%3+1}" end="3" step="1">
			             <div class="imgLayout">&nbsp;</div>
		        </c:forEach>
		    </c:if>
		    
		    
			
		    <c:if test="${n!=0 }">
				       <c:out value="</div>" escapeXml="false"/>
		    </c:if>
	</c:if> 

	<div style="clear: both; margin: auto;"></div>
		<!-- 페이징 처리 -->
		 	<div style="margin: 15px auto; text-align: center; margin-top: 0px;">
			   <c:if test="${dataCount==0 }"> 등록된 게시물이 없습니다.</c:if>
	            <c:if test="${dataCount!=0 }"> ${paging} </c:if>
			</div> 
			
			<!-- 여기서부턴 검색   ckear  초기화-->
		<div style="clear: both;">
		<!-- 페이징 처리 밑단 검색 부분 -->
			<div style="float: left; width: 20%; min-width: 85px; margin-left: 40px;">
				<button type="button" class="btn btn-default btn-sm wbtn" onclick="listPage(1)">새로고침</button>
			</div>
			
			<div style="float: left; width: 60%; text-align: center;">
				<form name="searchPhoto" method="post">
				
					<select name="searchKey">
						<option value="subject">제목</option>
						<option value="#">작성자</option>
						<option value="content">내용</option>
						<option value="created">등록일</option>
					</select>
					
					 <input type="text" name="searchValue" style="width: 40%;">
					 <button type="button" onclick="searchList();"> 검색</button>
				</form>
			</div>
			
	</div>
	
	