<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사이트맵</title>
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
			border: 5px solid #D3D3D3;
			width: 1000px;
			height: 500px;
			margin: 90px auto;
			text-align: center;
		}
		.box {
			margin: 20px 20px;
			background-color: #D8F0E3;
			width: 300px;
			height: 80px;
			text-align: center;
			line-height: 80px;
			font-size: 30px;
			font-weight: bold;
			border-radius: 20px;
		}
		.card {
			margin: 10px 10px;
			width: 300px;
			height: 180px;
			display: inline-block;
		}
		.card-header {
			font-size: 28px;
		}
		a {
			text-decoration: none;
			color: white;
		}
		
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/include/navibar.jsp"%>
	<div id="center-div">
		<br><br><br><h1>사이트맵</h1><br>
		<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
		  <div class="card-header">게시판</div>
		  <div class="card-body">
		    <h4 class="card-title"><a href="main.do?action=NOTICE">공지사항</a></h4>
		    <h4 class="card-title"><a href="/happyhouseBackEnd/main.do">오늘의 뉴스</a></h4>
		  </div>
		</div>
		<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
		  <div class="card-header">검색</div>
		  <div class="card-body">
		    <h4 class="card-title" id="search"><a href="/happyhouseBackEnd/main.do">거래가 검색</a></h4>
		    <h4 class="card-title"><a href="/happyhouseBackEnd/main.do">주변 탐색</a></h4>
		  </div>
		</div>
		<div class="card text-white bg-primary mb-3" style="max-width: 20rem;">
		  <div class="card-header">이용</div>
		  <div class="card-body">
		    <h4 class="card-title"><a href="/happyhouseBackEnd/main.do">마이페이지</a></h4>
		    <h4 class="card-title"><a href="/happyhouseBackEnd/main.do">관심지역</a></h4>
		  </div>
		</div>
		
	</div>
</body>
</html>
