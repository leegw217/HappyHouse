<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 작성</title>
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
		.input {
			width: 200px;
			height: 40px;
			float: right;
			margin-right: 15px;
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
			<h1 style="text-align:center; padding-top:20px;">공지사항 작성</h1><br>
			<form id="noticeForm" method="post" action="${root}/notice/noticewrite">
				<input type="hidden" name="writer" value="관리자">
				<table class="boarddetail">
					<tr>
						<th>글제목</th>
						<td><input type="text" id="title" name="title" style="width:1000px; margin-right:50px"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><input type="text" id="content" name="content" style="height:300px; width:1000px; margin-right:50px"></td>
					</tr>
				</table>
				
				<div class="form-group row">
					<label class="col-sm-2"></label>
					<div class="col-sm-10">
						<button type="button" class="btn-primary" id="writeBtn">추가</button>
						<button type="button" class="btn-secondary" onclick="location.href='${root}/notice/noticelist'">목록</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script>
	$("#writeBtn").click(function() {	
		if (formChk(['title', 'content']) == false) {
			return false;
		}
		$("#noticeForm").submit();
	});
	function formChk(elements) {
		let result = true;
		$.each(elements, function(index, element) {
			let $ele = $(`#\${element}`);
			let msg = '필수 입력항목입니다. 내용을 입력하세요';
			if ($ele.prop('tagName') == 'SELECT') {
				msg = '항목을 선택하세요';
			}
			if ($ele.val().trim() == '') {
				alert(msg);
				$ele.focus();
				result = false;
				return false;
			}
		});
		return result;
	}
	</script>
</body>
</html>