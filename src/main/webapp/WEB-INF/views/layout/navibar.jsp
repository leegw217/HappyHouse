<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
	<title>Navibar</title>
</head>
<body>
	<h1><a href="${root}">HAPPY HOUSE</a></h1>
	
	<div class="cont">
		<c:if test="${empty member}">
		    <div class="btn"><a href="${root}/login/login">LOGIN</a></div>
		</c:if>
		
		<c:if test="${not empty member}">
			<c:if test="${member.grade == 10}">
				<h3>관리자님 안녕하세요!</h3>
				<div class="btn"><a href="${root}/login/logout">LOGOUT</a></div>
			   	<div class="btn"><a href="${root}/qnaboard/qnalist">QnA</a></div>
			   	<div class="btn"><a href="${root}/freeboard/freelist">BOARD</a></div>
			</c:if>
			<c:if test="${member.grade != 10}">
				<h3>${member.name}님 안녕하세요!</h3>
				<div class="btn"><a href="${root}/login/logout">LOGOUT</a></div>
			   	<div class="btn"><a href="${root}/user/mypage">MYPAGE</a></div>
			   	<div class="btn"><a href="${root}/qnaboard/qnalist">QnA</a></div>
			   	<div class="btn"><a href="${root}/freeboard/freelist">BOARD</a></div>
			   	<div class="btn"><a href="${root}/house/interest">INTEREST</a></div>
			</c:if>
			<c:if test="${member.grade >= 5}"> 
	    		<div class="btn"><a href="${root}/user/list">ADMINPAGE</a></div>
			</c:if>
		</c:if>
		<div class="btn"><a href="${root}/notice/noticelist">NOTICE</a></div>
		<div class="btn"><a href="${root}/covid/covid">COVID19</a></div>
	</div>

</body>
</html>