<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.bs-write table {
    width: 100%;
    border: 0;
    border-spacing: 0;
}
.table tbody tr td {
    border-top: none;
    font-weight: normal;
	font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
} 
.bs-write table td {
	padding: 3px 3px 3px 3px;
}

.bs-write .td1 {
    min-width: 100px;
    min-height: 30px;
    color: #666;
    vertical-align: middle;
}

.bs-write .td2 {
}

.bs-write .td3 {
}

.bs-write .td4 {
}

#categoryList{
	width:160px;
	height:190px;	
	border:0px;
	text-align:left;
	padding:5px;
	padding-top:0px;
	overflow-y:scroll;
    border:1px solid #ccc;
}
</style>

<script type="text/javascript">
  function check() {
        var f = document.faqForm;

    	str = f.categoryNum.value;
        if(!str) {
            f.categoryNum.focus();
            return false;
        }
        
    	var str = f.subject.value;
        if(!str) {
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            f.content.focus();
            return false;
        }

        var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/tfaq/created";
    	else if(mode=="update")
    		f.action="<%=cp%>/tfaq/update";

        return true;
 }
  
 //--------------------------------------
 // 카테고리 리스트
 function categoryList() {
	var url="<%=cp%>/tfaq/categoryList";
	var now = new Date();
	var query = "tem="+now.getTime();
	
	var categoryNum ="${dto.categoryNum}";
	if(categoryNum=="")
		categoryNum="0";
	
	
	$.ajax({
		type:"POST",
		url:url,
		data:query,
		dataType:"json",
		success: function (data) {
		$("#selectCategory option").each(function () {
			$("#selectCategory option:eq(0)").remove();
		});
		
		for (var idx=0; idx<data.list.length;idx++){
			var num=data.list[idx].categoryNum;
			var classify=data.list[idx].classify;
			var selected="";
			if(categoryNum==num)
				selected="selected='selected'";
			
			$("#selectCategory").append("<option value='"+num+"' "+selected+">"+classify+"</option>");
		}
		},
		error: function (e) {
			alert(e.responseText)
		}
		
	});
	
}
 
 function categoryAdd() {
	var url= "<%=cp%>/tfaq/categoryList";
	var now = new Date();
	var query="tmp="+now.getTime();
	
	$.ajax({
		
		type:"POST",
		url:url,
		data:query,
		dataType:'json',
		success : function (data) {
			var out = parseCategory(data);
			$("#categoryList").html(out);
		},
		error:function(e){
			alert(e.responseText)
		}
	
	});
	 $("#classify").val("");
	 $('#categoryModal').modal('show');
	
}
 
 function parseCategory(data) {
	var values="";
	
	for(var idx=0; idx<data.list.length;idx++){
		var categoryNum= data.list[idx].categoryNum;
		var classify=data.list[idx].classify;
		
		var sid ="s"+categoryNum;
		var str = "<span id= '"+sid+"'><a href='javascript:deleteCategory("+categoryNum+");'>";
		str+="<img src='<%=cp%>/res/images/icon-minus.png'border='0'></a>&nbsp;";
		str+=classify+"</span><br>";
		
		values+=str;
	}
	return values;
}
 
 function sendCategory() {
		var classify =$.trim($("#classify").val());
		if(!classify){
			alert("추가할 카테고리를 입력 하세요");
			return;
		}
		var url= "<%=cp%>/tfaq/categoryCreated";
		var query ="classify="+classify;
	
		
		$.ajax({
			type:"POST",
			url:url,
			data:query,
			dataType:'json',
			success: function (data) {
				var state=data.state;

				if(state=="false"){
					alert("카테고리는 최대 10개 까지 가능");
				}
				else{
					$("#classify").val("");
					categoryList();
				}
				
				var out = parseCategory(data);
				$("#categoryList").html(out);
			},
			error : function (e) {
				alert(e.responseText);
			} 
		});
		
}
 
 function deleteCategory(categoryNum) {
	
	 var url ="<%=cp%>/tfaq/deleteCategory";
	 var query = "categoryNum="+categoryNum;
	
	 
	 if(!confirm("삭제하시겠습니까?"))
	 	return;
	 
	 $.ajax({
		
		type:"POST",
		url:url, 
		data:query,
		dataType:'json',
		success : function (data) {
			var state = data.state;
			
			if(state=="false"){
				alert("해당 카테고리는 사용중입니다.");
			    }
				else{
					categoryList();
				}
				var out = parseCategory(data);
				$("#categoryList").html(out);
			},
			error:function(e){
				alert(e.responseText);
			}
      });
}
 
 
</script>

<div class="bodyFrame2" style="margin: 0 auto; margin-top: 80px; width: 700px">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-question-sign"></span> 자주하는 질문 </h3>
    </div>
    
    <div>
        <form name="faqForm" method="post" onsubmit="return check();">
            <div class="bs-write">
                <table class="table">
                    <tbody>
                        <tr>
                            <td class="td1">작성자명</td>
                            <td class="td2 col-md-5 col-sm-5">
                                <p class="form-control-static">${sessionScope.member.userName}</p>
                            </td>
                            <td class="td1" align="center"></td>
                            <td class="td2 col-md-5 col-sm-5">
                            </td>
                        </tr>

                        <tr>
                            <td class="td1">카테고리</td>
                            <td colspan="3" class="td3">
                                <div class="form-inline">
                                    <select name="categoryNum" class="form-control" id="selectCategory" style="min-width: 150px;">
                                        <c:forEach var="vo" items="${listCategory}">
                                            <option value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum ? "selected='selected'" : ""}>${vo.classify}</option>
                                        </c:forEach>
                                    </select>
                                    <button type="button" class="btn btn-default btn-sm" onclick="categoryAdd();">카테고리추가</button>
                                </div>                                
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1">제목</td>
                            <td colspan="3" class="td3">
                                <input type="text" name="subject" class="form-control input-sm" value="${dto.subject}" required="required">
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1" colspan="4" style="padding-bottom: 0px;">내용</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="td4">
                            	<textarea name="content" class="form-control" rows="15" required="required">${dto.content}</textarea>
                            </td>
                        </tr>
                    </tbody>
                    
                    <tfoot>
                        <tr>
                            <td colspan="4" style="text-align: center; padding-top: 15px;">
                                  <button type="submit" class="btn btn-default btn-sm wbtn"> 확인 <span class="glyphicon glyphicon-ok"></span></button>
                                  <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tfaq/faq?category=${category}';"> 취소 </button>
                                  
                                  <c:if test="${mode=='update'}">
                                      <input type="hidden" name="num" value="${dto.num}">
                                      <input type="hidden" name="pageNo" value="${pageNo}">
                                  </c:if>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </form>
    </div>
</div>


<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content modal-sm"  style="min-width: 400px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="categoryModalLabel" style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">FAQ 카테고리</h4>
      </div>
      <div class="modal-body">
          <div class="alert alert-danger">
                 <i class="glyphicon glyphicon-info-sign"></i> 카테고리는 최대 10개 까지 등록가능 합니다.
          </div>
          <div style="clear: both; height: 200px;">
                <div style="float: left; width: 180px;">
                     <form>
			             <div class="form-group">
			                 <input class="form-control" id="classify" type="text" placeholder="카테고리">
			             </div>
			             <div class="form-group">
			                 <button class="btn btn-sm btn-default btn-block" type="button" onclick="sendCategory();"> 등록 </button>
                          </div>
                    </form>
                </div>
                <div style="float: right;">
                     <div id="categoryList"></div>
                </div>
          </div>
          
      </div>
    </div>
  </div>
</div>

