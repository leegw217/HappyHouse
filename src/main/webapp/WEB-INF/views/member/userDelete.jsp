<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Happy House</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js'></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/minty/bootstrap.min.css" integrity="sha384-H4X+4tKc7b8s4GoMrylmy2ssQYpDHoqzPa9aKXbDwPoPUA3Ra8PA5dGzijN+ePnH" crossorigin="anonymous">
	<style>
		button {
			margin-right: 20px;
		}
		#mainText {
			padding-top: 100px;
		}
		#inputLarge {
			width: 500px;
			height: 40px;
		}
	</style>
	</head>
<body>
	<%@include file="/include/navibar.jsp"%>
	<div id="mainText">
		<h2>정말 탈퇴하시겠습니까?</h2>
		<div>
			<button type="button" class="btn btn-warning" onclick="location.href='main.do?action=PRIVATEDELETE'">탈퇴 확인</button>
			<button type="button" class="btn btn-primary" onclick="location.href='main.do?action=MAIN'">취소</button>
		</div>
	</div>
	
</body>
</html>