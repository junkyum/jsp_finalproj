<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>

<script type="text/javascript">
function sendMail() {

    var f = document.mailForm;
    var str;

   
	if(!isValidEmail(f.email.value)) {
        alert("정상적인 E-Mail을 입력하세요. ");
        f.email.focus();
        return false;
	}
    
	
	f.action = "<%=cp%>/mail/mail";
        	
    f.submit();
}
function sendMail2() {
    var f = document.mailForm2;
    var str;

 
	if(!isValidEmail(f.email.value)) {
        alert("정상적인 E-Mail을 입력하세요. ");
        f.receiverEmail.focus();
        return false;
	}
    
	
	f.action = "<%=cp%>/mail/mail2";
        	
    f.submit();
}
</script>
<script type="text/javascript">

function bgLabel(ob, id) {
       if(!ob.value) {
          document.getElementById(id).style.display="";
       } else {
          document.getElementById(id).style.display="none";
       }
}

function sendLogin() {
        var f = document.loginForm;

       var str = f.userId.value;
        if(!str) {
            f.userId.focus();
            return false;
        }

        str = f.userPW.value;
        if(!str) {
            f.userPW.focus();
            return false;
        }

        f.action = "<%=cp%>/member/login_check";
		f.submit();
	}

	
</script>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Login Form Template</title>

<!-- CSS -->
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
<link rel="stylesheet"
	href="<%=cp%>/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp%>/assets/css/form-elements.css">
<link rel="stylesheet" href="<%=cp%>/assets/css/style.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

<!-- Favicon and touch icons -->
<%-- <link rel="shortcut icon" href="<%=cp%>/assets/ico/favicon.png"> --%>
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="<%=cp%>/assets/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="<%=cp%>/assets/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="<%=cp%>/assets/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="<%=cp%>/assets/ico/apple-touch-icon-57-precomposed.png">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body>

	<!-- Top content -->
	<div class="top-content">

		<div class="inner-bg">
			<div class="container">
				<div class="row">
					<div class="col-sm-8 col-sm-offset-2 text"
						style="text-align: center">
						<h1>
							<strong>Schedule 바뀜? </strong>
						</h1>
						<div class="description">
							<p>스케쥴 홈페이지야 ㅎㅎ 언제바꾸ㅕ ㅎㅎ;</p>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3 form-box">
						<div class="form-top">
							<div class="form-top-left">
								<h3>Login to our site</h3>
								<p>Enter your ID and Password to log on:</p>
							</div>
							<div class="form-top-right">
								<i class="fa fa-lock"></i>
							</div>
						</div>
						<div class="form-bottom">
							<form class="form-signin" name="loginForm" method="post">
								<div class="form-group">
									<label for="userId" id="lblUserId" class="sr-only">아이디</label>
									<input type="text" id="userId" name="userId"
										placeholder="ID..." class="form-control loginTF"
										autofocus="autofocus"
										onfocus="document.getElementById('lblUserId').style.display='none';"
										onblur="bgLabel(this, 'lblUserId');">
								</div>
								<div class="form-group">
									<input type="password" id="userPW" name="userPW"
										placeholder="Password..." class="form-control loginTF"
										onfocus="document.getElementById('lblUserPW').style.display='none';"
										onblur="bgLabel(this, 'lblUserPW');">
								</div>
								<button class="btn" type="button" onclick="sendLogin();">
									로그인 <span class="glyphicon glyphicon-ok"></span>
								</button>


							</form>
						</div>
					</div>
				</div>
				<div style="margin-top: 10px; text-align: center;">
					<button type="button" class="btn btn-link"
						onclick="location.href='<%=cp%>/member/member';">회원가입</button>

					<button type="button" class="btn btn-default btn wbtn" id="btnpen"
						data-toggle="modal" data-target="#IdModal" data-mode="created">
					 아이디 찾기
					</button>

					<button type="button" class="btn btn-default btn wbtn" id="btnpen"
						data-toggle="modal" data-target="#PWModal" data-mode="created">
						 비밀번호 찾기
					</button>

					<div class="modal fade" id="IdModal" role="dialog">
						<form name="mailForm" method="post">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title">
											<span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;
										         이메일을 입력하세요
										</h4>
									</div>
									<div class="modal-body">

										
										<label class="col-sm-2 control-label" for="email">이메일</label>
										<input class="form-control"  name="email"
											type="text" placeholder="Email...">

						<input type="hidden" name= "mode" value="id"> 
										<br>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											 id="kmmodalCheck" onclick="sendMail();">
											<span class="glyphicon glyphicon-ok"></span>
										</button>
										<button type="button" class="btn btn-default"
											data-dismiss="modal">
											<span class="glyphicon glyphicon-remove"></span>
										</button>
									</div>
								</div>
							</div>






						</form>
					</div>
					<div class="modal fade" id="PWModal" role="dialog">
						<form name="mailForm2" method="post" enctype="multipart/form-data">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title">
											<span class="glyphicon glyphicon glyphicon-pencil"></span>&nbsp;
											아이디 / 이메일을 입력하세요
										</h4>
									</div>
									<div class="modal-body">

									<!-- 	<label class="col-sm-2 control-label" for="userId">아이디</label>
										<input class="form-control" id="userId" name="userId"
											type="text" placeholder="Id..." >
 -->
										<label class="col-sm-2 control-label" for="email">이메일</label>
										<input class="form-control"  name="email"
											type="text" placeholder="Email..." >


						<input type="hidden" name= "mode" value="pw">
										<br>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal" id="kmmodalCheck" onclick="sendMail2();">
											<span class="glyphicon glyphicon-ok"></span>
										</button>
										<button type="button" class="btn btn-default"
											data-dismiss="modal">
											<span class="glyphicon glyphicon-remove"></span>
										</button>
									</div>
								</div>
							</div>






						</form>
					</div>
					<div class="form-group"
						style="margin-top: 10px; text-align: center;">${message}</div>

				</div>


				<div class="row">
					<div class="col-sm-6 col-sm-offset-3 social-login">
						<h3>...or login with:</h3>
						<div class="social-login-buttons" style="text-align: center">
							<a class="btn btn-link-2" href="#"> <i class="fa fa-facebook"></i>
								Facebook
							</a> <a class="btn btn-link-2" href="#"> <i class="fa fa-twitter"></i>
								Twitter
							</a> <a class="btn btn-link-2" href="#"> <i
								class="fa fa-google-plus"></i> Google Plus
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>





	<!-- Javascript -->
	<%--  <script src="<%=cp%>/res/assets/js/jquery-1.11.1.min.js"></script>
        <script src="<%=cp%>/res/assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="<%=cp%>/res/assets/js/jquery.backstretch.min.js"></script>
        <script src="<%=cp%>/res/assets/js/scripts.js"></script>
         --%>


</body>

</html>