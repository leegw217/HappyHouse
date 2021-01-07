<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	var bno = ${free.no};
	var memberId = "${member.id}";
	$('#commentBtn').click(function(){
		commentInsert();
	});
	
	function commentInsert(){	
		var contents = $("#contents").val();
		$.ajax({
			url: 'commentwrite',
			type: 'post',
			data : {'bno':bno, 'writer':memberId, 'content':contents},
			success: function(data){
				if(data == 1) {
					$("#comment").val('');
					commentList();
				}
			}
		});
	}
	
	function commentList(){
		$.ajax({
			url: 'commentlist',
			type: 'get',
			data: {'bno':bno},
			success : function(data){
	            var a = ''; 
	            $.each(data, function(key, value){ 
	            	a += '<div class="commentArea" style="width: 1000px; ">';
	                a += '<div class="commentInfo'+value.no+'">';
	                a += '<div class="commentContent'+value.no+'"> <input class="form-control" style="text-align:center;display:inline-block; width: 100px; margin:10px 10px 0 0;" value="'+value.writer+'" readonly>';
	                a += '<input class="form-control" style="display:inline-block; margin:5px 10px 5px 0; width: 750px;" value="'+value.content+'" readonly>'
	               	if(memberId == value.writer){
	               		a += '<button type="button" class="btn-third" style="padding:10px; margin-right: 15px;" onclick="commentUpdate('+value.no+',\''+value.content+'\');"> 수정 </a>';
		                a += '<button type="button" class="btn-done" style="padding:10px; margin-right: 15px;" onclick="commentDelete('+value.no+');"> 삭제 </button> </div>';
	               	}
	                a += '</div></div>';
	            });
	            $("#commentList").html(a);
	        }
		});
	}
	
	function commentUpdate(no, content){
		var a ='';
	    a += '<div class="input-group">';
	    a += '<input type="text" class="form-control" name="content_'+no+'" value="'+content+'"/>';
	    a += '<span class="input-group-btn"><button class="btn btn-info" type="button" onclick="commentUpdateProc('+no+');">수정</button> </span>';
	    a += '</div>';
	    $('.commentContent'+no).html(a);
	}
	
	function commentUpdateProc(no){
		var input = $('[name=content_'+no).val();
		$.ajax({
			url: 'commentmodify',
			type: 'post',
			data: {'no':no, 'content':input},
			success: function(data){
				if(data == 1) commentList();
			}
		});
	}
	
	function commentDelete(no){
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				url: 'commentdelete',
				type: 'get',
				data: {'no':no},
				success: function(data){
					if(data == 1) commentList();
				}
			});
		}		
	}
	
	$(document).ready(function(){
		commentList();
	});
</script>