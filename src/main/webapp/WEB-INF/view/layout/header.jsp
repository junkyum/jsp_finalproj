<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- class="navbar navbar-default" -->
<!-- class="navbar navbar-light" style="background-color: #e3f2fd;" -->
   <nav class="navbar navbar-inverse bg-inverse" style="background-color: #e3f2fd;" role="navigation">
 
 <div class="navbar-header">
 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
 <span class="sr-only">Toggle navigation</span>
 <span class="icon-bar"></span>
 <span class="icon-bar"></span>
 <span class="icon-bar"></span>
 </button>
 <a class="navbar-brand" href="<%=cp%>/"> 우리의 프로젝트입니다 다나가주세요</a>
 </div>
 
 <div class="collapse navbar-collapse navbar-ex1-collapse">
 

 
 <ul class="nav navbar-nav navbar-right">

 
              <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
              >고객센터 <b class="caret"></b></a>
              <ul class="dropdown-menu" role="menu">
                <li>
                  <a href="<%=cp%>/tnotice/list">공지사항</a>
                </li>
                <li>
                  <a href="#">fAQ</a>
                </li>
                <li>
                  <a href="#">QNA</a>
                </li>
              </ul>
            </li>
          
            
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">스케줄 <b class="caret"></b></a>
              <ul class="dropdown-menu" role="menu">
                <li>
                  <a href="#"> 개인 </a>
                </li>
                <li>
                  <a href="#">그룹</a>
                </li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">갤러리 <b class="caret"></b></a>
              <ul class="dropdown-menu" role="menu">
                <li>
                  <a href="<%=cp%>/tphoto/list">자유 갤러리 </a>
                </li>
                <li>
                  <a href="#">그룹</a>
                </li>
                     <li role="separator" class="divider"></li>
           
                <li>
                
                  <a href="#">개인 사진첩</a>
                </li>
              </ul>
            </li>
            <li class="">
              <a href="#">지도 </a>
            </li>
            
            <li class="">
              <a href="#"> ${sessionScope.member.userName}님 
               </a>
               
                <c:if test="${not empty sessionScope.member}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">마이페이지<span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="<%=cp%>/member/info">정보확인</a></li>
                                    <li><a href="#">다이어리</a></li>
                                    <li><a href="#">일정관리</a></li>
                                    <li><a href="#">친구관리</a></li>
                                    <li><a href="#">쪽지</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="<%=cp%>/member/pwd">정보수정</a></li>
                                    <c:if test="${sessionScope.member.userId!='admin'}">
                                        <li><a href="<%=cp%>/member/pwd?dropout">회원탈퇴</a></li>
                                    </c:if>
                                </ul>
                            </li>
                        </c:if>
            </li>
            <li>
               <a href="<%=cp%>/member/logout"> 
                   로그아웃
                  </a> 
            </li>
 
 </ul>
 
 </div>
 
</nav>