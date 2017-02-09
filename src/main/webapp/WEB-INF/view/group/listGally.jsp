<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
//글등록후 리스트 뽑는곳
%>
	
	<c:if test="${dataCount !=0}">

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
						<span class="file-name" style="margin: auto;">제  목  : ${dto.subject}</span>
						 <br> <small style="margin: auto;">리스트번호  : ${dto.listNum}</small>
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

	<div style="clear: both;"></div>
		<!-- 페이징 처리 -->
		 	<div style="margin:  auto; text-align: center; margin-top: 0px; height: 40px; " >
			   <c:if test="${dataCount==0 }"> 등록된 게시물이 없습니다.</c:if>
	            <c:if test="${dataCount!=0 }"> ${paging} </c:if>
			</div> 
	
	
			<div style="float: left; width: 20%; min-width: 85px; margin-left: 40px;">
				<button type="button" class="btn btn-default btn-sm wbtn" onclick="listPage(1)">새로고침</button>
				<button type="button" onclick="findGally();"><img src="<%=cp%>/res/images/finder.png" style="width: 30px; height: 30px;"></button>
			</div>
			


		

		
		
		
		
		
		
		
	
	