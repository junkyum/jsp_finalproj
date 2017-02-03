<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<c:forEach var="dto" items="${list }">
	<div class="bigdiv">
		<div class="smalldiv" id="smalldiv">
			${dto.subject }
			<div class="overlay">
				<div class="overtext">${dto.created }<br>
					<c:if test="${sessionScope.member.userId=='admin'}">
						<button type="button" class="btn btn-default" id="kmUpdatebtn"
							onclick="updateNoG(${dto.num});" data-num="${dto.num }"
							data-toggle="modal" data-target="#kmModal">
							<span class="glyphicon glyphicon-refresh"></span>
						</button>
					
						<button type="button" class="btn btn-default" id="kmDeleteBtn"
							onclick="deleteNoG(${dto.num},${page });">
							<span class="glyphicon glyphicon-trash"></span>
						</button>
					</c:if>
				</div>
			</div>
		</div>
		<div id="smsmdiv">
			<div class="middlediv" id="middlediv${dto.num}" data-num="${dto.num}">
				<div id="read-more" class="read-more">
					<c:if test="${dto.content.length() > 180 }">
						<button type="button" class="btn btn-default-sm btn-xs" id="readbtn${dto.num }"
							onclick="layoutview(${dto.num});" >
							<span class="glyphicon glyphicon-resize-full"></span>
						</button>
					</c:if>
					
				</div>
				${dto.content }<!-- </textarea> 하는 방법 있음  -->
				
				<div id="gradient"></div>
			</div>

		</div>
	</div>
</c:forEach>
<div class="paging"
		style="text-align: center; min-height: 50px; line-height: 50px;">
		<c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
		<c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
</div>

