<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>QnA 게시글 상세보기</title>
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
			<h1 style="text-align:center; padding-top:20px;">게시글 상세보기</h1>
			<form id="writeForm" method="post">
				<table class="boarddetail">
					<tr>
						<th>글번호</th>
						<td><input type="text" id="no" name="no" style="width:100px; margin-right:50px" value="${qna.no}" readonly></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><input type="text" id="writer" name="writer" style="width:100px; margin-right:50px" value="${qna.writer}" readonly></td>
					</tr>
					<tr>
						<th>글제목</th>
						<td><input type="text" id="title" name="title" style="width:1000px; margin-right:50px" value="${qna.title}" readonly></td>
					</tr>
					<tr>
						<th>글내용</th>
						<td><input type="text" id="content" name="content" style="line-height:normal; height:300px; width:1000px; margin-right:50px;" value="${qna.content}" readonly></td>
					</tr>
					<tr>
						<th>비밀글</th>
						<c:choose>
						<c:when test="${qna.secret}">
							<td><input class="form-check-input" type="checkbox" id="gridCheck1" name="secret" checked="checked" disabled></td>
						</c:when>
						<c:otherwise>
							<td><input class="form-check-input" type="checkbox" id="gridCheck1" name="secret" disabled></td>
						</c:otherwise>
						</c:choose>
					</tr>
				</table>
			</form>
			<div class="form-group row" style="margin-left:10px;">
				<label class="col-sm-2"></label>
				<div class="col-sm-10">
					<c:if test="${qna.writer == member.id || member.grade >= 10}">
						<c:if test="${member.grade < 10}">
							<button type="button" class="btn btn-primary" id="modifyBtn">수정</button>
							<button type="button" class="btn btn-primary" id="modifyCompleteBtn" style="display:none;">수정완료</button>
						</c:if>
						<button type="button" class="btn btn btn-primary" id="deleteBtn">삭제</button>
					</c:if>
					<button type="button" class="btn btn-primary" onclick="location.href='${root}/qnaboard/qnalist'">목록</button>
				</div>
			</div>
			<form id="commentForm" method="post" action="${root}/qnaboard/qnacomment">
				<c:if test="${member.grade >= 10}">
				<input type="hidden" name="no" value="${qna.no}">
				<div class="form-group row" style="margin-left:10px; margin-top:10px;">
					<label for="comment" class="col-sm-2 col-form-label" style="text-align:center">답변</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="comment" name="comment" style="width:1000px; margin-right:5px; float:left;" value="${qna.comment}">
						<button type="button" class="btn btn-primary" id="commentBtn">작성</button>
					</div>
				</div>
				</c:if>
			</form>
			<c:if test="${member.grade < 10}">
				<div class="form-group row" style="margin-left:10px; margin-top:10px;">
					<label for="comment" class="col-sm-2 col-form-label" style="text-align:center">답변</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="comment" name="comment" style="width:1000px; margin-right:5px; float:left;" value="${qna.comment}" readonly>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<script>
	if(${member.grade} < 10) {
		$("#deleteBtn").attr('style','display:none');
	}
	$("#modifyBtn").click(function() {	
		$("#title").removeAttr('readonly');
		$("#content").removeAttr('readonly');
		$("#gridCheck1").removeAttr('disabled');
		$("#modifyBtn").hide();
		$("#modifyCompleteBtn").show();
		$("#deleteBtn").show();
	});
	$("#modifyCompleteBtn").click(function(){
		if (formChk(['title', 'content']) == false) {
			return false;
		}
		$("#writeForm").attr("action", "${root}/qnaboard/qnamodify").submit();
	});
	$("#commentBtn").click(function(){
		$("#commentForm").submit();
	});
	$("#deleteBtn").click(function(){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href='${root}/qnaboard/qnadelete?no=${qna.no}';
		}
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