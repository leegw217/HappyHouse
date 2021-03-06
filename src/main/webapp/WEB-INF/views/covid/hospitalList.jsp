<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
	<title>국민안심병원 리스트</title>
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
	        
			$("#searchBtn").click(function() {
				$("#searchform").attr("action", "${root}/covid/hospitallist").submit();
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
			<form name="pageform" id="pageform" method="GET" action="">
				<input type="hidden" name="pg" id="pg" value="">
				<input type="hidden" name="key" id="key" value="${key}">
				<input type="hidden" name="word" id="word" value="${word}">
			</form>
			
			<form style="text-align: center;" method="get" action="" id="searchform">
			<input type="hidden" name="pg" id="pg" value="1">
			<table style="padding-top:50px;">
				<tr>
			  		<td>
				  	  <select class="form-control" name="key" id="skey">
					    <option value="name" selected="selected">기관명</option>
					    <option value="address">주소지</option>
					  </select>
					  <input type="text" class="form-control" placeholder="검색어 입력." name="word" id="sword">
					  <button type="button" id="searchBtn" class="btn btn-primary">검색</button>
					</td>
			  	</tr>
			</table>
			</form>
			
			<div class="row">
			    <div class="col-md-10"></div>
			    <div class="col-md-2" style="text-align: right; padding-right: 100px;">
					전체 <c:out value="${hospitallist.size()}"/>개
			    </div>
			</div>
			
		    <table class="covid" style="width:1300px;">
		        <thead>
		            <tr>
		                <th style="width: 10%;">시도</th>
		                <th style="width: 10%;">시군구</th>
		                <th style="width: 27%;">기관명</th>
		                <th style="width: 30%;">주소</th>
		                <th style="width: 8%;">유형</th>
		                <th style="width: 15%;">전화번호</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="hospital" items="${hospitallist}">
		            <tr>
		                <td style="color: black;">${hospital.sido}</td>
		                <td style="color: black;">${hospital.sigungu}</td>
		                <td style="color: black;">${hospital.name}</td>
		                <td style="color: black;">${hospital.address}</td>
		                <td style="color: black;">${hospital.type}</td>
		                <td style="color: black;">${hospital.call}</td>
		            </tr>
		            </c:forEach>
		            <c:if test="${empty hospitallist}">
						<tr>
							<td colspan='4'>입력된 게시물이 없습니다.</td>
						</tr>
					</c:if>
		        </tbody>
		    </table>
    	</div>
    </div>
</body>
</html>