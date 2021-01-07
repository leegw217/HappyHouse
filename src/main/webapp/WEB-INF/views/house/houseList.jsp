<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>house info list</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    <meta name="author" content="">
    <meta name="description" content="">
    <meta name="keywords" content="">
 
    <link rel="stylesheet" href="${root}/resources/css/reset.css">
    <link rel="stylesheet" href="${root}/resources/css/style.css">
    <link rel="stylesheet" href="${root}/resources/css/custom.css">
    <link rel="stylesheet" href="${root}/resources/css/jquery.fullpage.css">
    <script src="${root}/resources/js/jquery.fullpage.js"></script>
	<script src="${root}/resources/js/jquery.bpopup-0.1.1.min.js"></script>
	
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    
	<style>
		@media screen and (min-width: 768px) { }
		
	    button {
	        margin-right: 20px;
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
	
		$("#searchBtn").click(function() {
			$("#searchForm").attr("action", "${root}/house/houselist").submit();
		});
		
		$("#clearBtn").click(function() {
			$("#dong").empty();
			$("#skey").empty();
			$("#sword").empty();
			$("#searchForm").attr("action", "${root}/house/houselist").submit();
		});
		
		$(".page-item").click(function() {
			$("#pg").val(($(this).attr("data-pg")));
			$("#pageform").attr("action", "${root}/house/houselist").submit();
		});
	
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
	    $("#dong").change(function() {
	    	let dong = $("#dong").val();
	    	//console.log(dong);
	    	$("#searchForm").attr("action", "${root}/house/houselist").submit();
	    });//change
	   
	});
	
	function getDong() {
	    return $("#dong").val();
	}
	
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
	
	function makeHouseForm(apt,name,lat,lng) {
		mapOption = { 
           center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
           level: 3
       	};
		map = new kakao.maps.Map(mapContainer, mapOption);
		var imageSize = new kakao.maps.Size(35, 45); 
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    var marker = new kakao.maps.Marker({
	        map: map, 
	        position: new kakao.maps.LatLng(lat, lng),
	        title : name, 
	        image : markerImage 
	    });
		console.log(apt);
		$.ajax({
			url:'${root}/map/search/' + apt,  
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				writeHouseDetail(data);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function writeHouseDetail(data) {
		console.dir(data);
		console.log('${member.id}');
		$("#housedetail").empty();
		let str = "<div style=\"display: none;\"><input type=\"text\" value=\"" + data.aptName + "\" id=\"houseDetailName\"></input></div>"
		+ "<div style=\"text-align:center; padding-top:20px;\">" 
		+ "<h3>" + data.aptName + " (설립연도 : " + data.buildYear + ") - " + data.floor + "층</h3>"
		+ "<h4>주소 : " + data.dong + " " + data.jibun + "번지</h4>"
		+ "<div style=\"text-align:left; padding-top:10px; padding-left:10px;\">"
		+ "<h4 style=\"color:#9bd1d3;\">< 주변 상권정보 ></h4>"
		+ "<table class=\"detail\" style=\"margin-left:-3px;\">"
		+ "<tr>"
		+ "<th>소매</th>"
		+ "<td id=\"store\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>생활서비스</th>"
		+ "<td id=\"hair\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>부동산</th>"
		+ "<td id=\"estate\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>여가/오락</th>"
		+ "<td id=\"fun\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>숙박</th>"
		+ "<td id=\"hotel\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>스포츠</th>"
		+ "<td id=\"sport\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>음식</th>"
		+ "<td id=\"food\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>학문/교육</th>"
		+ "<td id=\"education\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>의료</th>"
		+ "<td id=\"hospital\"></td>"
		+ "</tr>"
		+ "</table>"
		+ "<div style=\"text-align:left; padding-top:10px; \">"
		+ "<h4 style=\"color:#9bd1d3;\">< 주변 문화생활 정보 ></h4>"
		+ "<table class=\"detail\" style=\"margin-left:-3px;\">"
		+ "<tr>"
		+ "<th>공연장</th>"
		+ "<td id=\"concert\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>박물관/기념관</th>"
		+ "<td id=\"museum\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>미술관</th>"
		+ "<td id=\"gallery\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>문화예술회관</th>"
		+ "<td id=\"arthall\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>문화원</th>"
		+ "<td id=\"culturalcenter\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<th>도서관</th>"
		+ "<td id=\"library\"></td>"
		+ "</tr>"
		+ "</table>"
		+ "<div style=\"text-align:left; padding-top:10px;\">"
		+ "<h4 style=\"color:#9bd1d3;\">< 주변 공원 및 녹지 정보 ></h4>"
		+ "<div id=\"park\"></div>"
		+ "</div>"
		+ "<div style=\"margin-top:20px; text-align:center;\">"
		+ "<button type=\"button\" id=\"dealbtn\" class=\"btn-primary\">이 매물의 거래가 내역 보기</button>"
		+ "<button type=\"button\" id=\"likebtn\" class=\"btn-secondary\">이 매물을 찜하기</button>"
		//+ "<c:if test=" + ${member.id != null} + "><button type=\"button\" id=\"likebtn\" class=\"btn-secondary\">이 매물을 찜하기</button></c:if>"
		+ "</div>"
		+ "<script>"
		+ "$('#dealbtn').on('click', function(){"
	    + "makeModal('" + data.aptName + "');"
	    +	"$('.element_to_pop_up').bPopup({"
        +    "});"
		+ "});"
		+ "$('#likebtn').on('click', function(){"
		+ "addLikeList('" + data.no + "');"
		+ "});";
		$("#housedetail").append(str);
		makeStoreList(data.dong);
		makeCultureList(data.dong);
		makeParkList(data.dong);
		console.log($('#houseDetailName').val());
	}
	
	function makeModal(apt) {
		$("#housepricemodal").empty();
		let str = "<div style=\"text-align:center;\">"
		+ "<h2>해당 매물의 거래내역</h2>"
		+ "<table class=\"detail\" style=\"width:600px; margin-top:30px; margin-left:80px;\">"
		+ "<tr style=\"text-align:center;\">"
		+ "<td>계약일</td>"
		+ "<td>실거래가</td>"
		+ "<td>전용면적 (m^2)</td>"
		+ "<td>층</td>"
		+ "</tr>";
		$.ajax({
			url:'${root}/map/searchapt/' + apt,  
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				console.dir(data);
				$.each(data, function(index, vo) {
					str += "<tr>"
					+ "<td>" + vo.dealMonth + "월 " + vo.dealDay + "일</td>"
					+ "<td>" + vo.dealAmount + "</td>"
					+ "<td>" + vo.area + "</td>"
					+ "<td>" + vo.floor + " 층</td>"
					+ "</tr>";
				});
				str += "</table>";
				str += "</div>";
				$("#housepricemodal").append(str);
			},
			error:function(xhr,status,msg){
				console.log("상태값 : " + status + " Http에러메시지 : "+msg);
			}
		});
	}
	
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
	
	
	function makeStoreList(dongdata) {
		$.ajax({
			url:'${root}/map/storebigcode/' + dongdata,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				makeStoreBigCode(data);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function makeStoreBigCode(data) {
		console.dir(data);
		var imageSrc1 = "${root}/resources/icons/store.png";
	    var imageSrc2 = "${root}/resources/icons/hair.png";
	    var imageSrc3 = "${root}/resources/icons/estate.png";
	    var imageSrc4 = "${root}/resources/icons/fun.png";
	    var imageSrc5 = "${root}/resources/icons/hotel.png";
	    var imageSrc6 = "${root}/resources/icons/sport.png";
	    var imageSrc7 = "${root}/resources/icons/food.png";
	    var imageSrc8 = "${root}/resources/icons/education.png";
	    var imageSrc9 = "${root}/resources/icons/hospital.png";
	    var imageSize = new kakao.maps.Size(30, 30); 
		
	    let store='', hair='', estate='', fun='', hotel='', sport='', food='', education='', hospital='';
	    $.each(data, function(index, vo) {
	    	if(vo.bigCode == 'D') {
	    		store += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc1, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.bigCode == 'F') {
				hair += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc2, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage  
			    });
			}
			else if(vo.bigCode == 'L') {
				estate += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc3, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.bigCode == 'N') {
				fun += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc4, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.bigCode == 'O') {
				hotel += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc5, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.bigCode == 'P') {
				sport += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc6, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.bigCode == 'Q') {
				food += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc7, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.bigCode == 'R') {
				education += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc8, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage  
			    });
			}
			else if(vo.bigCode == 'S') {
				hospital += vo.typename + " , ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc9, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage  
			    });
			}
		});
	    if(store == '') store = " X ";
	    else store = store.slice(0,-3);
	    if(hair == '') hair = " X ";
	    else hair = hair.slice(0,-3);
	    if(estate == '') estate = " X ";
	    else estate = estate.slice(0,-3);
	    if(fun == '') fun = " X ";
	    else fun = fun.slice(0,-3);
	    if(hotel == '') hotel = " X ";
	    else hotel = hotel.slice(0,-3);
	    if(sport == '') sport = " X ";
	    else sport = sport.slice(0,-3);
	    if(food == '') food = " X ";
	    else food = food.slice(0,-3);
	    if(education == '') education = " X ";
	    else education = education.slice(0,-3);
	    if(hospital == '') hospital = " X ";
	    else hospital = hospital.slice(0,-3);
	    $("#store").append(store);
	    $("#hair").append(hair);
	    $("#estate").append(estate);
	    $("#fun").append(fun);
	    $("#hotel").append(hotel);
	    $("#sport").append(sport);
	    $("#food").append(food);
	    $("#education").append(education);
	    $("#hospital").append(hospital);
	}
	
	function makeCultureList(data) {
		$.ajax({
			url:'${root}/map/culture/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				makeCulture(data);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function makeCulture(data) {
		console.dir(data);
		var imageSrc1 = "${root}/resources/icons/concert.png";
	    var imageSrc2 = "${root}/resources/icons/museum.png";
	    var imageSrc3 = "${root}/resources/icons/gallery.png";
	    var imageSrc4 = "${root}/resources/icons/arthall.png";
	    var imageSrc5 = "${root}/resources/icons/culturalcenter.png";
	    var imageSrc6 = "${root}/resources/icons/library.png";
	    var imageSize = new kakao.maps.Size(30, 30); 
	    
	    let concert='', museum='', gallery='', arthall='', culturalcenter='', library='';
	    $.each(data, function(index, vo) {
	    	if(vo.genreCode == 1) {
	    		concert += vo.name + " / ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc1, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.genreCode == 3) {
				museum += vo.name + " / ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc2, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage  
			    });
			}
			else if(vo.genreCode == 4) {
				gallery += vo.name + " / ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc3, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.genreCode == 6) {
				arthall += vo.name + " / ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc4, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.genreCode == 7) {
				culturalcenter += vo.name + " / ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc5, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
			else if(vo.genreCode == 8) {
				library += vo.name + " / ";
				var markerImage = new kakao.maps.MarkerImage(imageSrc6, imageSize); 
			    var marker = new kakao.maps.Marker({
			        map: map, 
			        position: new kakao.maps.LatLng(vo.lat, vo.lng),
			        title : vo.name, 
			        image : markerImage 
			    });
			}
		});
	    if(concert == '') concert = " X ";
	    else concert = concert.slice(0,-3);
	    if(museum == '') museum = " X ";
	    else museum = museum.slice(0,-3);
	    if(gallery == '') gallery = " X ";
	    else gallery = gallery.slice(0,-3);
	    if(arthall == '') arthall = " X ";
	    else arthall = arthall.slice(0,-3);
	    if(culturalcenter == '') culturalcenter = " X ";
	    else culturalcenter = culturalcenter.slice(0,-3);
	    if(library == '') library = " X ";
	    else library = library.slice(0,-3);
	    $("#concert").append(concert);
	    $("#museum").append(museum);
	    $("#gallery").append(gallery);
	    $("#arthall").append(arthall);
	    $("#culturalcenter").append(culturalcenter);
	    $("#library").append(library);
	}

	function makeParkList(data) {
		$.ajax({
			url:'${root}/map/park/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				makePark(data);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function makePark(data) {
		console.dir(data);
		var imageSrc1 = "${root}/resources/icons/park.png";
	    var imageSize = new kakao.maps.Size(30, 30); 
	    
	    let park="<h3>";
	    $.each(data, function(index, vo) {
	    	park += vo.name + " / ";
			var markerImage = new kakao.maps.MarkerImage(imageSrc1, imageSize); 
		    var marker = new kakao.maps.Marker({
		        map: map, 
		        position: new kakao.maps.LatLng(vo.lat, vo.lng),
		        title : vo.name, 
		        image : markerImage 
		    });
		});
	    if(data.length == 0) {park += "근처에 공원이 없습니다.";}
	    else park = park.slice(0,-3);
	    park += "</h3>";
	    $("#park").append(park);
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

	    <div id="btn-sidebar-second"><i class="xi-bars"></i></div>
	    
	    
		<div style="float:left; margin-right:20px; margin-left:20px; width: 780px;" class="innermain">
            <div class="card col-sm-12 mt-1" style="min-height: 880px;">
                <div class="card-body">
                
	                <form name="pageform" id="pageform" method="GET" action="">
	                	<input type="hidden" name="pg" id="pg" value="">
	                	<input type="hidden" name="dongName" id="dongName" value="${dongName}">
						<input type="hidden" name="key" id="key" value="${key}">
						<input type="hidden" name="word" id="word" value="${word}">
					</form>
	                <br><br>
		                
		            <form method="get" id="searchForm">
		                <input type="hidden" name="pageNo" value="1" id="sFormPage">
		                <input type="hidden" name="pg" id="pg" value="1">
		                
			             시도 : <select id="sido"></select>
		                     구군 : <select id="gugun"></select>
		                  읍면동 : <select name="dongName" id="dong"></select>
	                    <br><br>
	                    
						<table>
							<tr>
						  		<td>
						  		  <select class="form-control" name="key" id="skey">
						  	  		<option value="">검색조건</option>
						  	    	<option value="AptName" 
						  	    		<c:if test="${key == 'AptName'}">selected</c:if>>아파트명</option>
						  	    	<option value="dealAmount" 
						  	    		<c:if test="${key == 'dealAmount'}">selected</c:if>>거래가(단위 : 천만원)</option>
						  	    	<option value="dealYear" 
						  	    		<c:if test="${key == 'dealYear'}">selected</c:if>>거래연도</option>
								  </select>
								  <input type="text" placeholder="검색어 입력." name="word" id="sword" style="width: 290px; margin-right:20px;">
								  <div style="display: none;"><input type="text" value="${dongName}" id="dongtmp"></input></div>
								  <button type="button" id="searchBtn" class="btn-primary" style="width: 50px;">검색</button>
								  <button type="button" id="clearBtn" class="btn-third" style="width: 50px;">초기화</button>
								</td>
						  	</tr>
						</table>
					</form>
	                <br>
	                
	                <table class="home" style="margin-left:-20px;">
	                    <thead>
	                        <tr>
	                            <th style="width: 9%;">번호</th>
	                            <th style="width: 9%;">법정동</th>
	                            <th style="width: 35%;">아파트이름</th>
	                            <th style="width: 12%;">거래금액</th>
	                            <th style="width: 12%;">거래일자</th>
	                            <th style="width: 12%;">면적(m^2)</th>
	                            <th style="width: 11%;">면적(평)</th>
	                        </tr>
	                    </thead>
	                    <tbody id="searchResult">
	                        <c:forEach var="house" items="${houselist}">
	                        <tr>
	                            <td>${house.no}</td>
	                            <td>${house.dong}</td>
	                            <td onClick="makeHouseForm('${house.no}','${house.aptName}','${house.lat}','${house.lng}')">${house.aptName}</td>
	                            <!-- 
	                            <td><a href="${root}/house/housedetail?aptName=${house.aptName}">${house.aptName}</a></td> 
	                            -->
	                            <td>${house.dealAmount}</td>
	                            <td>${house.dealMonth}월 ${house.dealDay}일</td>
	                            <td>${house.area}</td>
	                            <td>${house.areanew}</td>
	                        </tr>
	                        </c:forEach>
	                    
	                    </tbody>
	                </table>
	                <div style="padding-top:20px; margin-left:-30px;">
	                	${navigation.navigator}
	                </div>
				</div>
			</div>
		</div>
		   
		<div style="float:left; margin-right:20px; margin-top:10px; width: 400px; height: 880px; background-color:white; color:black;">
			<div id="housedetail">
				<div style="text-align:center; padding-top:400px;">
					<h2>매물 상세정보</h2>	
				</div>
			</div>
		</div>
		
		<div style="float:left; margin-top:10px;">
			<!-- map -->
			 
	       <div id="map" style="width:650px;height:880px;"></div>
	       <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4e8b19b784b4531235b3afd1ebb2cda2"></script>
	       
	       <script>
	       let mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	       mapOption = { 
	           center: new kakao.maps.LatLng(37.550701, 126.970667), // 지도의 중심좌표
	           level: 8// 지도의 확대 레벨
	       };
    	   let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	   	   let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		   
	       $(document).ready(function() {
	    		let dong = $('#dongtmp').val();
	    		console.log(dong);
		   	 	$.ajax({
	   	    		url:'${root}/map/searchdong/' + dong,  
					type:'GET',
					contentType:'application/json;charset=utf-8',
					dataType:'json',
					success:function(data) {
						$.each(data, function(index, vo) {
							var imageSize = new kakao.maps.Size(24, 35); 
						    
						    // 마커 이미지를 생성합니다    
						    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
						    var marker = new kakao.maps.Marker({
						        map: map, // 마커를 표시할 지도
						        position: new kakao.maps.LatLng(vo.lat, vo.lng),
						        title : vo.aptName, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						        image : markerImage // 마커 이미지 
						    });
						});
					},
					error:function(xhr,status,error){
						console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
					}
				});
	   	    });
	   	 	
			</script>
			
		</div>
	</div>
	
	<div class="element_to_pop_up" id="housepricemodal">
	   
	</div>
	
</body>
</html>