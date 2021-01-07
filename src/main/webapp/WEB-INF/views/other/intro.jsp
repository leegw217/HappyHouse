<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사이트 소개</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/minty/bootstrap.min.css" integrity="sha384-H4X+4tKc7b8s4GoMrylmy2ssQYpDHoqzPa9aKXbDwPoPUA3Ra8PA5dGzijN+ePnH" crossorigin="anonymous">
	<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
	<script defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDwTsAl15uxDhbMcuDWT398aYa0nAHCeCI&callback=initMap"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style>
		button {
			margin-right: 20px;
		}
		#center-div {
			margin: 0 auto;
 			background-color: #D8F0E3; 
			width: 800px;
			height: 500px;
			padding: 20px 20px;
			border-radius: 20px;
			color: white;
		}
		h1 {
			text-align: center;
			color: white;
		}
		h5 {
			color: white;
		}
		li {
			font-size: 20px;
		}
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/include/navibar.jsp"%>
	<br><br>
    <h1>HAPPY HOUSE 소개</h1><br>
   	<div class="bg-primary" id="center-div">
   		<div>
   			<h2>소개</h2>
   			<h5>happyhouse는 사용자가 보기 쉽도록 아파트/주택의 매매 혹은 전/월세 실거래가 정보 및 유용한 지역 정보를 담고있는 사이트입니다.</h5>
   		</div>
   		<hr>
   		<div>
   			<h2>주요서비스</h2>
   			<ul>
   				<li>법정동 거래 조회</li>
   				<li>아파트명 거래 조회</li>
   				<li>지역 상권 정보 조회</li>
   				<li>지역 환경 정보 조회</li>
   				<li>관심 지역 정보 조회</li>
   				<li>관련 주요 뉴스</li>
   			</ul>
   		</div>
   			
   		
   	</div>
</body>
</html>
