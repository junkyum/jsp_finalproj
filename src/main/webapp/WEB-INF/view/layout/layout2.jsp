<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
   String cp = request.getContextPath();
   // String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+cp;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css" type="text/css">
<%-- <link rel="stylesheet" href="<%=cp%>/res/jquery/css/jquery-ui.min.css" type="text/css"/> --%>
<link rel="stylesheet" href="<%=cp%>/res/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>

<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/my.jquery.js"></script>


</head>
<body>

<div class="layoutMain">
	<div class="layoutHeader">
		<tiles:insertAttribute name="header"/>
	</div>
	
	<div class="layoutBody2">
	    <div class="layoutBodyLeft">
	    	<tiles:insertAttribute name="left"/>
	    </div>
	    <div class="layoutBodyRight">
	    	<tiles:insertAttribute name="body"/>
	    </div>
	</div>
	
	<div class="layoutFooter">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>

</body>
</html>