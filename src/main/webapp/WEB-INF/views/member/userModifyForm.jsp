<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정</title>
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

		    <form method="post" action="${root}/user/modify" id="privateForm">
		    	<div style="height:715px;">
			        <table class="clinic">
			            <tr>
			                <th style="width:200px;">회원 ID (수정 불가능)</th>
			                <td style="color: black;"><input id="id" type="text" style="width: 300px;" name="id" placeholder="${user.id}" value="${user.id}" readonly></td>
			            </tr>
			            <tr>
			                <th>회원 PW (수정 불가능)</th>
			                <td style="color: black;"><input id="pw" type="password" style="width: 300px;" name="pw" placeholder="${user.pw}" value="${user.pw}" readonly></td>
			            </tr>
			            <tr>
			                <th>회원 이름</th>
			                <td style="color: black;"><input id="name" name="name" style="width: 300px;" type="text" placeholder="${user.name}" value="${user.name }"></td>
			            </tr>
			            <tr>
			                <th>회원 이메일</th>
			                <td style="color: black;"><input id="email" name="email" style="width: 300px;" type="text" placeholder="${user.email}" value="${user.email }"></td>
			            </tr>
			            <tr>
			                <th>회원 등급 (수정 불가능)</th>
			                <td style="color: black;"><input type="text" name="grade" style="width: 300px;" placeholder="${user.grade}" id="grade" value="${user.grade}" readonly></td>
			            </tr>
			        </table>
		<!--         <div class="col-4 text-center"> -->
 		            <button id="btnOk" type="button" class="btn-done">수정완료</button>
		<!--         </div> -->
		         </div>
		    </form>
    	</div>
    </div>
    <script>
        $("#btnOk").click(function() {	
    		$('#privateForm').submit();
    	});
    </script>
</body>
</html>