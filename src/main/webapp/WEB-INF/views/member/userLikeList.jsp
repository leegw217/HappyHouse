<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
   
   	<title>mypage - like list</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js'></script>
	
    <link href="images/favicon.ico" rel="icon" type="image/x-icon">
    <link rel="canonical" href="http://realtyprice.chosun.com/">
    <link rel="stylesheet" href="http://realtyprice.chosun.com/css/land_index.css?3">
    <script type="text/javascript" async="" src="http://www.google-analytics.com/plugins/ua/linkid.js"></script>
    <script async="" src="//www.google-analytics.com/analytics.js"></script><script type="text/javascript" src="http://realtyprice.chosun.com/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="http://realtyprice.chosun.com/js/jquery.scrollbar.min.js"></script>
    <script type="text/javascript" src="https://unpkg.com/infinite-scroll@3/dist/infinite-scroll.pkgd.min.js"></script>
    <script type="text/javascript" src="https://unpkg.com/imagesloaded@4/imagesloaded.pkgd.min.js"></script>
    <script type="text/javascript" src="http://realtyprice.chosun.com/js/land_index.js?1"></script>   
    <script type="text/javascript" src="http://realtyprice.chosun.com/js/land_sns.js?3"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/loader.js"></script>
	<link id="load-css-0" rel="stylesheet" type="text/css" href="https://www.gstatic.com/charts/49/css/core/tooltip.css">
	<link id="load-css-1" rel="stylesheet" type="text/css" href="https://www.gstatic.com/charts/49/css/util/util.css">
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/i18n/jsapi_compiled_i18n_default_module__ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/i18n/jsapi_compiled_i18n_graphics_module__ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/i18n/jsapi_compiled_i18n_ui_module__ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/i18n/jsapi_compiled_i18n_corechart_module__ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/i18n/jsapi_compiled_i18n_fw_module__ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/third_party/dygraphs/dygraph-tickers-combined.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/third_party/webfontloader/webfont.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://www.gstatic.com/charts/49/i18n/jsapi_compiled_i18n_line_module__ko.js"></script>

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
        let id = '${member.id}';
        $.ajax({
			url:'${root}/map/userlikelist/' + id,  
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				if(data.length==0) {
					let str = "<div style=\"display: inline-block; margin-top:300px; margin-left:200px;\">"
					+ "<h1>아직 찜해놓은 매물이 없습니다</h1>"
					+ "</div>";
					$("#likehouselist").empty();
					$("#likehouselist").append(str);
				} else {
					$("#likehouselist").empty();
					let str = "<div id=\"comparezone\" style=\"text-align:center; padding-top:30px;\">"
					+ "<select id=\"pick\" name=\"pick\" multiple=\"multiple\">";
					$.each(data, function(index, vo) {
						str += "<option value=" + vo.no + "/" + vo.gu + ">" + vo.dong + " / " + vo.aptName + "</option>";
					});
					str += "</select>";
					str += "<button type=\"button\" style=\"margin-left:20px;\" id=\"selectlist\" class=\"btn-primary\">매물 선택</button>";
					str += "</div>";
					str += "<script>";
					str += "$('#selectlist').on('click', function() {";
					str += "listselected() });";
					$("#likehouselist").append(str);
				}
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	});
	
	function listselected() {
		let str = "<div style=\"margin-top:30px;\">"
		+ "<table class=\"compare\" style=\"width:550px; margin-left:50px;\">"
		+ "<tr>"
		+ "<td id=\"house1\" style=\"text-align:center; height:50px; font-size:20px;\"></td>"
		+ "<th></th>"
		+ "<td id=\"house2\" style=\"text-align:center; height:50px; font-size:20px;\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<td style=\"text-align:right;\" id=\"price1\"></td>"
		+ "<th>가격</th>"
		+ "<td style=\"text-align:left;\" id=\"price2\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<td style=\"text-align:right;\" id=\"area1\"></td>"
		+ "<th>전용 면적</th>"
		+ "<td style=\"text-align:left;\" id=\"area2\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<td style=\"text-align:right;\" id=\"store1\"></td>"
		+ "<th>주변 상권</th>"
		+ "<td style=\"text-align:left;\" id=\"store2\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<td style=\"text-align:right;\" id=\"culture1\"></td>"
		+ "<th>문화생활</th>"
		+ "<td style=\"text-align:left;\" id=\"culture2\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<td style=\"text-align:right;\" id=\"metro1\"></td>"
		+ "<th>교통</th>"
		+ "<td style=\"text-align:left;\" id=\"metro2\"></td>"
		+ "</tr>"
		+ "<tr>"
		+ "<td style=\"text-align:right;\" id=\"education1\"></td>"
		+ "<th>교육</th>"
		+ "<td style=\"text-align:left;\" id=\"education2\"></td>"
		+ "</tr>"
		+ "</table>"
		+ "</div>";
		$("#comparehouse").empty();
		$("#comparehouse").append(str);
			
		let array = $("select[name=pick]").val();
		var idx = array[0].indexOf("/");
		let house1number = array[0].substring(0,idx);
		let house1gu = array[0].substring(idx+1);
		var index = array[1].indexOf("/");
		let house2number = array[1].substring(0,index);
		let house2gu = array[1].substring(index+1);
		
		$.ajax({
			url:'${root}/map/search/' + house1number,  
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$("#house1").append(data.aptName);
				$("#price1").append(data.dealAmount);
				$("#area1").append(data.area);
				compareStore1(data.dong);
				compareCulture1(data.dong);
				compareMetro1(house1gu);
				compareEducation1(house1gu);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
		
		$.ajax({
			url:'${root}/map/search/' + house2number,  
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$("#house2").append(data.aptName);
				$("#price2").append(data.dealAmount);
				$("#area2").append(data.area);
				compareStore2(data.dong);
				compareCulture2(data.dong);
				compareMetro2(house2gu);
				compareEducation2(house2gu);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function compareStore1(dongdata) {
		let D = new Array();
		let F = new Array();
		let L = new Array();
		let N = new Array();
		let O = new Array();
		let P = new Array();
		let Q = new Array();
		let R = new Array();
		let S = new Array();
		var d=0,f=0,l=0,n=0,o=0,p=0,q=0,r=0,s=0;
		$.ajax({
			url:'${root}/map/storebigcode/' + dongdata,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$.each(data, function(index, vo) {
			    	if(vo.bigCode == 'D') {
			    		D[d] = vo.typename;
			    		d++;
					}
					else if(vo.bigCode == 'F') {
						F[f] = vo.typename;
			    		f++;
					}
					else if(vo.bigCode == 'L') {
						L[l] = vo.typename;
			    		l++;
					}
					else if(vo.bigCode == 'N') {
						N[n] = vo.typename;
			    		n++;
					}
					else if(vo.bigCode == 'O') {
						O[o] = vo.typename;
			    		o++;
					}
					else if(vo.bigCode == 'P') {
						P[p] = vo.typename;
			    		p++;
					}
					else if(vo.bigCode == 'Q') {
						Q[q] = vo.typename;
			    		q++;
					}
					else if(vo.bigCode == 'R') {
						R[r] = vo.typename;
			    		r++;
					}
					else if(vo.bigCode == 'S') {
						S[s] = vo.typename;
			    		s++;
					}
				});
				var num = 0;
				var index = 0;
				let str = '';
				while(true) {
					if(D.length > index) {
						str += D[index] +" , ";
						num++;
					}
					if(F.length > index) {
						str += F[index] +" , ";
						num++;
					}
					if(L.length > index) {
						str += L[index] +" , ";
						num++;
					}
					if(N.length > index) {
						str += N[index] +" , ";
						num++;
					}
					if(O.length > index) {
						str += O[index] +" , ";
						num++;
					}
					if(P.length > index) {
						str += P[index] +" , ";
						num++;
					}
					if(Q.length > index) {
						str += Q[index] +" , ";
						num++;
					}
					if(R.length > index) {
						str += R[index] +" , ";
						num++;
					}
					if(S.length > index) {
						str += S[index] +" , ";
						num++;
					}
					if(num > 5) break;
					index++;
				}
				str = str.slice(0,-3);
				$("#store1").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
		
	function compareStore2(dongdata) {
		let D = new Array();
		let F = new Array();
		let L = new Array();
		let N = new Array();
		let O = new Array();
		let P = new Array();
		let Q = new Array();
		let R = new Array();
		let S = new Array();
		var d=0,f=0,l=0,n=0,o=0,p=0,q=0,r=0,s=0;
		$.ajax({
			url:'${root}/map/storebigcode/' + dongdata,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$.each(data, function(index, vo) {
			    	if(vo.bigCode == 'D') {
			    		D[d] = vo.typename;
			    		d++;
					}
					else if(vo.bigCode == 'F') {
						F[f] = vo.typename;
			    		f++;
					}
					else if(vo.bigCode == 'L') {
						L[l] = vo.typename;
			    		l++;
					}
					else if(vo.bigCode == 'N') {
						N[n] = vo.typename;
			    		n++;
					}
					else if(vo.bigCode == 'O') {
						O[o] = vo.typename;
			    		o++;
					}
					else if(vo.bigCode == 'P') {
						P[p] = vo.typename;
			    		p++;
					}
					else if(vo.bigCode == 'Q') {
						Q[q] = vo.typename;
			    		q++;
					}
					else if(vo.bigCode == 'R') {
						R[r] = vo.typename;
			    		r++;
					}
					else if(vo.bigCode == 'S') {
						S[s] = vo.typename;
			    		s++;
					}
				});
				var num = 0;
				var index = 0;
				let str = '';
				while(true) {
					if(D.length > index) {
						str += D[index] +" , ";
						num++;
					}
					if(F.length > index) {
						str += F[index] +" , ";
						num++;
					}
					if(L.length > index) {
						str += L[index] +" , ";
						num++;
					}
					if(N.length > index) {
						str += N[index] +" , ";
						num++;
					}
					if(O.length > index) {
						str += O[index] +" , ";
						num++;
					}
					if(P.length > index) {
						str += P[index] +" , ";
						num++;
					}
					if(Q.length > index) {
						str += Q[index] +" , ";
						num++;
					}
					if(R.length > index) {
						str += R[index] +" , ";
						num++;
					}
					if(S.length > index) {
						str += S[index] +" , ";
						num++;
					}
					if(num > 5) break;
					index++;
				}
				str = str.slice(0,-3);
				$("#store2").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function compareCulture1(data) {
		let C = new Array();
		let M = new Array();
		let G = new Array();
		let A = new Array();
		let CC = new Array();
		let L = new Array();
		var c=0,m=0,g=0,a=0,cc=0,l=0;
		$.ajax({
			url:'${root}/map/culture/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$.each(data, function(index, vo) {
			    	if(vo.genreCode == 1) {
			    		C[c] = vo.name;
			    		c++;
					}
					else if(vo.genreCode == 3) {
						M[m] = vo.name;
			    		m++;
					}
					else if(vo.genreCode == 4) {
						G[g] = vo.name;
			    		g++;
					}
					else if(vo.genreCode == 6) {
						A[a] = vo.name;
			    		a++;
					}
					else if(vo.genreCode == 7) {
						CC[cc] = vo.name;
			    		cc++;
					}
					else if(vo.genreCode == 8) {
						L[l] = vo.name;
			    		l++;
					}
				});
				var num = 0;
				var index = 0;
				let str = '';
				while(true) {
					if(C.length > index) {
						str += C[index] +" , ";
						num++;
					}
					if(M.length > index) {
						str += M[index] +" , ";
						num++;
					}
					if(G.length > index) {
						str += G[index] +" , ";
						num++;
					}
					if(A.length > index) {
						str += A[index] +" , ";
						num++;
					}
					if(CC.length > index) {
						str += CC[index] +" , ";
						num++;
					}
					if(L.length > index) {
						str += L[index] +" , ";
						num++;
					}
					if(num > 5) break;
					if(C.length + M.length + G.length + A.length + CC.length + L.length < 5) break;
					index++;
				}
				str = str.slice(0,-3);
				$("#culture1").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function compareCulture2(data) {
		let C = new Array();
		let M = new Array();
		let G = new Array();
		let A = new Array();
		let CC = new Array();
		let L = new Array();
		var c=0,m=0,g=0,a=0,cc=0,l=0;
		$.ajax({
			url:'${root}/map/culture/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$.each(data, function(index, vo) {
			    	if(vo.genreCode == 1) {
			    		C[c] = vo.name;
			    		c++;
					}
					else if(vo.genreCode == 3) {
						M[m] = vo.name;
			    		m++;
					}
					else if(vo.genreCode == 4) {
						G[g] = vo.name;
			    		g++;
					}
					else if(vo.genreCode == 6) {
						A[a] = vo.name;
			    		a++;
					}
					else if(vo.genreCode == 7) {
						CC[cc] = vo.name;
			    		cc++;
					}
					else if(vo.genreCode == 8) {
						L[l] = vo.name;
			    		l++;
					}
				});
				var num = 0;
				var index = 0;
				let str = '';
				while(true) {
					if(C.length > index) {
						str += C[index] +" , ";
						num++;
					}
					if(M.length > index) {
						str += M[index] +" , ";
						num++;
					}
					if(G.length > index) {
						str += G[index] +" , ";
						num++;
					}
					if(A.length > index) {
						str += A[index] +" , ";
						num++;
					}
					if(CC.length > index) {
						str += CC[index] +" , ";
						num++;
					}
					if(L.length > index) {
						str += L[index] +" , ";
						num++;
					}
					if(num > 5) break;
					if(C.length + M.length + G.length + A.length + CC.length + L.length < 5) break;
					index++;
				}
				str = str.slice(0,-3);
				$("#culture2").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function compareMetro1(data) {
		let str = '';
		$.ajax({
			url:'${root}/map/metro/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$.each(data, function(index, vo) {
					if(vo.id == 1) str += "<span style=\"color:#0a3480;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
					if(vo.id == 2) str += "<span style=\"color:#3a9f36;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
					if(vo.id == 3) str += "<span style=\"color:#dc5c32;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
					if(vo.id == 4) str += "<span style=\"color:blue;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
				});
				str = str.slice(0,-3);
				$("#metro1").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function compareMetro2(data) {
		let str = '';
		$.ajax({
			url:'${root}/map/metro/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				$.each(data, function(index, vo) {
					if(vo.id == 1) str += "<span style=\"color:#0a3480;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
					if(vo.id == 2) str += "<span style=\"color:#3a9f36;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
					if(vo.id == 3) str += "<span style=\"color:#dc5c32;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
					if(vo.id == 4) str += "<span style=\"color:blue;\">" + vo.id + "호선 </span>" + vo.name + "역" + " , ";
				});
				str = str.slice(0,-3);
				$("#metro2").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function compareEducation1(data) {
		let str = '';
		$.ajax({
			url:'${root}/map/school/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				str += "<div>공립 초등학교 : " + data[0].count + "개</div>";
				str += "<div>사립 초등학교 : " + data[1].count + "개</div>";
				str += "<div>국립 초등학교 : " + data[2].count + "개</div>";
				str += "<div>공립 중학교 : " + data[3].count + "개</div>";
				str += "<div>사립 중학교 : " + data[4].count + "개</div>";
				str += "<div>국립 중학교 : " + data[5].count + "개</div>";
				str += "<div>공립 고등학교 : " + data[6].count + "개</div>";
				str += "<div>사립 고등학교 : " + data[7].count + "개</div>";
				str += "<div>국립 고등학교 : " + data[8].count + "개</div>";
				$("#education1").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function compareEducation2(data) {
		let str = '';
		$.ajax({
			url:'${root}/map/school/' + data,
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				str += "<div>공립 초등학교 : " + data[0].count + "개</div>";
				str += "<div>사립 초등학교 : " + data[1].count + "개</div>";
				str += "<div>국립 초등학교 : " + data[2].count + "개</div>";
				str += "<div>공립 중학교 : " + data[3].count + "개</div>";
				str += "<div>사립 중학교 : " + data[4].count + "개</div>";
				str += "<div>국립 중학교 : " + data[5].count + "개</div>";
				str += "<div>공립 고등학교 : " + data[6].count + "개</div>";
				str += "<div>사립 고등학교 : " + data[7].count + "개 </div>";
				str += "<div>국립 고등학교 : " + data[8].count + "개</div>";
				$("#education2").append(str);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
	}
	
	function gu(gugun) {
		let id = '${member.id}';
        console.log(id);
    	console.log(gugun);
    	$.ajax({
			url:'${root}/map/userlikelist/' + id + "/" + gugun,  
			type:'GET',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			success:function(data) {
				if(data.length==0) {
					let str = "<div style=\"display: inline-block; padding-top:150px;\">"
					+ "<h3>해당 구에 찜해놓은 매물이 없습니다</h3>"
					+ "</div>";
					$("#likehousedetail").empty();
					$("#likehousedetail").append(str);
				} else {
					$("#likehousedetail").empty();
					let str = "<div style=\"display: inline-block;\">"
					+ "<table class=\"detail\">";
					$.each(data, function(index, vo) {
						console.dir(vo);
						str += "<tr>";
						str += "<th style=\"width:100px;\">" + (index+1) + "</th>";
						str += "<td style=\"width:500px;\" onClick=\"makeHouseDetail" + "(" + vo.no + ")" + "\">" + vo.dong + " / " + vo.aptName + " / " + vo.dealAmount + "</td>";
						str += "</tr>";
					});
					str += "</table>";
					str += "</div>";
					$("#likehousedetail").append(str);
				}
				console.log(data.length);
			},
			error:function(xhr,status,error){
				console.log("상태값 : " + xhr.status + "\nHttp에러메시지 : " + xhr.responseText + "\nerror : " + error);
			}
		});
    }
	
	function makeHouseDetail(apt) {
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
		$("#housedetail").empty();
		let str = "<div style=\"text-align:center; padding-top:20px;\">" 
		+ "<h3 style=\"text-align:center;\">" + data.aptName + " (설립연도 : " + data.buildYear + ") - " + data.floor + "층</h3>"
		+ "<h4 style=\"text-align:center;\">주소 : " + data.dong + " " + data.jibun + "번지</h4>"
		+ "<div style=\"text-align:left; padding-top:20px; padding-left:10px;\">"
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
		+ "<h6 style=\"color:#9bd1d3;\">< 주변 문화생활 정보 ></h6>"
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
		+ "</div>"
		+ "<script>"
		+ "$('#dealbtn').on('click', function(){"
	    + "makeModal('" + data.aptName + "');"
	    +	"$('.element_to_pop_up').bPopup({"
        +    "});"
		+ "});";
		$("#housedetail").append(str);
		makeStoreList(data.dong);
		makeCultureList(data.dong);
		makeParkList(data.dong);
	}
		
	function makeModal(apt) {
		$("#housepricemodal").empty();
		let str = "<div>"
		+ "<h2 style=\"text-align:center;\">해당 매물의 거래내역</h2>"
		+ "</div>";
		$("#housepricemodal").append(str);
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
	    let store='', hair='', estate='', fun='', hotel='', sport='', food='', education='', hospital='';
	    $.each(data, function(index, vo) {
	    	if(vo.bigCode == 'D') {
	    		store += vo.typename + " , ";
			}
			else if(vo.bigCode == 'F') {
				hair += vo.typename + " , ";
			}
			else if(vo.bigCode == 'L') {
				estate += vo.typename + " , ";
			}
			else if(vo.bigCode == 'N') {
				fun += vo.typename + " , ";
			}
			else if(vo.bigCode == 'O') {
				hotel += vo.typename + " , ";
			}
			else if(vo.bigCode == 'P') {
				sport += vo.typename + " , ";
			}
			else if(vo.bigCode == 'Q') {
				food += vo.typename + " , ";
			}
			else if(vo.bigCode == 'R') {
				education += vo.typename + " , ";
			}
			else if(vo.bigCode == 'S') {
				hospital += vo.typename + " , ";
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
		let concert='', museum='', gallery='', arthall='', culturalcenter='', library='';
	    $.each(data, function(index, vo) {
	    	if(vo.genreCode == 1) {
	    		concert += vo.name + " / ";
			}
			else if(vo.genreCode == 3) {
				museum += vo.name + " / ";
			}
			else if(vo.genreCode == 4) {
				gallery += vo.name + " / ";
			}
			else if(vo.genreCode == 6) {
				arthall += vo.name + " / ";
			}
			else if(vo.genreCode == 7) {
				culturalcenter += vo.name + " / ";
			}
			else if(vo.genreCode == 8) {
				library += vo.name + " / ";
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
		let park="<h3>";
	    $.each(data, function(index, vo) {
	    	park += vo.name + " / ";
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
    	<div id="overlay"></div>
    	<div id="sidebar">
	    	<%@include file="/WEB-INF/views/layout/navibar.jsp"%>
	    </div>
	    <div id="btn-sidebar-second"><i class="xi-bars"></i></div>
	    
	    <div style="float:left;">
	        <div class="svg_inner" style="width:1100px; height:660px; margin-left:-170px; margin-top:-90px;">
		    	<svg version="1.1" id="se" data-depth="second" data-content="11" class="data-content" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 1000 600" style="enable-background:new 0 0 1000 600;" xml:space="preserve">                           
		         <g>
		           <g id="segs">
		             <path id="segss" onClick="gu('강서구')" data-sub="11160" class="st0" d="M329.8,322.5c-31.7-23.5-32.3-25.2-38.3-37.6c-6.4-13-21.8-18.3-33.7-26.2
		               c-17.6-11.6-35.4-21.5-49.5-30.3c-9.9-6.2-30.9-14.3-29.5,8.1c0.6,8.6,4.5,11.9-4.4,18.1c-5.8,4.1-12.9,3.7-17.7,9.8
		               c-2.3,2.8-1.7,7.4-4.3,10.3c-3,3.5-7.4,4.4-10.9,7.1c-7.7,5.8-7.1,12-12.3,19.6c-4.3,6.2-6.4,12.9-10.8,18.6
		               c-2.1,2.7-8.2,2.3-8.5,6.5c-0.4,5,6.2,7.1,9.6,8.5c8.1,3.5,10.5,2.6,16.9,9.5c8.6,9.4,7.9,5.5,20.1,6.4
		               c10.3,0.7,8.4,6.5,15.6,10.8c8.4,5,15.3-0.7,21.7-5.5c8.9-6.8,11.2-8.8,17.7,1c2.3,3.4-1.4,8.4,5.2,8.5c2.8,0.1,6.8-5.4,8.8-7.2
		               c6.7-6.1,9.5-11.9,17.4-2.1c4.4,5.5,9.6,17.7,14.6,23.5c11.1,12.9,31.2,13,39.4-2.8c7.8-14.9-2.8-32.5,13.9-30.8
		               C321.3,347.6,341.4,341.2,329.8,322.5"></path>
		             <text transform="matrix(1 0 0 1 196.4704 306.5623)" class="st1 st2" onClick="gu('강서구')">강서구</text>
		           </g>
		           <g id="semp">
		             <path id="semps" onclick="gu('마포구')" data-sub="11140" class="st0" d="M333.4,251.8c-7.7-3.5-10.2,9.9-11.1,13.7c-1.4,6.7-5.8,13.9-12.5,16.4
		               c-4.5,1.7-14.3-0.7-16.3,4.1c-2.4,6,8.8,16.7,12.8,19.7c10.9,8.4,20,14.5,31.7,21.8c14,8.6,35.4,11.6,49,20.5
		               c4.8,3.1,9.6,10.6,14.7,12.8c6.9,3,11.2-4,17.4-4.8c6.4-0.7,13.7,5.1,19.3,7.9c5.7,3,8.8,7.2,14.9,9.4c8.6,3,10.2-8.2,12-13.6
		               c2.8-8.2,13.6-10.1,16.9-18.4c2.4-6.1,1.8-14.9-5.5-17.3c-7.1-2.3-14.6,0-21.7,0c-8.1,0.1-14.5,0.7-22.1-2.8
		               c-7.4-3.4-10.2-8.8-15.6-14c-4.4-4.4-9.5-5.5-14.9-8.4c-3.4-1.7-6-3-8.4-6c-2-2.3-3-4.5-4.8-7.1c-8.1-11.5-20.4-11.9-31.6-17.6
		               c-4.4-2.1-8.9-4.5-12.6-7.7C345,260.3,338.3,253.9,333.4,251.8z"></path>
		             <text transform="matrix(1 0 0 1 357.4035 320.0935)" class="st1 st2" onclick="gu('마포구')">마포구</text>
		           </g>
		           <g id="seyc">
		             <path id="seycs" onclick="gu('양천구')" data-sub="11150" class="st0" d="M332.7,336.4c-2.8,7.9-14.6,10.8-22,10.1c-16.6-1.7-6.1,15.9-13.9,30.8
		               c-8.2,15.7-28.3,15.6-39.4,2.8c-5-5.8-10.2-18.1-14.6-23.5c-6.2-7.7-9.2-5.7-13.5-1.6c-0.7,0.9-1.6,1.7-2.4,2.3
		               c-0.4,0.4-1,0.9-1.4,1.4c-1.8,1.7-5.4,6.7-8.2,7.1c-0.3,4.5,7.1,8.2,8.8,12.9c2.8,7.7-1.1,14.5-3.8,21.4c-3,7.8,0.9,12.3,0.4,20.4
		               c-0.1,3.4-1.7,7.8,1,10.5c3.5,3.5,5.5,0.4,8.6-0.4c8.4-2.3,8.5,8.8,17.1,7.7c8.5-1.1,12.5-8.6,17.6-14.5
		               c4.7-5.4,11.6-6.5,17.6-2.7c6.7,4.4,12.9,7.9,20.3,1.1c5.8-5.4,3.8-13,12.2-17.1c6.8-3.3,13.9-2.8,15.7-11.5
		               c1.7-7.4-0.3-14.6,4.1-21.4c3.5-5.5,9.5-8.5,11.2-15.2C350.7,347.6,343.4,337.4,332.7,336.4z"></path>
		             <text transform="matrix(1 0 0 1 249.1559 410.7771)" class="st1 st2" onclick="gu('양천구')">양천구</text>
		           </g>
		           <g id="segr">
		             <path id="segrs" onclick="gu('구로구')" data-sub="11170" class="st0" d="M365.4,464.5c-3.4-4.4-6.4-12.6-7.4-18.3c-1.6-9.9-1.3-18.4-5.8-27.6
		               c-3.7-7.5-10.9-13.2-17.4-18.4c-1.1-1-2.3-1.8-3.1-3.1c-2.8,5-8.8,5.1-14.3,7.9c-8.4,4.1-6.2,11.8-12.2,17.1
		               c-7.4,6.7-13.6,3.1-20.3-1.1c-6-3.8-12.9-2.7-17.6,2.7c-5.1,5.8-9.1,13.3-17.6,14.5c-8.6,1.1-8.9-9.9-17.1-7.7
		               c-2.6,0.7-7.1,0.3-9.5-0.7c-0.6-0.1-2.6,2.3-2.8,2.6c-2.7,3.1-5.1,6.5-7.2,10.1c-1.8,3.3-3.5,7.1-2.7,10.8c0.6,2.8,2.4,5,3.8,7.4
		               c6,10.2-4.8,21.8-0.9,32.7c1.7,4.8,6,8.8,11.3,6.4c4.4-2,7.4-5.2,12.3-2.7c4.7,2.6,6.4,6.4,12.2,5.4c3.4-0.6,6.4-1.4,8.9-4
		               c2.3-2.4,3-5.5,4.5-8.4c3-5.8,7.2-9.6,13.5-12c5.4-2.1,9.2-3.4,12.2-8.8c2.8-5.2,5.4-12,11.3-14.5c6.2-2.6,10.1,0.6,12,6.2
		               c0.7,2.1,0.9,5.5,1.8,7.4c1.3,2.1,5,3.5,7.2,4.1c6,1.6,12,2.1,17.4,5.2c5,3,10.1,7.5,15.9,8.2c5.1,0.7,11.9-2.1,14.6-6.9
		               C372.1,473.2,368.2,468.2,365.4,464.5z"></path>
		             <text transform="matrix(1 0 0 1 266.4503 448.2742)" class="st1 st2" onclick="gu('구로구')">구로구</text>
		           </g>
		           <g id="segc">
		             <path id="segcs" onclick="gu('금천구')" data-sub="11180" class="st0" d="M416.4,539.5c-6.1-5.5-13.5-1.7-20.4-4.1c-5.4-1.8-4.8-6.9-4.1-11.6c0.7-5.5,1-9.5-3.3-13.9
		               c-2.3-2.3-5.2-4.1-7.2-6.8c-2.8-3.5,0-6.8,2.6-9.4c2.8-2.7,5.8-5.2,6.9-9.2c3-11.3-10.3-11.1-17.6-10.6c-1.1,0-2.3,0.1-3.4,0.1
		               c0,1.6-0.3,3.4-1.4,5.2c-2.8,4.8-9.6,7.7-14.6,6.9c-5.8-0.7-10.9-5.2-15.9-8.2c-5.4-3.3-11.5-3.7-17.4-5.2
		               c-0.4-0.1-0.9-0.3-1.4-0.4c-0.3,2.3,0.9,5.1,1.6,6.8c2,4.5,4.4,8.6,5.4,13.6c0.9,5,1.3,9.9,4.1,14.2c3,4.5,6.4,6.1,7.9,11.5
		               c1.6,5.5,0.3,14.2,3.7,19c4.1,6,11.6,9.5,16.3,14.7c5.1,5.7,7.4,14.2,12.5,20.1c4.7,5.4,12.3,6.1,19.1,5.1
		               c7.1-1,11.3-5.7,14.7-11.6c1.8-3.3,4.1-6.4,6.8-9.1c2.7-2.4,6.5-4.1,8.1-7.5C421,545.6,419,541.9,416.4,539.5z"></path>
		             <text transform="matrix(1 0 0 1 344.735 525.2771)" class="st1 st2" onclick="gu('금천구')">금천구</text>
		           </g>
		           <g id="seydp">
		             <path id="seydps" onclick="gu('영등포구')" data-sub="11190" class="st0" d="M328.1,323.2c-0.3-0.7,0.6-1.3,1.1-0.9c2.1,1.3,4.7,2.7,8.8,5c24.1,13.3,33.7,10.6,49,20.5
		               c4.8,3.1,9.6,10.6,14.7,12.8c6.9,3,11.2-4,17.4-4.8c6.4-0.7,13.7,5.1,19.3,7.9c5.7,3,8.8,7.2,14.9,9.4c2.7,1,4.7,0.6,6.2-0.7
		               c3.7,2,7.4,4,10.3,7.2c3.5,4,8.6,9.5,5.5,14.9c-3.3,5.5-10.9,3.7-16.6,4.1c-6.4,0.3-13.3,0-19,2.4c-7.8,3.3-7.8,8.4-9.9,15
		               c-2,6.5-6.9,7.7-13.2,9.1c-7.1,1.6-9.6,4.7-11.1,11.6c-2.7,13.6-20.3,11.5-28.9,20.5c-3.4,3.5-5,7.9-9.1,10.3
		               c-0.7-1.1-1.6-2.1-2.3-3.1c-3.4-4.4-6.4-12.6-7.4-18.3c-1.6-9.9-1.3-18.4-5.8-27.6c-3.7-7.5-10.9-13.2-17.4-18.4
		               c-1.1-1-2.3-1.8-3.1-3.1c0.6-1,1-2.1,1.4-3.5c1.7-7.4-0.3-14.6,4.1-21.4c3.5-5.5,9.5-8.5,11.2-15.2c0.1-0.6,1.6-7.9-2.8-13.5
		               c-4.4-5.7-12.9-6.9-12.9-6.9l0,0l0,0L328.1,323.2z"></path>
		             <g>
		               <text transform="matrix(1 0 0 1 358.3937 394.1219)" class="st1 st2" onclick="gu('영등포구')">영등포구</text>
		             </g>
		           </g>
		           <g id="sedj">
		             <path id="sedjs" onclick="gu('동작구')" data-sub="11200" class="st0" d="M458.6,398.8c-6.4,0.3-13.3,0-19,2.4c-7.8,3.3-7.8,8.4-9.9,15c-2,6.5-6.9,7.7-13.2,9.1
		               c-7.1,1.6-9.6,4.7-11.1,11.6c-2.7,13.6-20.3,11.5-28.9,20.5c-2.8,3-4.4,6.4-7.1,8.9l0,0c0.1,0,6.9,1,7.8,1c3-0.3,6.1-0.9,8.9-1.7
		               c5.8-1.7,11.1-6.1,17.1-6.9c4.7-0.6,11.6,2.7,14.3-2.6c1.7-3.1,0.6-8.2,4.3-10.2c6.4-3.5,7.8,7.5,12.5,9.1c4,1.4,6.9-3.3,10.2-4.4
		               c4.1-1.4,6.8,3.5,11.1,2.7c4.7-1,9.8-8.8,14.7-6.8c3,1.3,4.5,6,5.8,8.5c2.7,5,6.4,8.9,8.6,14.2c4.7,10.5,10.3,22.1,23.2,23.2
		               c6.1,0.6,11.2-4.5,16.7-2.6c1.3-3.4,0.1-7.1-1.1-10.5c-2.6-7.4-4.1-16.3,1.3-23c2.6-3.1,5.4-6.4,3.5-10.6c-2-4.4-6.5-5.4-8.2-10.1
		               c-1.6-4.3,0.3-8.8-0.9-12.9c-1.3-4.8-5.8-6.4-10.2-6.7c-4.7-0.3-7.4-1.4-10.6-5c-3.3-3.7-5.7-4.7-10.3-4.4
		               c-4.3,0.1-7.5,0-10.8-2.4c-2.1-1.4-5-3.8-6.1-6.4C467.7,399.3,462.6,398.5,458.6,398.8z"></path>
		               <text transform="matrix(1 0 0 1 454.4079 433.6756)" class="st1 st2" onclick="gu('동작구')">동작구</text>
		           </g>
		           <g id="sega">
		             <path id="segas" onclick="gu('관악구')" data-sub="11210" class="st0" d="M536,502.6c-1.8-4.5-4.5-8.6-8.2-11.5c-6.8-5.4-12.5,1.7-19.6,1.1c-12.9-1.1-18.6-12.9-23.2-23.2
		               c-2.3-5.2-6.1-9.2-8.6-14.2c-1.4-2.6-2.8-7.4-5.8-8.5c-5-2-10.1,5.8-14.7,6.8c-4.3,0.9-6.9-4.1-11.1-2.7
		               c-3.4,1.1-6.2,5.8-10.2,4.4c-4.5-1.6-6.1-12.8-12.5-9.1c-3.5,2.1-2.6,7.1-4.3,10.2c-2.8,5.2-9.8,2-14.3,2.6
		               c-6.1,0.7-11.2,5.1-17.1,6.9c-2.8,0.9-6,1.6-8.9,1.7c-0.9,0-7.8-1-7.8-1c-0.6,0.6-1.1,1-1.8,1.4c1.3,2,2.3,4.1,2.3,6.5
		               c1.1,0,2.1-0.1,3.4-0.1c7.4-0.4,20.7-0.6,17.6,10.6c-1,4-4.1,6.5-6.9,9.2c-2.7,2.6-5.4,5.8-2.6,9.4c2,2.6,5,4.4,7.2,6.8
		               c4.3,4.3,4,8.4,3.3,13.9c-0.6,4.5-1.1,9.6,4.1,11.6c6.9,2.4,14.3-1.4,20.4,4.1c2.7,2.4,4.5,6.1,3,9.6c-1,2.3-3.1,3.8-5.2,5.4
		               c4.4,2.1,8.5,5.2,12.5,8.1c10.1,7.5,23.8,9.5,35.9,5.7c5.1-1.6,8.9-4.3,12.2-8.4c2.8-3.5,6.4-6.4,11.1-5.2
		               c5.1,1.1,9.8,3.5,14.7,0.7c4.3-2.4,6.4-6.9,9.5-10.3c8.2-9.1,24.4-9.9,27.5-23.7C538.9,515.4,538.3,508.6,536,502.6z"></path>
		               <text transform="matrix(1 0 0 1 425.4709 509.6629)" class="st1 st2" onclick="gu('관악구')">관악구</text>
		           </g>
		           <g id="sesc">
		             <path id="sescs" onclick="gu('서초구')" data-sub="11220" class="st0" d="M731,500.1c-13.6-11.8-30.8-5.1-42.2,6.1c-10.5,10.2-35,13-43.4-2.4c-1.8-3.5-1.4-7.4-3.4-10.8
		               c-1.8-3.1-5.2-4.7-7.1-7.8c-2.4-3.8-0.3-7.8-3.5-11.1c-2.8-2.8-6.8-2.6-10.5-2.8c-9.5-0.4-13.9-5.2-15.9-14.2
		               c-1.8-8.8-2.6-14.2-8.1-21.5c-10.5-13.7-9.4-33-14-48.9c-1-3.3-2.3-6-3.8-8.2c-2.1,1.3-4.4,2.4-6.4,3.8
		               c-10.5,7.1-16.2,18.4-26.5,25.8c-5.2,3.7-10.2,7.1-16.3,8.8c-4,1.1-8.4,1.6-12.3,2.1c1,1,1.7,2.1,2,3.5c1.1,4.3-0.7,8.6,0.9,12.9
		               c1.7,4.7,6.1,5.7,8.2,10.1c1.8,4.1-1,7.4-3.5,10.6c-5.4,6.7-3.8,15.6-1.3,23c1.1,3.4,2.3,7.1,1.1,10.5l0,0c1,0.3,1.8,0.9,2.8,1.6
		               c3.7,2.8,6.4,6.9,8.2,11.5c2.3,6,3,12.8,1.6,18.7c-0.9,3.7-2.7,6.5-5.1,8.8c4.7-2.4,6.9-10.8,11.3-13.6
		               c10.5-6.8,9.8,9.1,13.7,13.6c5.7,6.4,16,2,23,6.5c7.4,4.7,15.3,3.8,21.7-3.4c4-4.7,7.8-18.1,16.9-10.5c6.4,5.4,0.3,16.4-1.3,22.2
		               c-1.1,4.3-2.1,7.4-1.1,12c0.9,4,3,7.4,2.6,11.6c-0.9,9.2-5.2,13.3,4.4,20c6.7,4.5,15,4,23.1,4.8c8.6,0.9,16.2,4,24.8,4.4
		               c8.8,0.6,16.6-0.9,23.7-6.1c5.2-4,12.2-10.6,12.3-17.3c0.1-7.7-6.7-14.9-1-22.5c4.8-6.4,14.2-5.5,20.5-9.1
		               C743.5,533.4,745.8,512.9,731,500.1z"></path>
		               <text transform="matrix(1 0 0 1 566.2145 496.3611)" class="st1 st2" onclick="gu('서초구')">서초구</text>
		           </g>
		           <g id="seys">
		             <path id="seyss" onclick="gu('용산구')" data-sub="11030" class="st0" d="M586.6,358.7c-8.9-7.5-9.4-21-20.1-26.5c-4.8-2.6-9.8-4.7-14.5-7.8c-6.1-4-11.1-3-18.1-2.8
		               c-6.8,0-11.3-3.5-17.4-4.8c-6.4-1.3-11.8,3.7-17.9,4.8c-6.1,1.1-11.9,1.6-17.9,3.1c-0.6,0.1-1,0.3-1.6,0.4c5,3.4,5.1,10.6,3,16
		               c-3.3,8.4-14,10.3-16.9,18.4c-1.3,3.8-2.4,10.3-6,13c3.7,2,7.4,4,10.3,7.2c3.5,4,8.6,9.5,5.5,14.9c-0.9,1.6-2.1,2.6-3.7,3.1
		               c1.1,2.6,4.1,4.8,6.1,6.4c3.4,2.4,6.5,2.7,10.8,2.4c4.8-0.3,7.1,0.7,10.3,4.4c3.1,3.7,6,4.7,10.6,5c3,0.1,6.1,1,8.2,3.1
		               c4-0.6,8.4-1,12.3-2.1c6.1-1.7,11.1-5.1,16.3-8.8c10.3-7.2,16-18.6,26.5-25.8c5.1-3.4,10.9-5.4,15-10.2c1.7-2,3.8-4.5,3.8-7.2
		               C591.7,361.4,589,360.6,586.6,358.7z"></path>
		               <text transform="matrix(1 0 0 1 500.3346 371.2234)" class="st1 st2" onclick="gu('용산구')">용산구</text>
		           </g>
		           <g id="sejg">
		             <path id="sejgs" onclick="gu('중구')" data-sub="11020" class="st0" d="M599.8,298.3c-1.1-3.8-4.5-6.8-6.5-10.3c-0.1-0.1-0.4-0.1-0.6,0c-0.7,1-1.6,1.8-2.6,2.6
		               c-2.3,1.7-5.7,2.7-8.5,2.7c-10.6,0-19.3-7.8-29.6-8.8c-7.9-0.7-13.9,5.2-21.5,5.8c-4.4,0.4-8.8-0.7-12.9-2
		               c-7.7-2.3-14.5-0.4-21.4,2.8c-1.8,0.9-4,1.4-6,2l0,0c0.6,1,1.1,2.1,1.7,3.5c2.4,5.8,3.5,11.6-0.4,17.3c-2.7,3.8-5.8,7.1-9.4,9.9
		               c-0.3,0.3,0,0.7,0.3,0.6c5.4-1.3,10.6-1.7,16.2-2.7c6.1-1.1,11.5-6,17.9-4.8c6.1,1.3,10.6,4.8,17.4,4.8c7.1,0,12-1.1,18.1,2.8
		               c4.7,3,9.6,5.2,14.5,7.8c4,2.1,6.5,5.2,8.6,8.6c0.1,0.1,0.4,0.1,0.6,0c1.8-1.8,3.5-3.8,5-6.1c2.4-4.1,4.1-8.2,5.2-12.8
		               c1.4-5.8,5.4-7.1,10.1-10.5C600.4,308.2,601.5,303.8,599.8,298.3z"></path>
		               <text transform="matrix(1 0 0 1 527.9371 311.6023)" class="st1 st2" onclick="gu('중구')">중구</text>
		           </g>
		           <g id="sejn">
		             <path id="sejns" onclick="gu('종로구')" data-sub="11010" class="st0 vis" d="M584.2,254.1c-2.8-1.1-6-1.8-8.8-3c-3.1-1.3-6.1-3-9.1-4.8c-5.7-3.5-12.8-0.7-18.4-3.7
		               c-4.1-2.1-7.4-6.1-12.2-6.5c-4.3-0.4-7.8,2.3-11.8,3.4c-2,0.6-4.8,1-6.8,0.4c-2.8-0.7-4.3-3.5-4.8-6.1c-0.6-2.4-1.1-5.4-0.3-7.8
		               c0.9-2.6,3-4.4,5-6c2.8-2.4,5.7-5,7.4-8.4c1.3-2.6,1.7-5.5,1.1-8.4c-0.4-2.6-1.3-5.1-2.3-7.5c-2.3-5.4-6.4-10.6-7.5-16.4
		               c-0.7-4.1,1.6-7.7,1.3-11.6c-0.6-8.6-8.4-7.4-12.3-13c-1.1-1.7-3.1-12.3-10.5-10.3c0.3,0.4,0.6,0.9,0.9,1.3
		               c4.7,6.1,4,12.9-2.7,17.7c-5.8,4.1-14.2,4.5-19.4,9.4c-5.1,4.7-5.7,12.8-6,19.3c-0.4,7.4,1,13.3-4.8,19c-2.3,2.3-5.1,3.4-7.9,4.5
		               c0.1-0.1,0.4-0.1,0.6-0.3c2.6,3.3,7.8,6.7,11.9,9.6c5.8,4.3,0.7,10.9,5.8,15.2c1.8,1.6,4.5,1.4,6,4c2.3,4.1-0.7,4.8-2.4,7.8
		               c-2,3.4-0.4,5,0.9,8.4c1.6,4.4,0,6.4-2,10.2c-2.7,5.2-3.3,12,3.7,14.7c5.8,2.3,9.1,3.1,11.9,7.8c2.1-0.4,4.1-1.1,6-2
		               c7.1-3.3,13.9-5.1,21.4-2.8c4.3,1.3,8.5,2.4,12.9,2c7.7-0.7,13.6-6.7,21.5-5.8c10.3,1,19,8.8,29.6,8.8c2.8,0,6.1-0.9,8.5-2.7
		               c6.8-5.1,8.2-15.7,5.8-23.4c-1.4-4.3-3.7-8.4-7.5-10.9C587,255.2,585.6,254.6,584.2,254.1z"></path>
		             <text transform="matrix(1 0 0 1 495.2126 267.1316)" class="st1 st2" onclick="gu('종로구')">종로구</text>
		           </g>
		           <g id="seep">
		             <path id="seeps" onclick="gu('은평구')" data-sub="11120" class="st0" d="M494.9,145.7c-3.8-5.1-6.8-10.6-11.3-15.6c-5.4-5.8-7.9-11.6-15.4-15.3c-7.5-3.7-16-5.8-24.1-2.8
		               c-8.2,3.1-14.2,9.8-21.8,13.3c-7.2,3.4-14,3.7-21.8,4c-8.5,0.4-13.3,2.6-14.6,11.5c-1,7.1-2,14.5-3.8,21.4
		               c-2.1,7.5-5.7,10.5-11.1,15.9c-6.1,6-3.1,11.6-2.4,19c0.7,7.8-3.7,10.3-6.1,16.6c-2.3,6,1,12.5,0.9,18.6c0,8.1-6.4,12-13.5,13.6
		               c-3.1,0.7-17,2.4-19,5.2c0,0,1.8,0.1,2.1,0.4c0.1,0,0.3,0.1,0.4,0.1c5,2.3,11.6,8.5,11.6,8.5c3.7,3.3,8.2,5.5,12.6,7.7
		               c6.1,3,12.3,4.5,18.1,7.1c0.3-0.1,0.7-0.1,1-0.3c3.1-1.3,3.4-4.4,5.8-6.4c3.1-2.6,5.7-1.3,9.1-1.7c6.5-0.7,7.1-9.4,13-10.3
		               c3.3-0.6,6.5,1.7,9.9,0.9c3-0.7,5.7-3.3,7.5-5.7c2-2.6,3.1-5.8,5-8.4c2.1-3,4.8-3.8,7.7-6c6-4.4,6.1-10.1,9.9-15.7
		               c4.3-6.2,12.2-6,17.3-10.8c5.8-5.7,4.5-11.6,4.8-19c0.3-6.5,0.9-14.7,6-19.3c5.2-4.7,13.6-5.2,19.4-9.4
		               C498.9,158.6,499.6,151.8,494.9,145.7z"></path>
		             <text transform="matrix(1 0 0 1 393.4899 196.2371)" class="st1 st2" onclick="gu('은평구')">은평구</text>
		           </g>
		           <g id="sesdm">
		             <path id="sesdms" onclick="gu('서대문구')" data-sub="11130" class="st0" d="M492,296.4c-3.3-7.9-6.4-8.6-13.6-11.3c-6.9-2.7-6.2-9.5-3.7-14.7c2-3.8,3.5-5.7,2-10.2
		               c-1.3-3.5-2.7-5-0.9-8.4c1.6-3,4.7-3.7,2.4-7.8c-1.4-2.6-4.1-2.4-6-4c-5.1-4.3,0-10.9-5.8-15.2c-4.1-3-9.4-6.4-11.9-9.6
		               c-3.7,1.6-7.4,3-9.8,6.5c-4,5.5-4.1,11.3-9.9,15.7c-2.8,2.1-5.5,3-7.7,6c-1.8,2.6-3.1,5.8-5,8.4c-1.8,2.4-4.5,4.8-7.5,5.7
		               c-3.4,0.9-6.7-1.4-9.9-0.9c-6,1-6.5,9.6-13,10.3c-3.5,0.4-6-0.9-9.1,1.7c-2.4,2-2.7,5.1-5.8,6.4c-0.3,0.1-0.6,0.1-0.9,0.3
		               c5,2.1,9.6,5.1,13.5,10.5c1.8,2.6,2.8,4.8,4.8,7.1c2.6,3,5,4.3,8.4,6c5.5,2.7,10.5,4,14.9,8.4c5.4,5.4,8.2,10.6,15.6,14
		               c7.7,3.5,14,3,22.1,2.8c7.2-0.1,14.6-2.3,21.7,0c1.1,0.4,2.1,1,3,1.6c4.7-3.3,8.5-7.1,11.9-11.8
		               C495.6,307.9,494.4,302.3,492,296.4z"></path>
		               <text transform="matrix(1 0 0 1 411.8483 288.0369)" class="st1 st2" onclick="gu('서대문구')">서대문구</text>
		           </g>
		           <g id="sesb">
		             <path id="sesbs" onclick="gu('성북구')" data-sub="11080" class="st0" d="M688.8,194.4c-5.4-2.7-11.2-3.3-16.6-5.7c-6.2-2.7-7.1-9.9-13-13.2c-13.3-7.2-22.2,9.9-30.2,17.1
		               c-9.8,9.1-24,13.6-37.1,9.4c-13-4.3-15-19.1-25.5-26.4c-5.7-4-11.5-5-17.4-8.1c-6-3-10.1-8.4-14.7-12.9c-5-4.8-8.6-7.5-15.7-6.8
		               c-5.1,0.6-10.6,2.4-15,4.1c0.4,1.3,0.9,2.3,1.1,2.7c4,5.7,11.8,4.4,12.3,13c0.3,4-2,7.7-1.3,11.6c1.1,5.8,5.1,11.1,7.5,16.4
		               c1,2.4,1.8,5,2.3,7.5c0.4,2.8,0.1,5.8-1.1,8.4c-1.8,3.4-4.5,6-7.4,8.4c-2,1.7-4.1,3.5-5,6c-0.9,2.4-0.3,5.4,0.3,7.8
		               c0.6,2.6,2.1,5.4,4.8,6.1c2.1,0.6,4.8,0.1,6.8-0.4c4-1.1,7.5-3.8,11.8-3.4c4.8,0.4,8.1,4.4,12.2,6.5c5.8,3.1,12.8,0.3,18.4,3.7
		               c2.8,1.8,5.8,3.4,9.1,4.8c2.8,1.3,6,2,8.8,3c1.4,0.6,2.8,1.1,4.3,2.1c3.8,2.6,6.2,6.5,7.5,10.9c0.1,0.3,0.1,0.6,0.3,0.9
		               c8.5-4.3,13-12.6,20.8-19.4c4.7-4.1,11.3-4.7,17.1-6.1c5.8-1.4,10.5-5.8,14.2-10.9c3.1-4.4,6-9.1,11.2-11.3
		               c5.2-2.3,12-3.7,17.9-4.8c6.1-1.3,13.6-2.3,17.9-7.5C699.3,202.5,693.5,196.8,688.8,194.4z"></path>
		               <text transform="matrix(1 0 0 1 564.9518 229.4573)" class="st1 st2" onclick="gu('성북구')">성북구</text>
		           </g>
		           <g id="segb">
		             <path id="segbs" onclick="gu('강북구')" data-sub="11090" class="st0" d="M548.9,167.6c6,3,11.8,4.1,17.4,8.1c10.3,7.2,12.5,22.1,25.5,26.4c13.2,4.3,27.4-0.3,37.1-9.4
		               c5.4-5,11.1-14.2,18.3-17.6c-2.1-6.5-7.7-12.8-11.3-18.6c-3.8-6-4.7-11.5-10.2-16.3c-2.8-2.4-6.2-4.8-9.9-6.1
		               c-3.3-1.1-6.7-0.4-9.9-1.4c-6.5-2.1-8.9-8.9-14.6-11.1c-5.8-2.1-14.6,1.3-16.6-6.8c-3.5-14.2,15.9-21.8,11.9-36.8
		               c-1.6-6.1-4.8-11.8-10.3-15c-3.1-1.8-5-2.7-6.8-6.1c-1.7-3.1-1.1-5.5-5.1-7.1c-5.8-2.3-11.6,2.6-16.6,4.3c-6,2-12.3,3.8-14.6,10.3
		               c-2.3,6.4,1.8,12.5,2,19c0.1,8.4-6.4,7.9-12.6,6.7c-6.4-1.3-12,0-12,7.9c0,7.2,4.3,11.8,8.6,17c4.3,5.1,5.7,10.3,6,17
		               c0.1,2.7,0,12.6-2.8,15.4c4.7,0.4,7.9,3,11.9,6.8C538.9,159.4,543,164.7,548.9,167.6z"></path>
		             <text transform="matrix(1 0 0 1 550.3795 150.5491)" class="st1 st2" onclick="gu('강북구')">강북구</text>
		           </g>
		           <g id="sedb">
		             <path id="sedbs" onclick="gu('도봉구')" data-sub="11100" class="st0" d="M659.6,92.1c-0.7-6.8-2.7-12.6-5.2-19c-2.3-5.8-2.4-11.8-0.7-17.9c1.4-5.4,7.4-11.5,6-17
		               c-1.6-5.7-10.3-9.8-15.4-10.3c-3.5-0.4-5.4,0-8.4-1.8c-2.6-1.6-4.4-3.4-7.4-3.7c-6.5-0.4-8.9,10.9-15,5.4
		               c-5.4-4.8,3.3-13.3-4.4-16.7c-3.1-1.3-6.8,0-9.9-1.1s-3.8-3.8-6-5.8c-4-3.8-12.2-1.8-16,1.6c-5.2,4.5-6.2,10.2-5.1,16.3
		               c0.6,2.7,1.6,6.4,0.4,9.1c-1.1,2.4-4.3,3.3-5.5,5.7c-1.7,3.3,1.3,5.2,0.3,8.6c-0.4,1.7-2.1,3.4-4.1,4.5c0.4,0.1,0.9,0.1,1.3,0.3
		               c4,1.4,3.4,4,5.1,7.1c1.8,3.4,3.7,4.3,6.8,6.1c5.5,3.3,8.8,8.9,10.3,15c4,15-15.4,22.7-11.9,36.8c2,8.1,10.9,4.7,16.6,6.8
		               s8.2,8.9,14.6,11.1c3.3,1,6.7,0.4,9.9,1.4c3.7,1.3,7.1,3.7,9.9,6.1c3,2.7,4.7,5.5,6.1,8.6c0.3-0.4,0.7-0.7,1-1.1
		               c5-6,6.1-11.6,8.9-18.1c1.3-3,3.5-6.4,7.1-4.3c2,1.1,3.1,6.5,6.8,4.3c2.1-1.3,1.4-6.4,1.7-8.6c0.4-3.1,1.4-6.2,2-9.5
		               C660.3,105.4,660.2,98,659.6,92.1z"></path>
		             <text transform="matrix(1 0 0 1 599.2145 87.0535)" class="st1 st2" onclick="gu('도봉구')">도봉구</text>
		           </g>
		           <g id="senw">
		             <path id="senws" onclick="gu('노원구')" data-sub="11110" class="st0" d="M751.7,136c-6-6-14.9-9.5-22.7-13c-6.2-3-15.4-6.8-19-12.9c-4.4-7.7,5.2-10.3,11.1-10.3
		               c7.2,0,14.2,1.8,14.6-7.9c0.6-14-10.6-24.5-6.8-38.4c1.7-6,4.5-13.2-4.4-15.2c-4-0.9-17,4.1-13.9-4.4c1-2.7,4.1-4.1,2.7-7.8
		               c-1.1-3-5-4.3-7.8-4.4c-6.4-0.3-13.5,3.1-19.4,5.2c-8.8,3.1-22.8,0-32,5.2c2.4,1.7,4.4,3.8,5.1,6.2c1.4,5.5-4.5,11.6-6,17
		               c-1.6,6.1-1.6,12,0.7,17.9c2.6,6.2,4.5,12.2,5.2,19c0.6,6.1,0.9,13.3-0.1,19.6c-0.4,3.3-1.6,6.4-2,9.5c-0.3,2.3,0.4,7.4-1.7,8.6
		               c-3.7,2.3-4.7-3-6.8-4.3c-3.5-2.1-5.8,1.3-7.1,4.3c-2.8,6.5-4,12.2-8.9,18.1c-0.3,0.4-0.7,0.7-1,1.1l0,0c1.1,2.4,2.4,5,4,7.7
		               c3.7,5.7,9.2,12,11.3,18.6l0,0c3.5-1.7,7.5-2,11.9,0.4c6,3.3,6.8,10.5,13,13.2c4.4,1.8,8.9,2.7,13.5,4.3
		               c10.9-4.8,20.8-11.6,33-10.6c11.6,1,31.3,7.1,34.4-9.5c1.1-6.4,1.1-12,3.8-18.3C759.8,147.8,757,141.1,751.7,136z"></path>
		             <text transform="matrix(1 0 0 1 669.0416 140.5491)" class="st1 st2" onclick="gu('노원구')">노원구</text>
		           </g>
		           <g id="sejl">
		             <path id="sejls" onclick="gu('중랑구')" data-sub="11070" class="st0" d="M776.1,226.4c-1.1-4-4.4-7.4-6.7-10.8c-1.1-1.8-2.7-3.8-3.4-5.8c-0.9-2.6,0.4-3.8,1-6.1
		               c1-4,0.6-8.5-1.1-12.3c-2.1-4.7-4.7-6.4-9.1-8.5c-2.7-1.3-4.7-2.4-6-4.3c-6.2,9.4-22.2,4.7-32.2,3.8c-12.2-1-22.1,5.8-33,10.6l0,0
		               c1.1,0.4,2.1,0.9,3.3,1.4c4.7,2.4,10.6,8.1,6.4,13.3c-2.1,2.7-5,4.3-8.1,5.2c0.1,1.1,0.4,2.1,0.6,2.7c1,2.6,2.8,4.5,4,7.2
		               c3,6.4,1.7,11.8-0.4,18.3c-2.3,6.8-1.8,10.9,3.8,15.9c5,4.3,8.8,9.6,8.8,16.6c0,5.8-1.1,12.3-2.3,17.9c-0.4,1.7-0.7,3.3-1.3,4.7
		               c2.3-2.1,3.5-5.2,6-7.2c2.7-2.1,7.9-2.8,11.1-1.7c3.8,1.4,6.7,4.3,11.2,4.4c4.7,0.1,8.2-1.1,11.9-4c2.8-2.3,7.2-4.3,9.5-7.1
		               c2.4-3.1,2.1-7.5,4.4-11.1c2.6-4.1,5.7-6.2,9.1-9.4c4.1-3.7,6.1-6.1,5-11.8c-0.9-4.3-2.7-8.5,1.1-11.8
		               C773.1,233.4,777.7,232.3,776.1,226.4z"></path>
		             <text transform="matrix(1 0 0 1 709.2604 239.0261)" class="st1 st2" onclick="gu('중랑구')">중랑구</text>
		           </g>
		           <g id="seddm">
		             <path id="seddms" onclick="gu('동대문구')" data-sub="11060" class="st0" d="M695,257.1c-5.7-5-6.1-9.1-3.8-15.9c2.1-6.5,3.4-11.9,0.4-18.3c-1.1-2.6-3-4.7-4-7.2
		               c-0.3-0.6-0.4-1.6-0.6-2.7c-3.3,1.1-6.7,1.7-9.8,2.3c-5.7,1.1-12.6,2.6-17.9,4.8c-5.2,2.3-8.1,6.9-11.2,11.3
		               c-3.7,5.1-8.4,9.4-14.2,10.9c-5.8,1.4-12.3,2-17.1,6.1c-7.8,6.8-12.3,15.2-20.8,19.4c1,3.4,1.1,7.2,0.4,11.1
		               c5.1,5,12.2,7.9,19.7,9.6c6.1,1.3,12.9,0.9,18.8,2.4c6.1,1.6,12,5.2,17.9,8.2c13,6.7,22.7,14.2,37.7,7.1
		               c6.9-3.3,9.4-7.8,10.8-14.9c1.1-5.5,2.3-12,2.3-17.9C703.8,266.7,700,261.3,695,257.1z"></path>
		               <text transform="matrix(1 0 0 1 627.7428 274.8816)" class="st1 st2" onclick="gu('동대문구')">동대문구</text>
		           </g>
		           <g id="sesd">
		             <path id="sesds" onclick="gu('성동구')" data-sub="11040" class="st0" d="M690.2,305.9c-14.9,7.1-24.5-0.6-37.7-7.1c-5.8-3-11.8-6.7-17.9-8.2c-6.1-1.6-12.8-1.1-18.8-2.4
		               c-7.7-1.7-14.6-4.7-19.7-9.6c-0.6,3.1-1.7,6.2-3.7,8.6l0,0c2.1,3.7,5.5,6.7,6.8,10.8c1.7,5.5,0.6,10.1-4,13.3
		               c-4.7,3.4-8.6,4.5-10.1,10.5c-1,4.4-2.7,8.6-5.2,12.8c-1.4,2.4-3.3,4.5-5.2,6.4c3.5,6,5,12.2,10.5,16.9c1.7,1.4,5.2,3.5,6.1,5.1
		               c2.6-2,5.8-4.3,8.1-5.4c5.2-2.8,8.5-5.1,14.7-5.7c11.3-1,25.2,6.4,34,13.2c4.1,3.3,8.9,10.1,14.5,8.4c5.1-1.7,9.1-8.9,11.3-13.5
		               c3-5.8,5.4-11.3,6.7-17.4c1.1-5.7,1.8-10.9,5.2-15.7c6.5-9.5,15-18.4,14.2-30.2C698.6,299.7,694.7,303.8,690.2,305.9z"></path>
		               <text transform="matrix(1 0 0 1 614.5055 331.6678)" class="st1 st2" onclick="gu('성동구')">성동구</text>
		           </g>
		           <g id="segn">
		             <path id="segns" onclick="gu('강남구')" data-sub="11230" class="st0" d="M776.5,495.7c-4.1-6.8-4.4-14.3-11.6-19.1c-3.8-2.6-5.8-3.3-7.8-7.4c-1.8-4-2.7-7.2-5.8-10.6
		               c-6-6.4-13.7-10.3-21.8-11.5c-8.4-1.3-17.9,0.9-25.9-1.4c-21.3-6.1-18.1-23-19-40.8c-0.4-9.1-0.1-17.4-7.8-23.4
		               c-3.1-2.4-7.4-4.1-10.8-6.1c-1.3-0.7-2.4-1.6-3.3-2.4c0,0,0,0-0.1,0c-5.5,1.8-9.8-4.8-13.9-7.9c-8.8-6.8-22.4-15-33.7-13.9
		               c-6.2,0.6-11.2,3.5-16.6,6.4c-2.3,1.1-5.1,2.8-7.5,4.7l0,0c0.4,0.7,0.7,1.6,0.7,2.7c-0.1,2.7-2.1,5.2-3.8,7.2
		               c-2.6,2.8-5.5,4.8-8.6,6.5c1.6,2.3,2.8,5,3.8,8.2c4.5,15.9,3.5,35,14,48.9c5.5,7.4,6.2,12.8,8.1,21.5c1.8,8.9,6.4,13.7,15.9,14.2
		               c3.7,0.1,7.7,0,10.5,2.8c3.3,3.1,1.3,7.1,3.5,11.1c1.8,3.1,5.2,4.7,7.1,7.8c2,3.4,1.6,7.2,3.4,10.8c8.2,15.4,32.9,12.6,43.4,2.4
		               c11.6-11.2,28.6-17.9,42.2-6.1c9.6,8.4,11.9,20,7.8,29.8c4.7,0.1,8.9-0.4,13.9-4.7c5.8-5,9.2-11.3,16.4-13.6
		               c3.4-1.1,9.6-0.7,11.5-4.8C782.3,503.4,778.4,498.8,776.5,495.7z"></path>
		               <text transform="matrix(1 0 0 1 634.1539 456.8064)" class="st1 st1" onclick="gu('강남구')">강남구</text>
		           </g>
		           <g id="segj">
		             <path id="segjs" onclick="gu('광진구')" data-sub="11050" class="st0" d="M740.4,287.5c-3.7,2.8-7.2,4.1-11.9,4c-4.4-0.1-7.2-3-11.2-4.4c-3.3-1.3-8.4-0.4-11.1,1.7
		               c-2.4,2-3.7,5.1-6,7.2c-0.3,1-0.9,1.4-1.3,2.3c0.3,11.1-6.7,18.8-13,27.9c-3.4,4.8-4.1,10.1-5.2,15.7c-1.3,6.1-3.7,11.6-6.7,17.4
		               c-2.3,4.5-6.2,11.9-11.3,13.5c0,0,0,0,0.1,0c0.9,0.9,2,1.7,3.3,2.4c3.5,2,7.7,3.5,10.8,6.1c3.3,2.6,5.1,5.7,6.2,9.1
		               c0.1,0,0.4,0,0.6,0c4.4,0.4,8.5,0.6,12.9,0.9c4.4,0.3,8.6,1.6,12.9,0.4c9.2-2.4,16.2-7.1,23.2-13c7.5-6.2,15.6-12.3,21.4-20.4
		               c2.8-4,6.1-7.4,9.5-10.8c3.3-3.3,4.8-8.4,5.8-12.8c0.4-2.1,0.7-4.4,1.3-6.7c0.4-1.8,2.1-4,2-5.8c-0.4-4.5-6.7-4.1-10.1-4.3
		               c-4.1-0.1-8.8-1.7-10.6-5.8c-1.7-4,0-8.5,1.3-12c1.6-4.1,2.7-8.8,1.8-13.2c-0.7-4-2.7-5.5-5.7-6.4
		               C747.3,283.4,743.2,285.4,740.4,287.5z"></path>
		               <text transform="matrix(1 0 0 1 698.1891 344.3347)" class="st1 st2" onclick="gu('광진구')">광진구</text>
		           </g>
		           <g id="segd">
		             <path id="segds" onclick="gu('강동구')" data-sub="11250" class="st0" d="M884.2,314c-2.7-3.5-7.1-7.1-8.4-11.3c-1.4-4.5,2-8.2,3.7-12.2c1.7-4.1,2.6-9.6-3.4-10.6
		               c-4.7-0.7-8.6,5-12.2,7.2c-4.1,2.6-7.7,3.4-12,4.8c-4.1,1.3-6.9,4.8-10.6,7.1c-8.9,5.8-18.1,3.7-28.5,4.1c-4,0.1-8.9,1-12.2,3.1
		               c-4.1,2.7-7.4,6.5-11.6,9.2c-3.7,2.3-7.9,1.8-12.2,2.4c-1.3,0.1-3.4,1-5.4,2c0.7,0.6,1.1,1.4,1.3,2.6c0.1,1.8-1.4,4-2,5.8
		               c-0.6,2.1-0.9,4.4-1.3,6.7c-1,4.4-2.4,9.5-5.8,12.8c0.4-0.4,0.9-1.1,1.3-1.7c2.7-0.1,5.5,0.4,7.8,1c4.8,1.4,6.8,4.4,6.5,9.4
		               c-0.4,8.5-4.3,15.4-0.3,23.8c4.3,8.9,16.2,6.2,23.4,11.3c3.5,2.6,4.7,5.2,4.8,8.1c4.7-2.8,9.5-4.5,13.9-7.7c3.8-2.7,6.8-6,9.2-9.9
		               c5-8.1,1.6-17.6,6-25.8c4.5-8.4,13.9-9.9,23-8.8c8.9,1.1,22.1,7.2,27.8-3.4C891.9,334,890.7,322.8,884.2,314z"></path>
		               <text transform="matrix(1 0 0 1 799.7897 340.364)" class="st1 st2" onclick="gu('강동구')">강동구</text>
		           </g>
		           <g id="sesp">
		             <path id="sesps" onclick="gu('송파구')" data-sub="11240" class="st0" d="M834.8,439.2c-1.3-4.4-6.5-7.4-10.6-8.9c-7.8-2.8-21.5-4.4-20.5-15.4c0.7-8.6,8.2-17-1.3-23.5
		               c-7.2-5-19.1-2.4-23.4-11.3c-4-8.4-0.1-15.3,0.3-23.8c0.3-5-1.7-7.9-6.5-9.4c-2.3-0.6-5.1-1.3-7.8-1c-0.4,0.6-0.9,1.1-1.3,1.7
		               c-3.5,3.4-6.7,6.8-9.5,10.8c-5.8,8.1-13.9,14.2-21.4,20.4c-7.1,6-14,10.8-23.2,13c-4.3,1.1-8.5-0.3-12.9-0.4
		               c-4.4-0.1-7.5-0.4-11.9-0.9c-0.1,0-0.4,0-0.6,0h-1c1.3,4.4,1.4,9.2,1.6,14.3c0.9,17.7-2.3,34.7,19,40.8c7.9,2.3,17.6,0.3,25.9,1.4
		               c8.1,1.1,15.9,5.1,21.8,11.5c3.1,3.3,4,6.7,5.8,10.6c1.8,4.1,4,4.8,7.8,7.4c7.2,4.8,7.5,12.5,11.6,19.1c1.8,3,5.8,7.7,4.1,11.1
		               c-0.3,0.4-0.6,0.9-0.9,1.3c2.8,1.7,6,2.8,8.4,3c6.4,0.3,5.8-7.8,5.7-12.2c-0.1-2.4-0.1-5,1.8-6.8c2.4-2.3,6-1.4,7.7-4.8
		               c1.6-3.1,1.1-6.9,0.7-10.2c-0.3-2.6-0.6-5.7,1.4-7.8c2.1-2.3,5.8-2,8.4-3.7c2.1-1.4,3.4-4,4.8-6c2.4-3.5,5.5-5.4,8.9-7.8
		               C831.8,448.7,836.3,444.8,834.8,439.2z"></path>
		               <text transform="matrix(1 0 0 1 734.2115 428.4724)" class="st1 st2" onclick="gu('송파구')">송파구</text>
		           </g>          
		         </g>
		         </svg>
	      	</div>
	      	
	      	<div id="likehousedetail" style="float:left; margin-right:20px; margin-left:40px; width:730px; height:330px; text-align:center;" class="innermain">
	      		<div style="margin-top:150px; text-align:center; font-size:20px; font-weight:bold;">위 지도에서 동네를 선택하세요</div>
	      	</div>
	    </div>
	    
	    <div style="float:left; margin-top:40px; margin-left:-130px; width: 400px; height: 870px; background-color:white; color:black;">
	    	<div id="housedetail">
				<div style="text-align:center; padding-top:370px;">
					<div style="font-size:30px;">매물 상세정보</div>			
				</div>
			</div>
	    </div> 
	    
	    <div style="float:left; margin-top:40px; margin-left:30px; width: 650px; height: 870px; background-color:white; color:black;">
	    	<div style="text-align:center; font-size:20px; font-weight:bold; margin-top:20px;">비교할 매물 2개를 선택하세요</div>
	    	<div id="likehouselist"></div>
	    	<div id="comparehouse"></div>
	    </div> 
	    
	    <div class="element_to_pop_up" id="housepricemodal"></div>
	    
	</div>
</body>
</html>