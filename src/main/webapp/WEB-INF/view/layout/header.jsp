<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   
    <div class="navbar navbar-default navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-ex-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="<%=cp%>/"><span>여기다는 이미지 밖는건 어떠신가요? 마크라든가 
            <i class="et-down et-down fa fa-angellist"></i> </span>
            </a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-ex-collapse">
          <ul class="lead nav navbar-nav navbar-right">
            <%-- <li class="active">
              <a href="<%=cp%>/notice/notice">공지사항</a>
            </li> --%>
              <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
              aria-expanded="false">고객센터 <i class="et-down et-down fa fa-angle-down"></i></a>
              <ul class="dropdown-menu" role="menu">
                <li>
                  <a href="#">공지사항</a>
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
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
              aria-expanded="false">스케줄 <i class="et-down et-down fa fa-angle-down"></i></a>
              <ul class="dropdown-menu" role="menu">
                <li>
                  <a href="#">개인</a>
                </li>
                <li>
                  <a href="#">그룹</a>
                </li>
                <li>
                  <a href="#">휴지통</a>
                </li>
              </ul>
            </li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
              aria-expanded="false">갤러리 <i class="et-down et-down fa fa-angle-down"></i></a>
              <ul class="dropdown-menu" role="menu">
                <li>
                  <a href="#">개인</a>
                </li>
                <li>
                  <a href="#">그룹</a>
                </li>
                <li>
                  <a href="#">휴지통</a>
                </li>
              </ul>
            </li>
            <li class="">
              <a href="#">지도 </a>
            </li>
            
            <li class="">
              <a href="#"> ${sessionScope.member.userName}님 
               </a>
            </li>
            <li>
               <a href="<%=cp%>/member/logout"> 
                   로그아웃
                  </a> 
            </li>
          </ul>
        </div>
      </div>
    </div>