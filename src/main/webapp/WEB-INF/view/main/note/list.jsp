<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.table th, .table td {
    font-weight: normal;
    border-top: none;
}
.table thead tr th{
     border-bottom: none;
} 
.table thead tr{
    border: #d5d5d5 solid 1px;
     background: #eeeeee; color: #787878;
} 
.table td {
    border-bottom: #d5d5d5 solid 1px;
}
.table td a{
    color: #000;
}
.listContent{
  max-width: 230px;
  white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
}
</style>

<script type="text/javascript">
$(function(){
	listPage(1);
});

//페이징 처리  ------------- 
function listPage(page) {
	$('#chkAll').attr("checked",false);
	
	var mode=$("#mode").val();
	var searchKey=$("#searchKey").val();
	var searchValue=$("#searchValue").val();
	
	var url="<%=cp%>/note/listNote";
	$.post(url, {mode:mode, pageNo:page, searchKey:searchKey, searchValue:searchValue}, function(data){
		var isLogin=data.isLogin;
		if(isLogin=="false") {
			location.href="<%=cp%>/member/login";
			return;
		}
		
		printNote(data);

	}, "JSON");
}

// 쪽지리스트에서 검색 하기 ------------- 
function searchListNote() {
	var mode=$("#mode").val();
	var searchKey=$("#noteSearchKey").val();
	var searchValue=$("#noteSearchValue").val();
	
	var url="<%=cp%>/note/listNote";
	$.post(url, {mode:mode, searchKey:searchKey, searchValue:searchValue}, function(data){
		var isLogin=data.isLogin;
		if(isLogin=="false") {
			location.href="<%=cp%>/member/login";
			return;
		}
		
		printNote(data);
	}, "JSON");
}

// 쪽지 리스트에서 선택된 쪽지 지우기 ------------- 
function deleteListNote() {
	var mode=$("#mode").val();
	var page=$("#pageNo").val();
	var searchKey=$("#searchKey").val();
	var searchValue=$("#searchValue").val();
	
    var chks = $("#tbListNote input:checked");
	var cnt = chks.length;
	if(cnt==0) {
		alert("삭제할 항목을 먼저 선택 하세요 !!!");
		return;
	}
    
	if(! confirm("선택한 자료를 삭제 하시겠습니까 ? "))
		return;

	$('#chkAll').attr("checked",false);
	
	var url="<%=cp%>/note/noteDeleteChk";
	var query="mode="+mode+"&pageNo="+page+"&searchKey="+searchKey+"&searchValue="+searchValue;
	$.each($(chks), function() {
		query += "&nums="+$(this).val();
	});
  	
    $.ajax({
    	type:"POST",
    	url:url,
    	data:query,
    	dataType:"JSON",
    	success:function(data){
    		var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/member/login";
				return;
			}
			
			printNote(data)
    	},
    	error:function(e) {
    		alert(e.responseText);
    	}
    });
}

//JSON - 쪽지 리스트 ------------- 
function printNote(data) {
	var mode=data.mode;
	var dataCount=data.dataCount;
	var page=data.pageNo;
	var searchKey=data.searchKey;
	var searchValue=data.searchValue;
	var paging=data.paging;
	
	$("#mode").val(mode);
	$("#pageNo").val(page);
	$("#searchKey").val(searchKey);
	$("#searchValue").val(searchValue);
	
	var out="";
	var s;
	
	if(dataCount!=0) {
		for(var idx=0; idx<data.list.length; idx++) {
			var num=data.list[idx].num;
			var userName;
			if(mode=="listSend")
				userName=data.list[idx].receiveUserName;
			else
				userName=data.list[idx].sendUserName;
			var content=data.list[idx].content;
			var sendDay=data.list[idx].sendDay;
			var identifyDay=data.list[idx].identifyDay;
			if(identifyDay=="")
				identifyDay="읽지않음";
			
			s="style='cursor: pointer;' onclick='articleNote(\""+num+"\");'";
			out+="<tr>";
			out+="  <td class='text-center'>";
			out+="     <input type='checkbox' value='"+num+"'>";
			out+="  </td>";
			out+="  <td class='text-center' "+s+">"+userName+"</td>";
			out+="  <td class='listContent' "+s+">"+content+"</td>";
			out+="  <td class='text-center' "+s+">"+sendDay+"</td>";
			out+="  <td class='text-center' "+s+">"+identifyDay+"</td>";
			out+="</tr>";
		}
	}
	
	$("#tbListNote").html(out);
	$("#notePaging").html(paging);
}

//삭제를 위한 체크버튼 전체 선택 및 전체 해제
$(function() {
	$('#chkAll').click(function() {
		if (this.checked) {
			$("#tbListNote input[type=checkbox]").each(function() { this.checked = true; });
		} else {
			$("#tbListNote input[type=checkbox]").each(function() { this.checked = false; });
		}
	});
});

//쪽지 글보기 -------------
function articleNote(num) {
	var mode=$("#mode").val();
	var page=$("#pageNo").val();
	var searchKey=$("#searchKey").val();
	var searchValue=$("#searchValue").val();
	
	var url="<%=cp%>/note/article";

	$.post(url, {num:num, mode:mode, pageNo:page, searchKey:searchKey, searchValue:searchValue}, function(data){
		var s=$.trim(data);
		if(s=="loginFail") {
			location.href="<%=cp%>/member/login";
			return;	
		}
		
		var id;
		if(mode=="listReceive") {
			id="#tabListReceive";
			$("#tabListSend").html("");
		} else {
			id="#tabListSend";
			$("#tabListReceive").html("");
		}
		$(id).html(data);
	});
}
</script>

<div>
        <div style="clear: both; height: 45px; line-height: 45px;">
            <div style="float: left;">
                 <button type="button" class="btn btn-default btn-sm" onclick="deleteListNote();">삭제</button>
            </div>
            <div style="float: right;">
        		     <form class="form-inline">
						  <select class="form-control input-sm" id="noteSearchKey">
<c:if test="${mode=='listSend'}">
						      <option value="receiveUserName" ${searchKey=="receiveUserName"?"selected='selected' ":"" }>받는사람</option>
						      <option value="receiveUserId" ${searchKey=="receiveUserId"?"selected='selected' ":"" }>아이디</option>
						      <option value="content" ${searchKey=="content"?"selected='selected' ":"" }>내용</option>
</c:if>         	     
<c:if test="${mode=='listReceive'}">
						      <option value="sendUserName" ${searchKey=="sendUserName"?"selected='selected' ":"" }>보낸사람</option>
						      <option value="sendUserId" ${searchKey=="sendUserId"?"selected='selected' ":"" }>아이디</option>
						      <option value="content" ${searchKey=="content"?"selected='selected' ":"" }>내용</option>
</c:if>         	     
						  </select>
						  <input type="text" class="form-control input-sm input-search" id="noteSearchValue" value="${searchValue}">
						  <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchListNote();"><span class="glyphicon glyphicon-search"></span> 검색</button>
        		     </form>
            
            </div>
        </div>

        <div class="table-responsive" style="clear: both;"> <!-- 테이블 반응형 -->
            <table class="table table-hover">
                <thead>
                    <tr>
<c:if test="${mode=='listSend'}">                        
                        <th class="text-center" style="width: 40px;">
                               <input type="checkbox" id="chkAll">
                        </th>
                        <th class="text-center" style="width: 80px;">받는사람</th>
                        <th >내용</th>
                        <th class="text-center" style="width: 100px;">보낸날짜</th>
                        <th class="text-center" style="width: 100px;">확인날짜</th>
</c:if>                        
<c:if test="${mode=='listReceive'}">                        
                        <th class="text-center" style="width: 40px;">
                               <input type="checkbox" id="chkAll">
                        </th>
                        <th class="text-center" style="width: 80px;">보낸사람</th>
                        <th >내용</th>
                        <th class="text-center" style="width: 100px;">받은날짜</th>
                        <th class="text-center" style="width: 100px;">확인날짜</th>
</c:if>                        
                    </tr>
                </thead>
                <tbody id="tbListNote"></tbody>
           </table>
       </div>
       
       <div id="notePaging" class="paging" style="text-align: center; min-height: 50px; line-height: 50px;"></div>        

</div>

<input type="hidden" id="mode" value="${mode}">
<input type="hidden" id="searchKey" value="${searchKey}">
<input type="hidden" id="searchValue" value="${searchValue}">
<input type="hidden" id="pageNo" value="${pageNo}">
