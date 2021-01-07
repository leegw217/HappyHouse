<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
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
		label {
            width: 200px;
            display: inline-block;
            padding-top: 5px;
            font-size: 20px;
        }
        .label--right {
            text-align: right;
        }
        .wt100 {
            width: 400px;
            height: 50px;
        }
		.form {
			padding-top: 30px;
		}
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/include/navibar.jsp"%>
	
	<form style="text-align: center;" method="post" action="${root}/user/findpw" id="findpwForm">
	  	<fieldset>
          	<legend style="padding-top: 50px; font-size: 40px;">비밀번호 찾기</legend>
          	<div class="text-right">
				<span class="text-warning">*</span> 표시가 된 항목은 필수 입력 항목입니다.
			</div>
          	<div class="form">
              	<label for="id" class="label--right"><span class="text-warning">*</span>ID : </label>
              	<input type="text" name="id" id="id" class="wt100" placeholder="At least 4 letters or numbers">
          	</div>
          	<div class="form">
              	<label for="name" class="label--right"><span class="text-warning">*</span>Name : </label>
              	<input type="text" name="name" id="name" class="wt100" placeholder="Name">
          	</div>
          	<div class="form">
              	<label for="name" class="label--right"><span class="text-warning">*</span>E-Mail : </label>
              	<input type="text" name="email" id="email" class="wt100" placeholder="Email">
          	</div>
		  	<div class="form">
			  	<button type="button" class="btn btn-primary" id="findpwBtn">Submit</button>
			  	<button type="button" class="btn btn-secondary" style="float: right;" id="btnReset">Clear</button>
			  	<button type="button" class="btn btn-info" style="float: right;" onclick="location.href='${root}/user/login'">Login</button>
		  	</div>
		  
	  	</fieldset>
	</form>
 
	<script>
	if("${msg}" != "")
		alert("${msg}");
		
	$("#findpwBtn").click(function() {	
		if (formChk(['id', 'name', 'email']) == false) {
			return false;
		}
		$('#findpwForm').submit();
	});
	$("#btnReset").click(function() {
		$('#findpwForm')[0].reset();
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