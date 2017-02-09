<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">

// 요청 받은 친구 - 수락
function friendAccept() {
    var chks = $("#tbAskedList input:checked");
	var cnt = chks.length;
	if(cnt==0) {
		return;
	}
    
	if(! confirm("선택한 친구를 수락 하시겠습니까 ? "))
		return;

	var url="<%=cp%>/friend/friendManage";
    var query = "mode=asked";
    $.each(chks, function(e, ch) {                    
    	query+="&numList="+$(ch).val();
    	query+="&userIdList="+$(ch).attr("data-userId");
    });
    
    $.ajax({
        type: "POST",
        url: url,
        data: query,
        success: function(data){
        	var s=$.trim(data);
			if(s=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;	
			}        	
        	// 등록된 친구
        	$("#tbFriendList").html(s);
        	
        	// 요청받은 친구중 수락된 친구 삭제
        	var userId;
        	$.each(chks, function(e, ch) {                    
        	   userId=$(ch).attr("data-userId");
       	        $("#tbAskedList tr[data-tid='"+userId+"']").remove();
       	    });
        },
        error: function(e){
            alert(e.responseText);
        }
    });

}

// 요청 받은 친구 - 거절
function friendDenial() {
    var chks = $("#tbAskedList input:checked");
	var cnt = chks.length;
	if(cnt==0) {
		return;
	}
    
	if(! confirm("선택한 친구를 거절 하시겠습니까 ? "))
		return;

	var url="<%=cp%>/friend/friendManage";
    var query = "mode=denial";
    $.each(chks, function(e, ch) {                    
    	query+="&numList="+$(ch).val();
    });
    
    $.ajax({
        type: "POST",
        url: url,
        data: query,
        success: function(data){
        	var s=$.trim(data);
			if(s=="loginFail") {
				location.href="<%=cp%>/member/login";
				return;	
			}
			
        	$("#tbAskedList").html(data);
        },
        error: function(e){
            alert(e.responseText);
        }
    });
}
</script>

<div>
    <div style="clear: both;">
        <div style="float: left;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">등록된 친구</span>
             </div>
             
             <div class="listFriend">
                 <table style="border-spacing: 0px;">
              		<tbody id="tbFriendList">
              		    <c:forEach var="dto" items="${friendList}">
	              		    <tr height='25' data-tid='${dto.friendUserId}' >
	              		         <td align='center' width='30'>
	              		             <input type='checkbox' value='${dto.num}' data-userId='${dto.friendUserId}'>
	              		         </td>
	              		         <td align='left' width='200'>
	              		             ${dto.friendUserName}(${dto.friendUserId})
	              		         </td>
	              		    </tr>
              		    </c:forEach>
              		</tbody>
                 </table>
             </div>
             
             <div style="clear: both; padding-top: 10px;">
                 <a class="btn btn-default btn-sm" href="#">쪽지</a>
             </div>
        </div>
        
        <div style="float: left; padding: 0px 10px;">&nbsp;</div>
        
        <div style="float: left;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">요청받은 친구</span>
             </div>
        
             <div class="listFriend">
                 <table style="border-spacing: 0px;">
              		<tbody id="tbAskedList">
              		    <c:forEach var="dto" items="${friendAskedList}">
	              		    <tr height='25' data-tid='${dto.friendUserId}'>
	              		         <td align='center' width='30'>
	              		             <input type='checkbox' value='${dto.num}' data-userId='${dto.friendUserId}' data-userName='${dto.friendUserName}'>
	              		         </td>
	              		         <td align='left' width='200'>
	              		             ${dto.friendUserName}(${dto.friendUserId})
	              		         </td>
	              		    </tr>
              		    </c:forEach>
              		</tbody>
                 </table>
             </div>

             <div style="clear: both; padding-top: 10px;">
                 <a class="btn btn-default btn-sm" href="javascript:friendAccept()">수락</a>
                 <a class="btn btn-default btn-sm" href="javascript:friendDenial()">거절</a>
             </div>

        </div>
    </div>
</div>    
