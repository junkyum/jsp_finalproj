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

<nav class="navbar" style="margin: 0; background-color: #333; height: 5%;" role="navigation">
 <div class="navbar-header">
 <a href="<%=cp%>/"><img src="<%=cp%>/res/images/home.png" style="width: 50px;"></a>
 </div>
 <div class="collapse navbar-collapse navbar-ex1-collapse">
 <ul class="nav navbar-nav navbar-right">
             <li>
              <a href="#"> ${sessionScope.member.userName}님</a>
                <c:if test="${not empty sessionScope.member}">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">마이페이지<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=cp%>/member/info">정보확인</a></li>
                            <li><a href="<%=cp%>/friend/friend">친구관리</a></li>
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
              <a href="<%=cp%>/sch/sch">스케줄 </a>
            </li>
            <li>
              <a href="<%=cp%>/tphoto/list">갤러리 </a>
            </li>
            <li>
              <a href="<%=cp%>/map">지도 </a>
            </li>
            <c:if test="${myList!=null}">
            <li class="dropdown">
			  <a href="#" class="dropdown-toggle" data-toggle="dropdown">내그룹목록</a>
			  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
				<c:forEach var="vo" items="${myList}">
			    <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:location.href='<%=cp%>/group?groupName=${vo.groupName}';">
			    ${vo.groupName }</a></li>
				</c:forEach>
			  </ul>
			</li>
            </c:if>
             <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
              >고객센터 <b class="caret"></b></a>
              <ul class="dropdown-menu" role="menu">
                <li>
                  <a href="<%=cp%>/tnotice/list">공지사항</a>
                </li>
                <li>
                  <a href="<%=cp%>/tfaq/faq">FAQ</a>
                </li>
                <li>
                  <a href="<%=cp%>/tqna/list">QnA</a>
                </li>
              </ul>
            </li>
            <li><a href="<%=cp%>/member/logout">로그아웃</a> 
            </li>
 </ul>
 </div>
 
</nav> 