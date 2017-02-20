<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.bodyFrame2{
    width: 825px;
    min-height: 600px;
    margin-top: 0px;

    margin: 0 auto;
}
.imgLayout{
	width: 200px;
	height: 230px;
	padding: 5px 5px 5px;
	margin: 5px;
	border: 1px solid #DAD9FF;
	float: left;
}

.subject {
     width:130px;
     height:25px;
     line-height:25px;
     margin:5px auto 0px;
     border-top: 1px solid #DAD9FF;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
     text-align: center;
}
#zoom_img {text-align:center; margin-bottom:15px; }
.thumb {overflow:hidden;float: left; text-align:center;   margin: 0 auto; margin-left: 15px; } 
.thumb div {margin: 0 auto;width: 150px; }
.thumb div a {border:1px solid #555; overflow:hidden; }
.thumb div a,
.thumb div a img {width:150px; height:100px; display:block;}
.thumb div.on a {border:2px solid #a52323; width:148px; height:98px;}
.thumb div.on a img {margin:-1px 0 0 -1px;}

</style>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>


<script type="text/javascript">
function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/tphoto/list";
		f.submit();
}

function article(num) {
	var url="${urlArticle}&num="+num;
	location.href=url;
}

</script> 
<script type="text/javascript">
$(function() {
	

$( ".thumb div a" ).click(function() {
    var address = $(this).children("img");
    $("#zoom_img img").attr("src",address.attr("src")).attr("alt",address.attr("alt"));
    $(this).parent().addClass("on").siblings().removeClass("on");
    return false;
});

});

</script>

<div class="bodyFrame2" style="margin: 0px auto 20px;">
   <div class="body-title" style="text-align: center; margin-top: 50px; margin-bottom: 50px">
          <h3><span class=""></span>   PORTFOLIO
</h3>
    </div>   
      <div id="zoom_img" ><img src="http://www.tonilatour.com/wp-content/uploads/2015/02/Hello1.jpg" style="width: 680px; height: 500px"></div>
          <c:forEach var="dto" items="${list}" varStatus="status">
       <div class="thumb">
    <div class="on" style="margin-top: 20px">
      <a href="#"><img src="<%=cp%>/uploads/tphoto/${dto.imageFilename}" ></a> 
          <span class="subject" onclick="javascript:article('${dto.num}');" >
			                   ${dto.subject}<span class="glyphicon glyphicon-eye-open" style="float: right;    margin:3px 3px ;
 ">${dto.hitCount}</span><span class="glyphicon glyphicon-thumbs-up" style="float: right;   margin:3px 3px ; ">${dto.tlikeCount}</span>
	    </span> 
    </div>
   </div>
   </c:forEach>

        
        <div class="paging" style="clear:both; text-align: center; min-height: 50px; line-height: 50px; margin-bottom: 30px">
            <c:if test="${dataCount==0 }">
                  등록된 게시물이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
        </div>        
        
        <div style="clear: both; margin-bottom:100px ">
        		<div style="float: left; width: 20%; min-width: 85px; ">
        		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tphoto/list';">새로고침</button>
        		</div>
        		<div style="float: left; width: 60%; text-align: center;">
        		     <form name="searchForm" method="post" class="form-inline">
						  <select class="form-control input-sm" name="searchKey" >
						      <option value="subject">제목</option>
						      <option value="userName">작성자</option>
						      <option value="content">내용</option>
						      <option value="created">등록일</option>
						  </select>
						  <input type="text" class="form-control input-sm input-search" name="searchValue">
						  <button type="button" class="btn btn-default btn-sm wbtn" onclick="searchList();"><span class="glyphicon glyphicon-search"></span> 검색</button>
        		     </form>
        		</div>
        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
        		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/tphoto/created';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 등록하기</button>
        		</div>
        </div>
        
    </div>
    
</div>