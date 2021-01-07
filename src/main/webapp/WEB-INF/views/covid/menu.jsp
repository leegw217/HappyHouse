<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
	<title>코로나 19</title>
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
            margin-right: 20px;
        }
        
        .btn-primary:hover {
            background-color: white;
            color: #78C2AD;
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
	    
	    <div class="innermain" style="height:850px;">
		    <div style="text-align:center;">
		        <button type="button" class="btn-primary" style="padding-bottom: 60px; padding-right:20px; padding-left:20px; margin-top:30px; font-size:30px;" onclick="location.href='${root}/covid/hospitallist?pageNo=1&hospitalsearch='">국민안심병원</button><br><br>
		        <button type="button" class="btn-primary" style="padding-bottom: 60px; padding-right:20px; padding-left:20px; margin-top:30px; font-size:30px;" onclick="location.href='${root}/covid/cliniclist'">전체 선별진료소</button>
		    </div>
		</div>
	</div>
</body>
</html>