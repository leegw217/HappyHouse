<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자유게시판 게시글 상세보기</title>
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
			<h1 style="text-align:center; padding-top:20px;">게시글 상세보기</h1>
			<form id="writeForm" method="post" action="${root}/freeboard/freemodify">
				<table class="boarddetail">
					<tr>
						<th>글번호</th>
						<td><input type="text" id="no" name="no" style="width:100px; margin-right:50px" value="${free.no}" readonly></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td><input type="text" id="writer" name="writer" style="width:100px; margin-right:50px" value="${free.writer}" readonly></td>
					</tr>
					<tr>
						<th>글제목</th>
						<td><input type="text" id="title" name="title" style="width:1000px; margin-right:50px" value="${free.title}" readonly></td>
					</tr>
					<tr>
						<th>글내용</th>
						<td><input type="text" id="content" name="content" style="height:300px; width:1000px; margin-right:50px;" value="${free.content}" readonly></td>
					</tr>
					
				</table>
			</form>
			<div>
				<div>
					<c:if test="${free.writer == member.id || member.grade >= 10}">
						<c:if test="${member.grade < 10}">
							<button type="button" class="btn-primary" id="modifyBtn">수정</button>
							<button type="button" class="btn-secondary" id="modifyCompleteBtn" style="display:none">수정완료</button>
						</c:if>
						<button type="button" class="btn-third" id="deleteBtn">삭제</button>
					</c:if>
					<button type="button" class="btn-primary" style="" onclick="location.href='${root}/freeboard/freelist'">목록</button>
					<div id="commentList"></div><br>
					<form id="commentForm">
						<div>
						<input type="text" class="form-control" style="width:100px;text-align:center;float:left;margin:0 10px 10px 0;" value="${member.id}" readonly>
						<span class="col-sm-10">
							<input type="hidden" name="no" value="${free.no}">
							<input type="hidden" name="writer" value="${member.id}">
							<input type="text" class="form-control" id="contents" name="contents" style="width:800px; margin:0 10px 10px 0; float:left">
							<button type="button" class="btn btn-primary" id="commentBtn">등록</button>
						</span>
						</div>
					</form>
					
				</div>
			</div>
			<%@ include file="freeComment.jsp" %>
		</div>
	</div>
	<script>
		if(${member.grade} < 10) {
			$("#deleteBtn").attr('style','display:none');
		}
		$("#modifyBtn").click(function() {	
			$("#title").removeAttr('readonly');
			$("#content").removeAttr('readonly');
			$("#modifyBtn").hide();
			$("#modifyCompleteBtn").show();
			$("#deleteBtn").show();
		});
		$("#modifyCompleteBtn").click(function(){
			if (formChk(['title', 'content']) == false) {
				return false;
			}
			$("#writeForm").submit();
		});
		$("#commentBtn").click(function(){
			$("#commentForm").submit();
		});
		$("#deleteBtn").click(function(){
			if(confirm("정말 삭제하시겠습니까?")){
				location.href='${root}/freeboard/freedelete?no=${free.no}';
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