<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
.container {
	width: 900px;
	height: 680px;
	border: 1px solid #5D5D5D;
}
</style>
<head>
</head>
<body>
	<form name="dialogNoticeUpdateForm" method="post">
		<p>
			<input type="text" name="subject" id="updateSubjectkmNoti" value="${dto.subject }">
		</p>
		<p>
			<textarea rows="5" cols="50" id="updateContentkmNoti" name="content">${dto.content }</textarea>
		</p>
			<c:forEach var="vo" items="${listFile}">
				<p id="f${vo.fileNum}">
					${vo.originalFilename} &nbsp;
					<a href="javascript:gboardDeleteFile(${vo.fileNum});">삭제</a>
				</p>
			</c:forEach>
		<p>
			<input type="file" name="upload" id="updateFilekmNoti" class="form-control input-sm" style="height: 35px;">
		</p>
		<input type="hidden" name="page" value="${page}">
        <input type="hidden" name="num" id="updateNumkm" value="${dto.num}">
        <input type="hidden" name="userId" value="${dto.userId}">
	</form>
</body>
