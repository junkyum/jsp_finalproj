<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
// 친구 검색
$(function() {
	$("#friendSearchButton").click(function() {
		var friendValue=$.trim($("#friendValue").val());
		if(!friendValue) {
			alert("검색할 값을 입력 하세요 !!!");
			$("#friendValue").focus();
			return;
		}
		
    	var url="<%=cp%>/friend/searchList";
    	var query="searchKey="+$("#friendKey").val();
    	query+="&searchValue="+friendValue;
		
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
    			
            	$("#friendSearchList").html(s);
            	$("#friendValue").val("");
            },
            error: function(e){
                alert(e.responseText);
            }
        });
	});
});
// 친구 요청
function friendAdd(friendUserId) {
	if(!confirm("친구 추가를 요청 하시겠습니까 ? "))
		return;
	
	var url="<%=cp%>/friend/add";
    var query="friendUserId="+friendUserId;
    
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
			
        	$("#friendAskList").html(s);
        	
        	// 검색 항목 지우기
        	$("#friendSearchList span[data-userId='"+friendUserId+"']").remove();
        	
        },
        error: function(e){
            alert(e.responseText);
        }
    });
}
// 친구요청 취소
function askDelete(num) {
	if(!confirm("친구 요청을 취소 하시겠습니까 ? "))
		return;
	
	var url="<%=cp%>/friend/askDelete";
    var query="num="+num;
    
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
			
        	$("#friendAskList").html(s);
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
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">친구 추가</span>
             </div>
             
             <div style="clear: both; width: 180px;">
	               <select id="friendKey" class="form-control" >
	                  <option value="userName">이름 검색</option>
	                  <option value="userId">아이디 검색</option>
	               </select>
	               <div class="input-group" style="padding-top: 5px; padding-bottom: 5px;">
	               	
                       <input type="text" id="friendValue" class="form-control input-sm" placeholder="">
                       <span class="input-group-btn" >
                           <button type="button" class="btn btn-default btn-sm wbtn" id="friendSearchButton"><i class="glyphicon glyphicon-search"></i></button>
                       </span>
   	               </div>
             </div>
             
             <div id="friendSearchList" class="listFriend" style="clear: both; height: 166px;">
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
             
             <div style="clear: both; padding-top: 10px;">&nbsp;</div>
        </div>
        
        <div style="float: left; padding: 0px 10px;">&nbsp;</div>
        
        <div style="float: left;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">요청한 친구</span>
             </div>
        
             <div id="friendAskList" class="listFriend">
			     <c:forEach var="dto" items="${friendAskList}">
			         <span data-userId="${dto.friendUserId}" style="display: block;">
			             &nbsp;<a href="javascript:askDelete('${dto.num}');"><img src="<%=cp%>/res/images/icon-minus.png" border="0"></a>&nbsp;
			             ${dto.friendUserName}(${dto.friendUserId})</span>
			     </c:forEach>
             </div>

             <div style="clear: both; padding-top: 10px;">&nbsp;</div>

        </div>
    </div>
</div>    
