<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 확인</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    
    <link rel="stylesheet" href="${root}/resources/css/reset.css">
    <link rel="stylesheet" href="${root}/resources/css/style.css">
    <link rel="stylesheet" href="${root}/resources/css/custom.css">
    <link rel="stylesheet" href="${root}/resources/css/jquery.fullpage.css">
    <script src="${root}/resources/js/jquery.fullpage.js"></script>

    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    
	<style>
		@media screen and (min-width: 768px) { }
		
	    button {
	        margin-left: 20px;
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
</head>
<body>
	<div id="wrap">
	    <!-- 오버레이 처리 -->
	    <div id="overlay"></div>
	
	    <!-- 사이드바 -->
	    <div id="sidebar">
	    	<%@include file="/WEB-INF/views/layout/navibar.jsp"%>
	    </div>

	    <div id="btn-sidebar-second"><i class="xi-bars"></i></div>
	    
	    <div class="innermain">
	    	<div>
			    <a href="javascript:history.back();">
			        <button type="button" class="btn-primary" style="margin: 50px;">뒤로가기</button>
			    </a>			
			</div>
		    <div style="height:715px;">
				<table class="clinic">
					<tr>
						<th colspan="2">회원 정보</th>
					</tr>
					<tr>
			            <th>회원 아이디</th>
			            <td style="color: black;">${user.id}</td>
			        </tr>
			        <tr>
			            <th>회원 이름</th>
			            <td style="color: black;">${user.name}</td>
			        </tr>
			        <tr>
			            <th>회원 이메일</th>
			            <td style="color: black;">${user.email}</td>
			        </tr>
			        <tr>
			            <th>회원 등급</th>
			            <td style="color: black;">${user.grade}</td>
			        </tr>
			        <tr>
			            <th>회원가입 수단</th>
			            <td style="color: black;">${user.provider}</td>
			        </tr>
			        
			   </table>
			</div>
		</div>
	</div>
</body>
</html>