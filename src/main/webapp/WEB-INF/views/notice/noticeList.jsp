<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지게시판</title>
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
			<h1 style="text-align:center; padding-top:20px;">공지사항</h1>
			<div class="container">
				<c:if test="${member.grade == 10}"> 
			    	<button type="button" class="btn-done" style="float: right; margin-right:100px; color:black; padding-left:20px; padding-right:20px;" onclick="location.href='${root}/notice/noticewrite'">공지사항 작성</button>
				</c:if>
				<br><br>
				<table class="board">
					<colgroup>
				        <col width="5%">
				        <col width="35%">
				        <col width="10%">
				        <col width="20%">
				        <col width="10%">
			        </colgroup>       
			        <tr style="text-align:center;">
			            <th>번호</th>
			            <th>제목</th>
			            <th>작성자</th>
			            <th>작성일</th>
			            <th>조회수</th>
			        </tr>
			        
			        <c:forEach var="notice" items="${noticelist}">
			        <tr style="text-align:center; width:100px;">
			            <td>${notice.no}</td>
			            <td style="text-align:left"><a href="${root}/notice/noticedetail?no=${notice.no}&grade=${member.grade}&view=${notice.view}">${notice.title}</a></td>
			            <td>${notice.writer}</td>
			            <td>${notice.date}</td>
			            <td>${notice.view}</td>
			        </tr>
			        </c:forEach>
			        
			    </table>
			 </div>
		 </div>
    </div>
    <script>
    $("#btn").click(function() {	
		$('#search').submit();
	});
    </script>
	
</body>
</html>