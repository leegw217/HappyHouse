<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>house info list</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="">
<meta name="description" content="">
<meta name="keywords" content="">

<link rel="stylesheet" href="${root}/resources/css/reset.css">
<link rel="stylesheet" href="${root}/resources/css/style.css">
<link rel="stylesheet" href="${root}/resources/css/custom.css">
<link rel="stylesheet" href="${root}/resources/css/jquery.fullpage.css">
<script src="${root}/resources/js/jquery.fullpage.js"></script>

<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<style>
@media screen and (min-width: 768px) {
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$('#btn-sidebar-second').on('click', function(){
            $('#overlay').addClass('active');
            $('#sidebar').addClass('active');
        });
        
        $('#sidebar').on('click', function(e){
            if(e.target.className == 'cont'){
                $('#overlay').removeClass('active');
                $('#sidebar').removeClass('active');
            }
        });
	});
	</script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"
	charset="utf-8"></script>
<script>
	Kakao.init('e6da250c7aded388de64035be3b36ec1');
</script>
<style>
.innermain {
	margin-top: 50px;
	color: #6a6f8c;
	font: 600 16px/18px 'Open Sans', sans-serif;
}

*, :after, :before {
	box-sizing: border-box
}

.clearfix:after, .clearfix:before {
	content: '';
	display: table
}

.clearfix:after {
	clear: both;
	display: block
}

.login_a {
	color: inherit;
	text-decoration: none
}

input {
	text-align: center
}

.login-wrap {
	width: 100%;
	margin: auto;
	max-width: 525px;
	min-height: 610px;
	position: relative;
	box-shadow: 0 12px 15px 0 rgba(0, 0, 0, .24), 0 17px 50px 0
		rgba(0, 0, 0, .19);
}

.login-html {
	width: 100%;
	height: 100%;
	position: absolute;
	padding: 30px 70px 0px 70px;
	background: rgba(40, 57, 101, .9);
	text-align: center;
}

.login-html .sign-in-htm, .login-html .sign-up-htm {
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	position: absolute;
	transform: rotateY(180deg);
	backface-visibility: hidden;
	transition: all .4s linear;
}

.login-html .sign-in, .login-html .sign-up, .login-form .group .check {
	display: none;
}

.login-html .tab, .login-form .group .label, .login-form .group .button
	{
	text-transform: uppercase;
}

.login-html .tab {
	font-size: 22px;
	margin-right: 15px;
	padding-bottom: 5px;
	margin: 0 15px 20px 0;
	display: inline-block;
	border-bottom: 2px solid transparent;
}

.login-html .sign-in:checked+.tab, .login-html .sign-up:checked+.tab {
	color: #fff;
	border-color: #1161ee;
}

.login-form {
	min-height: 345px;
	position: relative;
	perspective: 1000px;
	transform-style: preserve-3d;
}

.login-form .group {
	margin-bottom: 15px;
}

.login-form .group .label, .login-form .group .input, .login-form .group .button
	{
	width: 100%;
	color: #fff;
	display: block;
}

.login-form .group .input, .login-form .group .button {
	border: none;
	padding: 15px 20px;
	border-radius: 25px;
	background: rgba(255, 255, 255, .1);
}

.login-form .group input[data-type="password"] {
	text-security: circle;
	-webkit-text-security: circle;
}

.login-form .group .label {
	color: #aaa;
	font-size: 12px;
	text-align:center;
	margin-bottom: 5px;
}

.login-form .group .button {
	background: #1161ee;
}

.login-form .group label .icon {
	width: 15px;
	height: 15px;
	border-radius: 2px;
	position: relative;
	display: inline-block;
	background: rgba(255, 255, 255, .1);
}

.login-form .group label .icon:before, .login-form .group label .icon:after
	{
	content: '';
	width: 10px;
	height: 2px;
	background: #fff;
	position: absolute;
	transition: all .2s ease-in-out 0s;
}

.login-form .group label .icon:before {
	left: 3px;
	width: 5px;
	bottom: 6px;
	transform: scale(0) rotate(0);
}

.login-form .group label .icon:after {
	top: 6px;
	right: 0;
	transform: scale(0) rotate(0);
}

.login-form .group .check:checked+label {
	color: #fff;
}

.login-form .group .check:checked+label .icon {
	background: #1161ee;
}

.login-form .group .check:checked+label .icon:before {
	transform: scale(1) rotate(45deg);
}

.login-form .group .check:checked+label .icon:after {
	transform: scale(1) rotate(-45deg);
}

.login-html .sign-in:checked+.tab+.sign-up+.tab+.login-form .sign-in-htm
	{
	transform: rotate(0);
}

.login-html .sign-up:checked+.tab+.login-form .sign-up-htm {
	transform: rotate(0);
}

.hr {
	height: 2px;
	margin: 30px 0 30px 0;
	background: rgba(255, 255, 255, .2);
}

.foot-lnk {
	margin-top: 25px;
	text-align: center;
}

#modal {
	display: none;
	position: fixed;
	top: 80px;
	left: 585px;
	width: 100%;
	z-index: 10;
}

#modal .modal_content {
	position: fixed;
	color: black;
	width: 400px;
	margin: 100px auto;
	padding: 20px 10px;
	background: #ffff;
	border-radius: 10px;
	z-index: 2;
}

#modal .modal_layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 1;
}

.modalBtn {
	border-radius: 3px; 
	border: 0px; 
	background: #6ea0bb; 
	width: 50px; 
	margin: 20px 20px 10px 20px
}

.findpw_input {
	padding: 0;
	border: 1px solid black;
	boarder-radius: 20px;
	text-align: center;
	width: 250px;
	height: 30px;
	margin-bottom: 10px;
}

.findpw_div {
	margin-bottom: 10px;
}
</style>
<script type="text/javascript">
	if('${loginState}' == '네이버 로그인 성공') {
		opener.document.location.href='/happyhouse';
		self.close();
	}
	function clear() {
		$('input').val() = '';
	}
</script>
</head>
<body>
<div id="wrap">
	<!-- 오버레이 처리 -->
	<div id="overlay"></div>

	<!-- 사이드바 -->
	<div id="sidebar">
		<%@include file="/WEB-INF/views/layout/navibar.jsp"%>
	</div>

	<div id="btn-sidebar-second">
		<i class="xi-bars"></i>
	</div>
	<div style="text-ailgn:center">
	<div class="innermain" style="background:#c6e4e4;">
	<div class="card-body">
		<div class="login-wrap">
			<!-- 모달 -->
			<div id="modal">
				<div class="modal_content">
				<div style="padding: 1% 1% 1% 1%; text-align:center">
				<form method="get" id="searchForm">
					<div class="findpw_div"><label for="id">ID</label></div>
					<div><input class="findpw_input" type="text" name="id" id="fid"></div>
					<div class="findpw_div"><label for="name">NAME</label></div>
					<div><input class="findpw_input" type="text" name="name" id="fname"></div>
					<div class="findpw_div"><label for="email">EMAIL</label></div>
					<div><input class="findpw_input" type="text" name="email" id="femail"></div>
		        </form>
				</div>
					<div style="padding: 1% 20% 1% 25%">
					<button type="button" class="modalBtn" id="modal_find">찾기</button>
					<button type="button" class="modalBtn" id="modal_close">취소</button>
					</div>
				</div>
				<div class="modal_layer"></div>
			</div>
			<!-- 로그인 폼 -->
			<div class="login-html">
				<input id="tab-1" type="radio" name="tab" class="sign-in" checked>
				<label for="tab-1" class="tab">Sign In</label>
				<input id="tab-2" type="radio" name="tab" class="sign-up">
				<label for="tab-2" class="tab">Sign Up</label>
				<div class="login-form">
					<div class="sign-in-htm">
						<form method="post" action="${root}/login/login" id="loginForm">
							<div class="group">
								<label for="id" class="label">ID</label>
								<input id="id" name="id" type="text" style="text-align: center" class="input">
							</div>
							<div class="group">
								<label for="pw" class="label">Password</label>
								<input id="pw" type="password" name="pw" style="text-align: center" class="input" data-type="password">
							</div>
							<div class="group">
								<input type="button" id="loginBtn" style="margin-top: 40px" class="button" value="Sign In">
							</div>
						</form>
						<div class="foot-lnk">
							<a class="login_a" id="findpwBtn" href='#'>Forgot Password?</a>
						</div>
						<div class="hr"></div>
						<div class="group">
							<input type="button" id="naverLogin" style="margin-top: 20px; background: #1EC800; color: white; font-weight: bold;" class="button" value="NAVER">
						</div>
						<div class="group">
							<input type="button" id="kakaoLogin" style="margin-top: 20px; background: #FEE500; color: black; font-weight: bold;" class="button" value="KAKAO">
						</div>
					</div>
					<div class="sign-up-htm">
						<form style="text-align: center;" method="post" action="${root}/user/join" id="joinForm">
							<div class="group">
								<label for="joinid" class="label">id</label>
								<input id="joinid" name="id" type="text" class="input">
							</div>
							<div class="group">
								<label for="joinpw" class="label">Password</label>
								<input id="joinpw" type="password" name="pw" class="input" data-type="password">
							</div>
							<div class="group">
								<label for="joinvpw" class="label">Repeat Password</label>
								<input id="joinvpw" type="password" class="input" data-type="password">
							</div>
							<div class="group">
								<label for="name" class="label">Name</label>
								<input id="name" name="name" type="text" class="input">
							</div>
							<div class="group">
								<label for="email" class="label">Email Address</label>
								<input id="email" name="email" type="text" class="input">
							</div>
							<input type="hidden" id="grade" type="text" name="grade" value="1">
							<div class="group">
								<input type="button" id="joinBtn" style="margin-top: 35px" class="button" value="Sign Up">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>

<script>
	$("#findpwBtn").click(function(){
		$("#modal").attr("style", "display:block");
	});
	
	$("#modal_find").click(function(){
		if (formChk([ 'fid', 'fname', 'femail' ]) == false) {
			return false;
		}
		var dataForm = $("#searchForm").serialize();
		$.ajax({
			url: '${root}/user/findpw',
			type: 'GET',
			data: dataForm,
			success: function(data) {
				if(data != null) {
					alert('ID : ['+$("#fid").val()+'], PASSWORD : ['+data+']');
				}
			}
		});
	});
	
	$("#modal_close").click(function(){
		$("#modal").attr("style", "display:none");
	});	
	
	$("#naverLogin").click(function() {
		$.ajax({
			url: '/happyhouse/social/naver/call',
			type: 'get',
			success: function(data) {
				window.open(data,'Naver 로그인','width=800,height=700,location=no,status=no,scrollbars=yes');
			}
		});
	});
	
	$("#kakaoLogin").click(function() {
		// 1. 인증코드를 통해 토큰 발급받기
		Kakao.Auth.login({ 
			success : function(authObj) {
				// 2. 발급받은 토큰 SDK에 할당하기
				Kakao.Auth.setAccessToken(authObj.access_token); 
				// 3. 토큰으로 사용자 정보 받아오기
				Kakao.API.request({ 
					url : '/v2/user/me',
					success : function(response) {
						// 4. 이메일 정보 제공 동의 했는지 확인
						if (typeof response.kakao_account.email == "undefined") { 
							alert("이메일 정보 제공 동의를 해야합니다.");
							// 5-1. 이메일 정보 제공 동의 받기 
							Kakao.Auth.login({
								scope : 'account_email',
								success : function(response) {
									// 5-2. 새로 발급받은 토큰 SDK에 할당하기
									Kakao.Auth.setAccessToken(response.access_token);
								}
							});
						} else {
							// 6. DB에 가입 정보가 없으면 새로 회원가입하고 돼있으면 로그인
							$.ajax({
								url: '/happyhouse/social/kakao/login',
								type: 'post',
								data: {'id': response.id, 
									'name': response.kakao_account.profile.nickname,
									'email': response.kakao_account.email},
								success: function(data) {
									if(data == 1) location.href='/happyhouse';
								}
							});								
						}
					}
				});
			}
		})
	});
</script>
<script>
	function formChk(elements) {
		let result = true;
		$.each(elements, function(index, element) {
			let $ele = $(`#\${element}`);
			let msg = '필수 입력항목입니다. 내용을 입력하세요';
			if ($ele.prop('tagName') == 'SELECT') {
				msg = '항목을 선택하세요';
			}
			if ($ele.val().trim() == '') {
				alert(msg);
				$ele.focus();
				result = false;
				return false;
			}
		});
		return result;
	}
	$("#loginBtn").click(function() {
		if (formChk([ 'id', 'pw' ]) == false) {
			return false;
		}
		$('#loginForm').submit();
	});
	$("#joinBtn").click(function() {	
		if($("#joinpw").val() != $("#joinvpw").val()) {
			alert("패스워드가 일치하지 않습니다.");
		} else if (formChk(['joinid', 'joinpw', 'name', 'email']) == false) {
			return false;
		}
		$('#joinForm').submit();
	});
</script>
</body>
</html>