<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    	button {
    		padding-right: 40px;
    	}
    </style>
 
</head>
<body>
    <h2 class="text-primary"><a href="${root}">HAPPY HOUSE</a></h2>
    
    <div style="height: 35px;">
    	<c:if test="${empty member}">
	        <button type="button" class="btn btn-primary" style="float: right;" onclick="location.href='${root}/user/join'">회원가입</button>
	    	<button type="button" class="btn btn-primary" style="float: right;" id="modal_btn" onclick="location.href='${root}/login/login'">로그인</button>    
	    </c:if>
	   
	    <c:if test="${not empty member}">
			<h4 style="float: right; padding-right: 40px;">${member.name}님 안녕하세요!</h4>
		   	<button type="button" class="btn btn-primary" style="float: right;" onclick="location.href='${root}/login/logout'">로그아웃</button>
			<button type="button" class="btn btn-primary" style="float: right;" onclick="location.href='${root}/user/mypage'">마이 페이지</button>
			<c:if test="${member.grade >= 5}"> 
	    		<button type="button" class="btn btn-primary" style="float: right;" onclick="location.href='${root}/user/list'">회원관리</button>
			</c:if>
			<button type="button" class="btn btn-outline-primary" style="float: right;" onclick="location.href='${root}/qnaboard/qnalist'">QnA 게시판</button>
		</c:if>
		
		<button type="button" class="btn btn-outline-primary" style="float: right;">관심 지역 둘러보기</button>
		<button type="button" class="btn btn-outline-primary" style="float: right;">주변 탐방</button>
		<button type="button" class="btn btn-outline-primary" style="float: right;">오늘의 뉴스</button>
		<button type="button" class="btn btn-outline-primary" style="float: right;" onclick="location.href='${root}/notice/noticelist'">공지사항</button>
		<button type="button" class="btn btn-outline-primary" style="float: right;" onclick="location.href='main.do?action=SITEMAP'">사이트맵</button>
		<button type="button" class="btn btn-outline-primary" style="float: right;" onclick="location.href='main.do?action=INTRO'">사이트소개</button>
		<button type="button" class="btn btn-outline-primary" style="float: right;" onclick="location.href='${root}/covid/covid'">코로나19</button> 
	</div>
	<hr>
</body>
</html>
