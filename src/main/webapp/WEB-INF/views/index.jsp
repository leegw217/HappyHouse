<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Happy House</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
    
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
         @media screen and (min-width: 768px) { }
    </style>
    
    <script type="text/javascript">
		$(document).ready(function() {
			
			$("#searchBtn").click(function() {
				$("#searchform").attr("action", "${root}/house/houselist").submit();
			});
			
	        $('#btn-sidebar').on('click', function(){
	            $('#overlay').addClass('active');
	            $('#sidebar').addClass('active');
	        });
	        
	        $('#sidebar').on('click', function(e){
	            if(e.target.className == 'cont'){
	                $('#overlay').removeClass('active');
	                $('#sidebar').removeClass('active');
	            }
	        });

	        $('#fullpage').fullpage({
	            autoScrolling: true,
	            scrollHorizontally: true,
	            css3: false, 
	            navigation: false,

	            afterLoad: function(anchorLink, index){
	                $('.slide_idx').html(index); 
	            }
	        });

	        $('#btn-next_slide').click(function(){
	            if($('.slide_idx').html() == '4'){
	                $.fn.fullpage.moveTo(1);
	                return;
	            }
	            $.fn.fullpage.moveSectionDown();
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

	    <div id="btn-sidebar"><i class="xi-bars"></i></div>
	    
	    <div id="scroll-control">
	        <div class="slide_idx">1</div>
	        <div class="bar">ㅡ</div>
	        <div class="slide_total">4</div>
	    </div>
	    <div id="btn-next_slide">SCROLL</div>
	
	    <!-- 메인 -->
	    <div class="main">
	        <div class="cont" id="fullpage">
	            <div id="s01" class="section">
	                <div class="up">
	                    	어디에서 살고 싶으세요?
	                </div>
	                <div class="down">
	                	<form id="searchform" method="get">
		                	<input type="hidden" name="pg" id="pg" value="1">
			  				<h1 id="searchBtn"> 집 보러가기 </h1>
		                </form>
	                </div>
	            </div>
	            <div id="s02" class="section">
	                <div class="left">
	                    About
	                </div>
	                <div class="right">
	                    	<h2>그동안 거래되었던 집 매물들을 한눈에 살펴볼 수 있는 사이트입니다.</h2> 
	                    	<br><br>
	                    	<br><br>
	                    	<br><br>
	                    	<h2>가격 비교는 물론 각종 상권 정보와 주변환경 정보도 한눈에 살펴보세요!</h2>
	                    	<br><br>
	                    	
	                </div>
	            </div>
	            <div id="s03" class="section">
	                <div class="left">
	                    How
	                </div>
	                <div class="right">
	                		<h2>회원가입 후 관심있는 매물을 간편하게 관리하고</h2>
	                		<br><br>
	                		<br><br>
	                		<br><br>
	                		<h2>빅데이터를 통해 자동으로 집 매물을 추천받아 보세요!</h2>
	                		<br><br>    
	                </div>
	            </div>
	            <div id="s04" class="section">
	                <div class="left">
	                    Member
	                </div>
	                <div class="right">
	                    <div class="mail1">
	                        <h2>이지원</h2>
	                        <h2>leegw217@naver.com</h2>
	                    </div>
	                    <div class="mail2">
	                        <h2>지서연</h2>
	                        <h2>wltjdus0208@naver.com</h2>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>

</body>
</html>