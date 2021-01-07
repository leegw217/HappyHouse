<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="${root}/resources/css/reset.css">
<link rel="stylesheet" href="${root}/resources/css/style.css">
<link rel="stylesheet" href="${root}/resources/css/custom.css">
<link rel="stylesheet" href="${root}/resources/css/jquery.fullpage.css">
<script src="${root}/resources/js/jquery.fullpage.js"></script>

<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<style>
@media screen and (min-width: 768px) {}

.board button {
	padding: 0;
	width: 40px;
	height: 30px;
}

.board td {
	padding-top: 15px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {

		$('#btn-sidebar-second').on('click', function() {
			$('#overlay').addClass('active');
			$('#sidebar').addClass('active');
		});

		$('#sidebar').on('click', function(e) {
			if (e.target.className == 'cont') {
				$('#overlay').removeClass('active');
				$('#sidebar').removeClass('active');
			}
		});
		//회원 목록
		$.ajax({
			url : '${root}/admin/user',
			type : 'GET',
			contentType : 'application/json;charset=utf-8',
			dataType : 'json',
			success : function(users) {
				makeList(users);
			},
			error : function(xhr, status, error) {
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : "
						+ xhr.responseText + "\nerror : " + error);
			}
		});

		// 회원 정보 수정 보기.
		$(document).on("click", ".modiBtn", function() {
			let mid = $(this).parents("tr").attr("data-id");
			$("#view_" + mid).css("display", "none");
			$("#mview_" + mid).css("display", "");
		});

		// 회원 정보 수정 실행.
		$(document).on("click",".modifyBtn", function() {
					let mid = $(this).parents("tr").attr("data-id");
					let modifyinfo = JSON.stringify({
						"id" : mid,
						"grade" : $("#grade" + mid).val()
					});
					$.ajax({
						url : '${root}/admin/user',
						type : 'PUT',
						contentType : 'application/json;charset=utf-8',
						dataType : 'json',
						data : modifyinfo,
						success : function(users) {
							makeList(users);
						},
						error : function(xhr, status, msg) {
							console.log("상태값 : " + status
									+ " Http에러메시지 : " + msg);
						}
					});
				});

		// 회원 정보 수정 취소.
		$(document).on("click", ".cancelBtn", function() {
			let mid = $(this).parents("tr").attr("data-id");
			$("#view_" + mid).css("display", "");
			$("#mview_" + mid).css("display", "none");
		});
	});

	function makeList(users) {
		$("#userlist").empty();
		$(users).each(function(index, user) {
			let str = "<tr id=\"view_" + user.id + "\" class=\"view\" data-id=\"" + user.id + "\">"
					+ "	<td>" + user.id + "</td>"
					+ "	<td>" + user.pw + "</td>"
					+ "	<td>" + user.name + "</td>"
					+ "	<td>" + user.email + "</td>"
					+ "	<td>" + user.grade + "</td>"
					+ "	<td><button type=\"button\" class=\"modiBtn btn btn-primary\">수정</button> "
					+ "		<button type=\"button\" class=\"btn btn-primary\">삭제</button></td>"
					+ "</tr>"
					+ "<tr id=\"mview_" + user.id + "\" data-id=\"" + user.id + "\" style=\"display: none;\">"
					+ "	<td>" + user.id + "</td>"
					+ "	<td>" + user.pw + "</td>"
					+ "	<td>" + user.name + "</td>"
					+ "	<td>" + user.email + "</td>"
					+ "	<td><input type=\"text\" name=\"grade\" id=\"grade" + user.id + "\" value=\"" + user.grade + "\"></td>"
					+ "	<td><button type=\"button\" class=\"modifyBtn btn btn-primary\">수정</button> "
					+ "		<button type=\"button\" class=\"cancelBtn btn btn-primary\">취소</button></td>"
					+ "</tr>";
			$("#userlist").append(str);
		});//each
	}
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

		<div id="btn-sidebar-second">
			<i class="xi-bars"></i>
		</div>

		<div class="innermain" style="height: 850px;">
			<h2 style="text-align: center">회원 목록</h2>
			<div style="text-align: center; margin-left:70px;">
			<table class="board">
				<colgroup>
					<col width="20%">
					<col width="20%">
					<col width="20%">
					<col width="22%">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<th class="text-center">아이디</th>
						<th class="text-center">비밀번호</th>
						<th class="text-center">이름</th>
						<th class="text-center">이메일</th>
						<th class="text-center">등급</th>
						<th class="text-center">수정/삭제</th>
					</tr>
				</thead>
				<tbody id="userlist"></tbody>
			</table>
			</div>
		</div>
	</div>
</body>
</html>