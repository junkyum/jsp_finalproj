<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    	String cp = request.getContextPath();
%>

<script src="//code.jquery.com/jquery-1.10.2.js"></script> 
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript">
function mk_main_indiv() {
	mk_indiv.style.display="block";
	//  mk_indivMenu.style.display="block";
	// mk_group.style.display="none";
	mk_groupMenu.style.display="none";
	$("#mk_group").hide("fade",1000);
	$("#mk_indivMenu").delay(2000).animate({
		left:0
	},"clip");
	$("#mk_indivMenu").show("blind",1200);
}
function mk_main_group() {
	// mk_indiv.style.display="none";
	mk_indivMenu.style.display="none";
	mk_group.style.display="block";
	// mk_groupMenu.style.display="block";
	$("#mk_indiv").hide("fade",1000);
	// $("#mk_group").hide("fade",1000);
	$("#mk_groupMenu").delay(2000).animate({
		left:0
	},"clip");
	// $("#mk_group").show("drop",2000);
	$("#mk_groupMenu").show("clip",2000);
}
</script>


<style type="text/css">
#mk_content {
	float:left;
	width: 100%;
	height:500px;
}
#mk_indiv {
	background-color: #C4B73B;
	text-align: center;
	width: 49%;
	height: 100%;
	float: left;
	padding-top: 20px;	
}
.mk_indiv_in {
	display: inline-block;
	background-color: #C4B73B;
}
#mk_group {
	background-color: #6B66FF;
	text-align: center;
	width: 49%;
	height: 100%;
	float: left;	
	padding-top: 20px;
}
.mk_group_in {
	display: inline-block;
	background-color: #6B66FF;
}
#mk_indivMenu {
	background-color: #6B66FF;
	text-align: center;
	width: 50%;
	height: 100%;
	float: left;	
	padding-top: 50px;
}
#mk_groupMenu {
	background-color: #C4B73B;
	text-align: center;
	width: 50%;
	height: 100%;
	float: left;
	padding-top: 50px;	
}

</style>


<div id="mk_content">

	<!-- 개인 -->
	<div id="mk_indiv">
	
		<div class="mk_indiv_in">
			<button type="button" onclick="mk_main_indiv();" 
					id="btn_indiv"  style="background-color:#C4B73B; border: 0px;">
				<img src="<%=cp%>/res/images/indiv.png" style="width: 80%">
			</button>
		</div>
	</div>
	
		
	<!-- 그룹 -->
	<div id="mk_group">
	
		<div class="mk_group_in">
			<button type="button" onclick="mk_main_group();" 
					id="btn_group" style="background-color:#6B66FF; border: 0px;" >
				<img src="<%=cp%>/res/images/group.png" style="width: 80%;">
			</button>
		</div>
	</div>
	
	<!-- 개인 메뉴바 -->
	<div id="mk_indivMenu" style="display: none;">
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_A.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/board/list">
				<img src="<%=cp%>/res/images/img_B.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_C.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_D.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_E.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_F.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
	</div>
	
	<!-- 그룹 메뉴바 -->
	<div id="mk_groupMenu" style="display: none;">
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_F.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_E.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_D.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_C.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
		<div>
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_B.jpg" style="width: 25%; height: 135px;">
			</a>
		
			<a href="<%=cp%>/#">
				<img src="<%=cp%>/res/images/img_A.jpg" style="width: 25%; height: 135px;">
			</a>
		</div>
	</div>
</div>


