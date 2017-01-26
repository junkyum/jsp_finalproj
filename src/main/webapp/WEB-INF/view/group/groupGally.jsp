<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.file-box { /* 파일이 들어가는 크기 */
   float: left; /* 어디서 부터 정렬을 할것인지*/
}
/* 박스 크기 */
.file {
   border: 5px solid #e7eaec; /* 사진틀 보더 */
   background-color: #ffffff;
   position: relative;
   left: 100px; /* top,left 상좌우 조절 가능 */
   margin-right: 100px; /* 사진 끼리의 거리 */
   margin-top: 15px;
}

/* file@image의 크기  --  hidden속성@ scroll*/
.file .file-name {
   padding: 10px; /* 글들어가는 박스 크기 */
   background-color: #FFFFD7;
   border-top: 10px solid #e7eaec;
} /* 사진밑에 여백상태    small */
.file-name { /* 맨밑에글시색 */
   color: #676a6c;
   cursor: pointer;
   text-align: center;
}

.corner { /* 밑에 글나오는 것 상태 바꾸는거 */
   position: absolute;
   display: inline-block;
   border: 20px solid transparent;
   border-right: 20px solid #f1f1f1;
   border-bottom: 20px solid #f1f1f1;
   right: 10px;
   bottom: 10px;
}

a:hover {
   text-decoration: none;
}
h4{
    margin: 0px; 
   margin-top: 5px;
}
</style>


<script type="text/javascript">
/* function article(num) {
   var url="${articleUrl}&num="+num;
   location.href=url;
} */
/* 검색을 할떄 id@clss 에 2가지의 정보를 담는다${ㅅ} */

$(function(){
   $(".onePoto").click(function() {
         $(".twoPhoto").dialog({
            title:"사진(제목)",
            modal:true,
            width:880,
            height:700
         });
      });
});


$(function(){
   $(".chk").click(function() {
         $(".chk2").dialog({
            title:"등록하기",
            modal:true,
            width:500,
            height:500
             
         });
      });
   
   
   
   
   $("#btn").click(function(){
      $("#span1").hide();
      $("#span2").hide();
      if(!$("#subject").val()){
         $("#subject").focus();
         $("#span1").show();
         return false;
      }
      
      if(!$("#content").val()){
         $("#content").focus();
         $("#span2").show();
         return false;
      }
      
      return true;
      
   });
   
});

//////////////////////////////////////////////////////


   
   

</script>
</head>
<body>

   <div
      style="margin: 50px auto; width: 1000px; height: 700px; border: 1px solid red; ">
      <div>
         <div style="clear: both;">
            <div style="float: left; width: 20%; min-width: 85px;">&nbsp;
            </div>
            <div style="float: left; width: 60%; text-align: center;">
               <h3 class="h">개시판이야 망나니야</h3></div>
            <div style="float: left; width: 20%; min-width: 85px; text-align: right;">
            
               <div class="chk"><!-- 버튼이 들어가있는  div -->
                  <button type="button"
                     style="background: blue;">
                     <img src="<%=cp%>/image/btn.png"
                        style="width: 50px; height: 50px; position: relative; top: 10pk;">
                     <div>등록하기</div>
                  </button>
               </div>
            
            </div>
         </div>
      </div>

         <!-- 여기서 부터 리스트로 사진 뽑기 리스트로  -->
      <div class="file-box">
         <!-- 1 -->
         <div class="file">
            <span class="corner"></span>
            <div class="onePoto">
               <img class="img-responsive" src="<%=cp%>/image/a.jpg"
                  style="width: 190px; height: 190px;" border="0">
            </div>
            <div class="file-name">
               <span class="file-name"> 재목 </span> <br> <small>몰라요</small>
            </div>
         </div>
      </div>
      <!-- 1 -->

      <div class="file-box">
         <!-- 2 -->
         <div class="file">
            <span class="corner"></span>
            <div class="a">
               <img class="img-responsive" src="<%=cp%>/image/a.jpg"
                  style="width: 190px; height: 190px;" border="0">
            </div>
            <div class="file-name">
               <span class="file-name">
                  재목 </span> <br> <small>몰라요</small>
            </div>

         </div>
      </div>


      <div class="file-box">
         <!-- 2 -->
         <div class="file">
            <span class="corner"></span>

            <div class="a">
               <img class="img-responsive" src="<%=cp%>/image/a.jpg"
                  style="width: 190px; height: 190px;" border="0">
            </div>
            <div class="file-name">
               <span class="file-name" >
                  재목 </span> <br> <small>몰라요</small>
            </div>

         </div>
      </div>

      <!-- .///////////////////////////////////// -->
      <div style="clear: both; margin: auto;"></div>
      <!-- .///////////////////////////////////// -->
      <div class="file-box">
         <!-- 1 -->
         <div class="file">
            <span class="corner"></span>

            <div class="a">
               <img class="img-responsive" src="<%=cp%>/image/b.jpg"
                  style="width: 190px; height: 190px;" border="0">
            </div>

            <div class="file-name">
               <span class="file-name" >
                  재목 </span> <br> <small>몰라요</small>
            </div>
         </div>
      </div>
      <!-- 1 -->

      <div class="file-box">
         <!-- 2 -->
         <div class="file">
            <span class="corner"></span>

            <div class="a">
               <img class="img-responsive" src="<%=cp%>/image/b.jpg"
                  style="width: 190px; height: 190px;" border="0">
            </div>
            <div class="file-name">
               <span class="file-name" onclick="javascript:article('#');">
                  재목 </span> <br> <small>몰라요</small>
            </div>

         </div>
      </div>


      <div class="file-box">
         <!-- 2 -->
         <div class="file">
            <span class="corner"></span>

            <div class="a">
               <img class="img-responsive" src="<%=cp%>/image/b.jpg"
                  style="width: 190px; height: 190px;" border="0">
            </div>
            <div class="file-name">
               <span class="file-name">
                  재목 </span> <br> <small>몰라요</small>
            </div>

         </div>
      </div>


      <div style="clear: both; margin: auto;"></div>
      <div style="margin: 15px auto; width: 20%; text-align: center; border: 1px solid black; ">
         1,2,3,4,5 페이징 할꺼야</div>
   </div>




   <!-- dto.num을 주고   style="display:none;  싸이즈 500@ 500 
      리스트로 뽑으면서 이미지 뽑아주는에   밑에꺼도  list에서 포문돌려서 출력
   --> 
   <div class="twoPhoto" id="" style="display: none; padding:0px; margin: 0px; width: 500px; height: 500px;">
   
         <div style="width: 870px; height: 350px; border: 1px solid black; margin: 0px;">
            <!-- 사진 -->
            <div style=" width: 860px; height: 340px; margin-top:5px; margin-left: 5px">
               <img class="img-responsive" src="<%=cp%>/image/a.jpg"
               style="width: 860px; height: 340px;" border="0">
            </div>   
         </div>
         
         <div style="float: left; margin-left: 20px; margin-top: 10px;">
               <span>작성자 </span>
                <div style="border: 1px solid black; margin-top: 10px;">
                   좋아요수
                </div>
               <div style="width: 200px; height: 20px; border: 1px solid black; margin-top: 35px; margin-right: 30px; ">
                  <span> 이름:dddd </span>
               </div>
               <div style="width: 200px; height: 30px; border: 1px solid black; margin-top: 15px; margin-right: 30px; ">
                  <span> 올린시간 : 올린시간 </span>
               </div>
               
               <div style="margin-top: 30px; margin-right: 30px;">                    
                       <button type="button" onclick="">수정</button>  
                       
                       <button type="button"  onclick="">삭제</button> 
                       
                       <button type="button" onclick="">리스트가기</button>
                       
                  </div>          
                 
         </div> 
   
      
      <div style="width: 570px; height: 280px;float: left; margin-left: 20px; margin-top: 10px; margin-right: 0px;">
      
         <div style="width: 570px; height: 150px; border: 1px solid black;">
            <h3 style="margin:auto; margin-top: 0px; border: 2px solid pink;">내용</h3>
            <span> 뭘까여~~~~~~~~~~~</span>
         </div>
      
         <div style="width: 570px; height: 130px; border: 1px solid black;">
            <h3 style="margin:auto; ; margin-top: 0px; border: 3px solid pink;">내용<button type="button" style="float: right;">리플등록</button></h3>
            <span> 뭘까여~~~~~~~~~~~</span>
         </div>
            
      </div>
   
   
   
   
   
   
</div>
   
   
   
   
   
   
   <!-- 내용@ 이미지 @재목 <input type="text" name="subject" id="subject">   -->
   
   <form method="post" name="put" id="put">
      <div class="chk2" id="chk2" style="display: none; padding:0px; margin: 0px; width: 500px; height: 500px;">
      
            <div style="height: 300px; width: 480px; border: 1px solid black;">
               <h3 style="margin-top: 10px; margin-left: 220px;">그룹명</h3>
               <div style="width: 200px; height: 50px; margin-left: 30px; background: red;">
                  작성자명: 누굴까요?
               </div>
                  <div style="margin-top: 10px;">
                     <h4 style="float: left; margin: 0px;">재 목 :&nbsp;</h4>
                     <input type="text" name="subject" id="subject" value="" placeholder="내용을 입력하세요" style="clear: both;">
                     <span id="span1" style="display: none;">내용좀 입력하세요</span>
                  </div>
                  
                  <div>
                     <h4>내 용 : <span style="display: none;" id="span2">내용좀 입력하세요</span></h4> 
                     <textarea rows="5" name="content"  required="required" style="width: 300px; height: 100px;"></textarea>
                  </div>
                  
               
            </div>
            <!-- -------------------------------------------------- -->
            
            <div style="margin: 0px;margin-left : 40px; margin-top: 10px; width: 300px; height: 50px; border: 1px solid black;" >
               <input type="file" name="upload" id="upload">
            </div>
            
            <div style="margin-left: 100px; margin-top: 20px; float: right; " >
               <button type="button" id="btn" name="btn" >등록하기</button>
            </div>     
      </div>
   </form>


</body>
</html>