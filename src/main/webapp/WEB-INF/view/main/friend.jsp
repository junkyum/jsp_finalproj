<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.listFriend {
	float:left;
	width:180px;
	height:240px;	
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border:1px solid #ccc;
}
#tabFriendList
#tabFriendAdd
#tabFriendBlock {
	width: 100%; 
	height: 380px;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    $('#tabFriendList').load('<%=cp%>/friend/friendlist');
    $('#tabFriendAdd').load('<%=cp%>/friend/add');
    $('#tabFriendBlock').load('<%=cp%>/friend/block');
});
//탭을 선택 한 경우
 $(function(){
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		var active=$(this).attr("aria-controls");
		console.log("되냐?");
		friend(active);
	});	
}); 
function friend(mode) {
	var url="<%=cp%>/friend/"+mode;
	
	$.get(url,
		
		/* {
			dumi:new Date().getTime()
		}, */
		function(data){
			var s=$.trim(data);
			if(s=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;	
			}
			var id="#tabFriendList";
			if(mode=="add")
				id="#tabFriendAdd";
			else if(mode=="block")
				id="#tabFriendBlock";
			$(id).html(data);
	});
}
</script>

<div>
    <div role="tabpanel" style="height:500px;float:left;">
		<ul class="nav nav-tabs" role="tablist" style="height: 40px;">
			<li role="presentation"  class="active">
				<a href="#tabFriendList" aria-controls="friendlist" role="tab" data-toggle="tab">친구 목록</a>
			</li>
	        <li role="presentation">
	        	<a href="#tabFriendAdd" aria-controls="add" role="tab" data-toggle="tab">친구 검색</a>
	        </li>
	        <li role="presentation">
	        	<a href="#tabFriendBlock" aria-controls="block" role="tab" data-toggle="tab">친구 관리</a>
	        </li>
		</ul>

		<div class="tab-content" style="padding: 5px; margin-top: 15px; width: 100%; height: 400px;">
			<div role="tabpanel" class="tab-pane active" id="tabFriendList"></div>
			<div role="tabpanel" class="tab-pane" id="tabFriendAdd"></div>
			<div role="tabpanel" class="tab-pane" id="tabFriendBlock"></div>
		</div>
	</div>
</div>
    