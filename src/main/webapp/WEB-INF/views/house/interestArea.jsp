<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>interestArea</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="">
<meta name="description" content="">
<meta name="keywords" content="">

<link rel="stylesheet" href="${root}/resources/css/reset.css">
<link rel="stylesheet" href="${root}/resources/css/style.css">
<link rel="stylesheet" href="${root}/resources/css/custom.css">
<link rel="stylesheet" href="${root}/resources/css/jquery.fullpage.css">
<script src="${root}/resources/js/jquery.fullpage.js"></script>

<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<style>
@media screen and (min-width: 768px) {
}

body{
	position: fixed;
}

button {
	margin-right: 20px;
}

.interest {
	background-color: #6ea0bb;
	margin: 0 5px 0 5px;
	color: white;
	float: left;
	text-align: center;
	width: 150px;
	height: 40px;
	line-height: 38px;
	border-radius: 10px;
}

#modal {
	display: none;
	position: fixed;
	top: 100px;
	left: 500px;
	width: 100%;
	z-index: 10;
}

#modal .modal_content {
	position: fixed;
	color: black;
	width: 600px;
	margin: 100px auto;
	padding: 20px 10px;
	background: #ffff;
	border-radius: 10px;
	z-index: 2;
}

#modal .modal_layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 1;
}

.city {
	min-width: 100px;
}

.modalBtn {
	border-radius: 3px; 
	border: 0px; 
	background: #6ea0bb; 
	width: 50px; 
	margin: 20px 20px 10px 20px
}

.facility {
	width: 60px;
	color: black;
}

.radio_label {
	display:inline-block; 
	width:200px; 
	color:black;
}

.dropdown dd,
.dropdown dt {
  margin-left: 60px;
  padding-left: 30px;
}

.dropdown ul {
  margin: -1px 0 0 0;
}

.dropdown dd {
  position: relative;
}

.dropdown a,
.dropdown a:visited {
  color: #fff;
  text-decoration: none;
  outline: none;
  font-size: 12px;
}

.dropdown dt a {
  background-color: #c6e4e4;
  display: block;
  padding: 8px 20px 5px 10px;
  min-height: 25px;
  line-height: 24px;
  overflow: hidden;
  border: 0;
  width: 280px;
}

.dropdown dt a span,
.multiSel span {
  cursor: pointer;
  display: inline-block;
  padding: 0 3px 2px 0;
}

.dropdown dd ul {
  background-color: #4F6877;
  border: 0;
  color: #fff;
  display: none;
  left: 0px;
  padding: 2px 15px 2px 5px;
  position: absolute;
  top: 2px;
  width: 280px;
  list-style: none;
  height: 200px;
  overflow: auto;
  margin-left: 30px;
  z-index: 4;
}

.dropdown span.value {
  display: none;
}

.dropdown dd ul li {
  padding: 5px;
  display: block;
}

.dropdown dd ul li a:hover {
  background-color: #fff;
}

.dropdown dd ul li input {
  width: 60px;
}

#divideBtn {
  background-color: #6ea0bb;
	color: white;
	float: left;
	text-align: center;
	width: 80px;
	height: 40px;
	line-height: 38px;
	border-radius: 10px;
  	border: 0;
  margin-left: 50px;
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
        $.ajax({
        	url: '${root}/interest/listinterest',
        	type: 'GET',
        	data: {'id': '${member.id}'},
			success:function(data) {
				listInterest(data);
			},
        });
        
        getHouse();
	});
	
	function listInterest(data) {
		$("#interestBtnArea").empty();
		$(data).each(function(index, vo) {
			var btn = '<div class="interest" id="'+vo.dong+'">'+vo.dong;
			btn += '<a style="margin: 0 0 0 40px; display: inline" href="javascript:deleteInterest(\''+vo.id+'\', \''+vo.dong+'\');">X</a>';
			$("#interestBtnArea").append(btn);
	    });
	}
	
	function getHouse(){
		$.ajax({
        	url: '${root}/interest/listhouse',
        	type: 'GET',
        	data: {'id': '${member.id}', 'pg': '1'},
        	dataType: "json",
            contentType:"application/json;charset=UTF-8",
        	success: function(data) {
        		listHouse(data.list);
        		getNavigator(data.navigator);
        	},
        });
	}
	
	function getNavigator(data) {
		$("#navigator_div").empty();
		$("#navigator_div").append(data);
	}
	
	function listHouse(data) {
		$("#searchResult").empty();
		$(data).each(function(index, vo) {
			var tr = '<tr><td>'+vo.no+'</td>';
			tr += '<td>'+vo.dong+'</td>';
			tr += '<td>'+vo.aptName+'</td>';
			tr += '<td>'+vo.dealAmount+'</td>';
			tr += '<td>'+vo.dealMonth+'월 '+vo.dealDay+'일</td>';
			tr += '<td>'+vo.area+'</td>';
			tr += '<td><button type=\'button\' style=\'width:50px;\' class=\'btn-done\' id=\'interest_add\'>찜하기</button></td></tr>';
			$("#searchResult").append(tr);
		});
	}
	
	function deleteInterest(id, dong) {
		$.ajax({
			url: '${root}/interest/deleteinterest',
			type: 'GET',
			data: {'id':id, 'dong':dong},
			success: function(data) {
				if(data == 1){
					$("#"+dong).remove();
					getHouse();
				}
			}
		});
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

		<!-- 메인 -->
		<div class="card col-sm-12 mt-1" style="min-height: 713px;">
			<div style="float: left; margin-top:10px; margin-left: 50px; width: 880px; height: 880px; background-color: white;">
			<div style="margin-left:80px;">
				<!-- 모달 -->
				<div id="modal">
					<div class="modal_content">
					<div style="padding: 1% 1% 1% 1%; margin-left:40px;">
					<form method="get" id="searchForm">
					<input type="hidden" name="id" value="${member.id}">
					시도 : <select class="city" id="sido"></select>
			                  구군 : <select class="city" id="gugun"></select>
			                  읍면동 : <select class="city" name="dong" id="dong"></select>
			        </form>
					</div>
						<div style="padding: 1% 33% 1% 33%">
						<button type="button" class="modalBtn" id="interest_add">등록</button>
						<button type="button" class="modalBtn" id="modal_close">취소</button>
						</div>
					</div>
					<div class="modal_layer"></div>
				</div>
				<!-- 관심동네 표시영역 -->
				<div style="position:relative;z-index:9;margin: 10px 10px 10px 10px; width: 700px; height: 680px;">
					<h2 style="text-align:center; color:black; margin: 30px 0 30px 0;">관심동네</h2>
					<div style="width:100%; height:40px; padding-left:50px;">
						<div id="interestBtnArea" style="float: left; margin:0px auto"></div>
						<button type="button" id="addBtn" class="interest" style="border: 0px; width: 100px; background-color: #c6e4e4;">관심동네 추가</button>
					</div>
					<!-- 추천 라디오 박스 -->
					<div style="padding-top: 30px; padding-left: 20px;">
						<div style="width:100%; height:40px; padding:10px 10px 10px 10px;">
							<label class="radio_label"><input style="width:60px;" type="radio" name="facility" value="0">미혼 및 딩크족</label>
							<label class="radio_label"><input style="width:60px;" type="radio" name="facility" value="1">고시 공부하는 자취생</label>
							<label class="radio_label"><input style="width:60px;" type="radio" name="facility" value="2">임신 준비중인 부부</label>
						</div>
						<div style="width:100%; height:40px; padding:10px 10px 10px 10px;">
							<label class="radio_label"><input style="width:60px;" type="radio" name="facility" value="3">어린아이를 둔 부부</label>
							<label class="radio_label"><input style="width:60px;" type="radio" name="facility" value="4">초등학교 이상 자녀</label>
							<label class="radio_label"><input style="width:60px;" type="radio" name="facility" value="5">아픈사람이 있는 가족</label>
						</div>
					</div>
					
					<div style="padding-top:20px; padding-left:25px; width:100%; height:70px;">
						<!-- 상권 분류 드롭다운 박스 -->
						<dl class="dropdown" style="float:left"> 
						    <dt>
						    <a href="#">
						    	<span>상권 분류</span>
						    </a>
						    </dt>
						    <dd>
						        <div class="mutliSelect">
						            <ul id="dropdown_ul"></ul>
						        </div>
						    </dd>
						</dl>
						<button type="button" id="divideBtn">필터 적용</button>
					</div>
					<!-- 필터링 된 매물 리스트 띄울 div -->
					<div style="margin:10px 30px 30px 30px; background:white; width:640px; height:350px;">
	                	<input type="hidden" name="pg" id="pg" value="">
						
						<table class="home" style="text-align:center">
			                <thead>
			                    <tr>
		                        	<th style="width: 10%;">번호</th>
									<th style="width: 12%;">법정동</th>
									<th style="width: 35%;">아파트이름</th>
									<th style="width: 15%;">거래금액</th>
									<th style="width: 15%;">거래일자</th>
									<th style="width: 13%;">면적 (m^2)</th>
						        </tr>
						    </thead>
						    <tbody id="searchResult">
						    </tbody>
						</table>
						<div id="navigator_div" style="padding-top:20px; width:100%; height: 60px;">
		                </div>
					</div>
				</div>
			</div>
			</div>
			<!-- 오른쪽 흰색 영역 -->
			<div style="float: left; margin-top:10px; margin-left: 70px; width: 880px; height: 880px; background-color: white;">
				<div style="text-align:center; margin-top:50px; color:black;"><h1>이런 집은 어떠세요?</h1></div>
				<div style="width:880px; height:400px; display: inline-block; margin-top:10px;">
					<div id="recommend1" style="float: left;"></div>
					<div id="recommend2" style="float: left;"></div>
				</div>
				<div style="width:880px; height:400px; margin-top:10px;">
					<div id="recommend3" style="float: left;"></div>
					<div id="recommend4" style="float: left;"></div>
				</div>
			</div>
		</div>
	</div>
	<script>
		// 페이징 함수
		$(document).on("click",".page-item", function(){
			$("#pg").val($(this).attr("data-pg"));
			var pg = $("#pg").val();
			var cnt = 0;
			$("input[name=divide]:checked").each(function() {
				cnt++;
			});
			if(cnt == 0) {
				$.ajax({
		        	url: '${root}/interest/listhouse',
		        	type: 'GET',
		        	data: {'id': '${member.id}', 'pg': pg},
		        	dataType: "json",
		            contentType:"application/json;charset=UTF-8",
		        	success: function(data) {
		        		listHouse(data.list);
		        		getNavigator(data.navigator);
		        	},
		        });
			} else {
				var divideList = [];
				$("input[name=divide]:checked").each(function() {
					var test = $(this).val();
					divideList.push(test);
				});
				// ajax 넣을자리
				$.ajax({
					url: '${root}/interest/search',
					type: 'GET',
		        	data: {'id': '${member.id}', 'divideList': divideList, 'pg': pg},
		        	dataType: "json",
		            contentType:"application/json;charset=UTF-8",
		        	success: function(data) {
		        		listHouse(data.list);
		        		getNavigator(data.navigator);
		        	},
				});
			}
		});
		
		// 상권 분류 적용 버튼
		$("#divideBtn").click(function(){
			var divideList = [];
			var cnt = 0;
			$("input[name=divide]:checked").each(function() {
				cnt++;
				var test = $(this).val();
				divideList.push(test);
			});
			if(cnt != 0){
				$.ajax({
					url: '${root}/interest/search',
					type: 'GET',
		        	data: {'id': '${member.id}', 'divideList': divideList, 'pg': '1'},
		        	dataType: "json",
		            contentType:"application/json;charset=UTF-8",
		        	success: function(data) {
		        		listHouse(data.list);
		        		getNavigator(data.navigator);
		        	},
				});
			} else {
				getHouse();
			}
			$.ajax({
				url: '${root}/interest/recommend',
				type: 'GET',
	        	data: {'id': '${member.id}', 'divideList': divideList},
	        	success: function(data) {
	        		let str1 = "<table style=\"width:400px; height:300px; margin-left:10px;\" class=\"detail\">"
	        		+"<tr>"
	        		+"<th>동</th>"
	        		+"<td>" + data[0].dong + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>매물명</th>"
	        		+"<td>" + data[0].aptName + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>전용 면적</th>"
	        		+"<td>" + data[0].area + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래금액</th>"
	        		+"<td>" + data[0].dealAmount + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래일</th>"
	        		+"<td>" + data[0].dealMonth + "월 " + data[0].dealDay + "일</td>"
	        		+"</tr>"
	        		+"</table>"
	        		+"<div style=\"margin-left:20px;\">"
	        		+"<div style=\"display: none;\"><input type=\"text\" value=" + data[0].no + " id=\"re1value\"></input></div>"
	        		+"<button type=\"button\" id=\"re1Btn\" class=\"btn-third\" style=\"width: 50px;\">찜하기</button>"
	        		+"</div>";
	        		$("#recommend1").append(str1);
	        		let str2 = "<table style=\"width:400px; height:300px; margin-left:10px;\" class=\"detail\">"
	        		+"<tr>"
	        		+"<th>동</th>"
	        		+"<td>" + data[1].dong + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>매물명</th>"
	        		+"<td>" + data[1].aptName + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>전용 면적</th>"
	        		+"<td>" + data[1].area + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래금액</th>"
	        		+"<td>" + data[1].dealAmount + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래일</th>"
	        		+"<td>" + data[1].dealMonth + "월 " + data[1].dealDay + "일</td>"
	        		+"</tr>"
	        		+"</table>"
	        		+"<div style=\"margin-left:20px;\">"
	        		+"<div style=\"display: none;\"><input type=\"text\" value=" + data[1].no + " id=\"re2value\"></input></div>"
	        		+"<button type=\"button\" id=\"re2Btn\" class=\"btn-third\" style=\"width: 50px;\">찜하기</button>"
	        		+"</div>";
	        		$("#recommend2").append(str2);
	        		let str3 = "<table style=\"width:400px; height:300px; margin-left:10px;\" class=\"detail\">"
	        		+"<tr>"
	        		+"<th>동</th>"
	        		+"<td>" + data[2].dong + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>매물명</th>"
	        		+"<td>" + data[2].aptName + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>전용 면적</th>"
	        		+"<td>" + data[2].area + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래금액</th>"
	        		+"<td>" + data[2].dealAmount + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래일</th>"
	        		+"<td>" + data[2].dealMonth + "월 " + data[2].dealDay + "일</td>"
	        		+"</tr>"
	        		+"</table>"
	        		+"<div style=\"margin-left:20px;\">"
	        		+"<div style=\"display: none;\"><input type=\"text\" value=" + data[2].no + " id=\"re3value\"></input></div>"
	        		+"<button type=\"button\" id=\"re3Btn\" class=\"btn-third\" style=\"width: 50px;\">찜하기</button>"
	        		+"</div>";
	        		$("#recommend3").append(str3);
	        		let str4 = "<table style=\"width:400px; height:300px; margin-left:10px;\" class=\"detail\">"
	        		+"<tr>"
	        		+"<th>동</th>"
	        		+"<td>" + data[3].dong + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>매물명</th>"
	        		+"<td>" + data[3].aptName + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>전용 면적</th>"
	        		+"<td>" + data[3].area + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래금액</th>"
	        		+"<td>" + data[3].dealAmount + "</td>"
	        		+"</tr>"
	        		+"<tr>"
	        		+"<th>거래일</th>"
	        		+"<td>" + data[3].dealMonth + "월 " + data[3].dealDay + "일</td>"
	        		+"</tr>"
	        		+"</table>"
	        		+"<div style=\"margin-left:20px;\">"
	        		+"<div style=\"display: none;\"><input type=\"text\" value=" + data[3].no + " id=\"re4value\"></input></div>"
	        		+"<button type=\"button\" id=\"re4Btn\" class=\"btn-third\" style=\"width: 50px;\">찜하기</button>"
	        		+"</div>";
	        		$("#recommend4").append(str4);
	        	}
			});
		});		
		
		$("#re1Btn").click(function(){
			var no = $("#re1value").val();
			console.log(no);
			addLikeList(no);
		});
		$("#re2Btn").click(function(){
			var no = $("#re2value").val();
			addLikeList(no);
		});
		$("#re3Btn").click(function(){
			var no = $("#re3value").val();
			addLikeList(no);
		});
		$("#re4Btn").click(function(){
			var no = $("#re4value").val();
			addLikeList(no);
		});
		
		function addLikeList(aptno) {
			let registerinfo = JSON.stringify({
				"no" : aptno,
				"user" : '${member.id}'
				});
			$.ajax({
				url:'${root}/map/addLikeList',  
				type:'POST',
				contentType:'application/json;charset=utf-8',
				dataType:'text',
				data: registerinfo,
				success:function() {
					alert("찜 목록에 추가되었습니다!");
				},
				error:function(xhr,status,msg){
					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
				}
			});
		}
		
	 	// 상권목록 리스트 관련 함수
		var facilityList = ["수퍼마켓","편의점","백화점","시장","세탁소","우체국","목욕탕, 사우나","헬스장","패스트푸드점","카페","병원","동물병원","야식집","국가고시 학원","경찰 학원","외국어 학원",
			"독서실","고시원","도서관","산부인과","소아과","산후조리원","어린이집","놀이방","초등학교","중학교","고등학교","학원-입시","노인/치매병원"];
		var list = [[0,1,2,3,4,5,6,7,8,9,10,11],[1,0,8,9,12,10,13,14,15,16,17,18],[0,1,2,3,4,5,6,7,8,9,10,19,20,21,11],[0,1,2,3,4,5,6,7,8,9,22,23,10,20,11],
			[0,1,2,3,4,5,6,7,8,9,24,25,26,27,16,18,10,11,20],[0,1,2,3,4,5,6,7,8,9,10,11,28]];
		$("input[name=facility]").click(function(){
			var select = $("input[name=facility]:checked").val();
			$("#dropdown_ul").empty();
			for(var i=0; i<list[select].length; i++){
				var name = facilityList[list[select][i]];
				var li = '<li><label><input type="checkbox" name="divide" value="'+name+'" />'+name+'</li></label>';
				$("#dropdown_ul").append(li);
			}
		});
		
		$(".dropdown dt a").on('click', function() {
			$(".dropdown dd ul").slideToggle('fast');
		});
		
		$(".dropdown dd ul li a").on('click', function() {
			$(".dropdown dd ul").hide();
		});
		
		function getSelectedValue(id) {
			return $("#" + id).find("dt a span.value").html();
		}
		
		$(document).bind('click', function(e) {
			var $clicked = $(e.target);
			if (!$clicked.parents().hasClass("dropdown")) $(".dropdown dd ul").hide();
		});
		
		$('.mutliSelect input[type="checkbox"]').on('click', function() {
			var title = $(this).closest('.mutliSelect').find('input[type="checkbox"]').val(),
			    title = $(this).val() + ",";
			if ($(this).is(':checked')) {
				var html = '<span title="' + title + '">' + title + '</span>';
			    $('.multiSel').append(html);
			    $(".hida").hide();
			} else {
			    $('span[title="' + title + '"]').remove();
			    var ret = $(".hida");
			    $('.dropdown dt a').append(ret);
			}
		});
		
		// 관심동네 추가 함수 (모달 내부)
		$("#interest_add").click(function(){
			if (formChk(['sido', 'gugun', 'dong']) == false) {
				return false;
			}
			var dataForm = $("#searchForm").serialize();
			$.ajax({
				url: '${root}/interest/writeinterest',
				type: 'GET',
				data: dataForm,
				success: function(data) {
					if(data == 1) {
						var btn = '<div class="interest" id="'+$("#dong").val()+'">'+$("#dong").val();
						btn += '<a style="margin: 0 0 0 40px; display: inline" href="javascript:deleteInterest(${member.id}, '+$("#dong").val()+');">X</a>';
						$("#interestBtnArea").append(btn);
						$("#modal").attr("style", "display:none");
						getHouse();
					} else if(data == 0) {
						alert("관심지역은 3개까지만 등록 가능합니다.");
					} else {
						alert("관심지역이 중복됩니다.");
					}
				}
			});
		});
		
		// 관심동네 추가함수 (모달 외부)
		$("#addBtn").click(function(){
			$("#modal").attr("style", "display:block");
			
			$.ajax({
				url:'${root}/map/sido',  
				type:'GET',
				contentType:'application/json;charset=utf-8',
				dataType:'json',
				success:function(data) {
					makeSido(data);
				},
				error:function(xhr,status,error){
					console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
				}
			});
		    $("#sido").change(function() {
		        //initMap();
		        let sido = $("#sido").val();
		        $.ajax({
					url:'${root}/map/gugun/' + sido,  
					type:'GET',
					contentType:'application/json;charset=utf-8',
					dataType:'json',
					success:function(data) {
						makeGugun(data);
					},
					error:function(xhr,status,error){
						console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
					}
				});
		    });//change
		    $("#gugun").change(function() {
		        //initMap();
		        let gugun = $("#gugun").val();
		        $.ajax({
					url:'${root}/map/dong/' + gugun,  
					type:'GET',
					contentType:'application/json;charset=utf-8',
					dataType:'json',
					success:function(data) {
						makeDong(data);
					},
					error:function(xhr,status,error){
						console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
					}
				});
		    });//change
		});
		
		// 모달 종료 함수
		$("#modal_close").click(function(){
			$("#modal").attr("style", "display:none");
		});		
		
		// 시도 / 구군 / 동 선택 함수
		function makeSido(data) {
			$("#sido").empty();
			$("#sido").append('<option value="0">선택</option>');
			$(data).each(function(index, vo) {
				$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
		    });
		}
		
		function makeGugun(data) {
			$("#gugun").empty();
		    $("#gugun").append('<option value="0">선택</option>');
		    $.each(data, function(index, vo) {
		        $("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
		    });
		}
		
		function makeDong(data) {
			$("#dong").empty();
		    $("#dong").append('<option value="0">선택</option>');
		    $.each(data, function(index, vo) {
		    	
		        $("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
		    });
		}
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