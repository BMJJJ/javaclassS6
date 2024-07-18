<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카카오맵과 날씨 정보</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25842eaa8d7542aca1b754697717a5ab&libraries=services"></script>
    <style>
			.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
			.map_wrap {position:relative;width:100%;height:350px;}
			#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
			#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
			#category li.on {background: #eee;}
			#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
			#category li:last-child{margin-right:0;border-right:0;}
			#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
			#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
			#category li .bank {background-position: -10px 0;}
			#category li .mart {background-position: -10px -36px;}
			#category li .pharmacy {background-position: -10px -72px;}
			#category li .oil {background-position: -10px -108px;}
			#category li .cafe {background-position: -10px -144px;}
			#category li .store {background-position: -10px -180px;}
			#category li.on .category_bg {background-position-x:-46px;}
			.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
			.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
			.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
			.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
			.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
			.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
			.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
			.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
			.placeinfo .tel {color:#0f7833;}
			.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
  
    .container-fluid {
      max-width: 1400px;
      margin: 0 auto;
      padding: 20px;
    }
    .row {
      margin-left: 0;
      margin-right: 0;
    }
    .col-md-8, .col-md-4 {
      padding: 15px;
    }
    #map {
      width: 100%;
      height: 500px;
      border: 1px solid #ddd;
    }
    .weather-cards {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
    }
    .weather-card {
      width: 180px;
      margin: 10px;
      border: 1px solid #ddd;
    }
    
     .pretty-button {
    background-color: #3cb371; 
    border: none; /* 테두리 없음 */
    color: white; /* 흰색 글자 */
    padding: 10px 20px; /* 버튼의 패딩 */
    text-align: center; /* 텍스트 중앙 정렬 */
    text-decoration: none; /* 텍스트 데코레이션 없음 */
    display: inline-block; /* 인라인 블록 요소 */
    font-size: 14px; /* 글자 크기 */
    margin: 5px 5px; /* 마진 */
    cursor: pointer; /* 커서 포인터 */
    border-radius: 20px; /* 둥근 테두리 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
    transition: background-color 0.3s ease, transform 0.2s ease; /* 배경색 전환 및 변형 효과 */
}

		.pretty-button:hover {
		    background-color: #6b8e23; /* 호버 시 배경색 */
		    transform: translateY(-2px); /* 호버 시 살짝 위로 이동 */
		}
		
		.pretty-button:active {
		    background-color: #A0A0A0; /* 클릭 시 배경색 */
		    transform: translateY(0); /* 클릭 시 원래 위치 */
		} 
		
	.select-wrapper {
  display: inline-block;
  position: relative;
  margin-right: 10px;
  width: 120px; /* 너비 설정 */
}

.select-wrapper select {
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  width: 100%; /* 부모 요소의 너비에 맞춤 */
  padding: 10px 30px 10px 10px; /* 패딩 조정 */
  font-size: 14px; /* 글자 크기 조정 */
  border: 2px solid #3cb371;
  border-radius: 20px;
  background-color: white;
  cursor: pointer;
}

.select-wrapper::after {
  content: '\25BC';
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  pointer-events: none;
  color: #3cb371;
  font-size: 12px; /* 화살표 크기 조정 */
}

.select-wrapper select:hover,
.select-wrapper select:focus {
  border-color: #6b8e23;
  outline: none;
}
  </style>
  <script>
  let selectedLocation = null;

  function accessToGeo(position) {
    const positionObj = {
      latitude: position.coords.latitude,
      longitude: position.coords.longitude
    }
    let lot = "(현재위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
    $("#demo").text(lot);
  }
    
  $(document).ready(function () {
    function convertTime() {
      var now = new Date();
      var month = now.getMonth() + 1;
      var date = now.getDate();
      return month + '월' + date + '일';
    }
    var currentTime = convertTime();
    $('.nowtime').append(currentTime);
  });
    
  function weatherCheck1() {
    if (!selectedLocation) {
      alert("먼저 지도에서 위치를 선택해주세요.");
      return;
    }

    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+selectedLocation.latitude+'&lon='+selectedLocation.longitude+'&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
      function (WeatherResult) {
        $(".dispForm3").show();
        $('.jiyukName').html(selectedLocation.name);
        $('.nowTempl').html('현재기온: '+WeatherResult.main.temp + " ℃");
        $('.lowTempl').text('최저기온: '+WeatherResult.main.temp_min + " ℃");
        $('.highTempl').text('최고기온: '+WeatherResult.main.temp_max + " ℃");

        var weathericonUrl =
          '<img src= "http://openweathermap.org/img/wn/'
          + WeatherResult.weather[0].icon +
          '.png" alt="' + WeatherResult.weather[0].description + '"/>';
        $('.icon3').html(weathericonUrl);

        $("#demo").html("선택한 위치: " + selectedLocation.name + ", 위도: " + selectedLocation.latitude + ", 경도: " + selectedLocation.longitude);
      }
    );
  }
    
  $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
    function (WeatherResult) {
      $('.SeoulNowtemp').append(WeatherResult.main.temp + " ℃");
      $('.SeoulLowtemp').append(WeatherResult.main.temp_min + " ℃");
      $('.SeoulHightemp').append(WeatherResult.main.temp_max + " ℃");

      var weathericonUrl =
        '<img src= "http://openweathermap.org/img/wn/'
        + WeatherResult.weather[0].icon +
        '.png" alt="' + WeatherResult.weather[0].description + '"/>';
      $('.SeoulIcon').html(weathericonUrl);
    }
  );
    
  function weatherCheck2() {
    navigator.geolocation.getCurrentPosition(accessToGeo2)
  }
    
  function accessToGeo2(position) {
    const positionObj = {
      latitude: position.coords.latitude,
      longitude: position.coords.longitude
    }
    
    let lot = "(현재위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
    $("#demo").text(lot);
    
    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+position.coords.latitude+'&lon='+position.coords.longitude+'&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
      function (WeatherResult) {
        $(".dispForm2").show();
       
        $('.nowtemp').html("현재기온 : " + WeatherResult.main.temp + " ℃");
        $('.lowtemp').html("최저기온 : " + WeatherResult.main.temp_min + " ℃");
        $('.hightemp').html("최고기온 : " + WeatherResult.main.temp_max + " ℃");

        var weathericonUrl =
          '<img src= "http://openweathermap.org/img/wn/'
          + WeatherResult.weather[0].icon +
          '.png" alt="' + WeatherResult.weather[0].description + '"/>';
        $('.icon2').html(weathericonUrl);
      }
    );
  }
    
  let jiyuk = "";
  function weatherCheck3() {
    jiyuk = document.getElementById("jiyuk").value.split("/");
    
    navigator.geolocation.getCurrentPosition(accessToGeo3);
  }

  function accessToGeo3(position) {
    const positionObj = {
      latitude: jiyuk[1],
      longitude: jiyuk[2]
    }
    
    let lot = "(선택위치) 위도 : "+positionObj.latitude+" , 경도 : " + positionObj.longitude;
    $("#demo").text(lot);
    
    $.getJSON('https://api.openweathermap.org/data/2.5/weather?lat='+positionObj.latitude+'&lon='+positionObj.longitude+'&appid=65ca1bf676bce62e479d5baca260497c&units=metric',
      function (WeatherResult) {
        $(".dispForm3").show();
        $('.jiyukName').html(jiyuk[0]);
        $('.nowTempl').html('현재기온:'+WeatherResult.main.temp + " ℃");
        $('.lowTempl').text('최저기온:'+WeatherResult.main.temp_min + " ℃");
        $('.highTempl').text('최고기온:'+WeatherResult.main.temp_max + " ℃");

        var weathericonUrl =
          '<img src= "http://openweathermap.org/img/wn/'
          + WeatherResult.weather[0].icon +
          '.png" alt="' + WeatherResult.weather[0].description + '"/>';
        $('.icon3').html(weathericonUrl);
      }
    );
  }

   // 지도 관련 스크립트
   $(document).ready(function() {
    var mapContainer = document.getElementById('map'),
    mapOption = {
      center: new kakao.maps.LatLng(36.63508163115122, 127.45948750459904),
      level: 3
    };

    //var map = new kakao.maps.Map(mapContainer, mapOption);
    var ps = new kakao.maps.services.Places();

    ps.keywordSearch('${address}', placesSearchCB); 

    function placesSearchCB(data, status, pagination) {
      if (status === kakao.maps.services.Status.OK) {
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
          displayMarker(data[i]);    
          bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        map.setBounds(bounds);
      } 
    }
		
    function displayMarker(place) {
      var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
      });

      kakao.maps.event.addListener(marker, 'click', function() {
        $("#selectAddress").val(place.place_name);
        $("#latitude").val(place.y);
        $("#longitude").val(place.x);
        $("#demo").html("장소명:"+place.place_name+" , 위도:"+place.y+" , 경도:"+place.x);
        
        selectedLocation = {
          name: place.place_name,
          latitude: place.y,
          longitude: place.x
        };
      });
    }
  });
   function addressSearch() {
  	let address = myform.address1.value;
  	if(address == "") {
  		alert("검색할 지점을 선택하세요");
  		return false;
  	}
  	myform.submit();
  } 
  
  </script>
  
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container-fluid">
  <div class="row">
    <!-- 왼쪽: 지도 -->
    <div class="col-md-8">
      <h2>검색하신 위치(${address})</h2>
      <hr/>
      <form name="myform">
        <div>키워드검색 :
          <input type="text" name="address" id="address" autofocus required />
          <input type="submit" value="키워드 검색" class="pretty-button"/>
          <div id="demo"></div>
        </div>
        <div class="select-wrapper">
  				<select name="address" id="address1">
   				 <option value="">지역선택</option>
    				<c:forEach var="aVo" items="${addressVos}">
      				<option value="${aVo.address}" <c:if test="${aVo.address == vo.address}">selected</c:if>>${aVo.address}</option>
   			 		</c:forEach>
  				</select>
				</div>
				<input type="button" value="지점선택" onclick="addressSearch()" class="pretty-button"/>
        <input type="hidden" name="selectAddress" id="selectAddress" />
        <input type="hidden" name="latitude" id="latitude" />
        <input type="hidden" name="longitude" id="longitude" />
      </form>
      <hr/>
		      <p style="margin-top:-12px">
		    <em class="link">
		        <a href="/web/documentation/#CategoryCode" target="_blank">카테고리 코드목록을 보시려면 여기를 클릭하세요!</a>
		    </em>
			</p>
			<div class="map_wrap">
			    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			    <ul id="category">
			        <li id="BK9" data-order="0"> 
			            <span class="category_bg bank"></span>
			            은행
			        </li>       
			        <li id="MT1" data-order="1"> 
			            <span class="category_bg mart"></span>
			            마트
			        </li>  
			        <li id="PM9" data-order="2"> 
			            <span class="category_bg pharmacy"></span>
			            약국
			        </li>  
			        <li id="OL7" data-order="3"> 
			            <span class="category_bg oil"></span>
			            주유소
			        </li>  
			        <li id="CE7" data-order="4"> 
			            <span class="category_bg cafe"></span>
			            카페
			        </li>  
			        <li id="CS2" data-order="5"> 
			            <span class="category_bg store"></span>
			            편의점
			        </li>      
			    </ul>
			</div>
    </div>
    
    <!-- 오른쪽: 날씨 정보 -->
    <div class="col-md-4">
      <h2>날씨정보 확인하기</h2>
      <hr/>
     	<input type="button" value="마크표시 날씨" onclick="weatherCheck1()" class="pretty-button success"/>
			<input type="button" value="현재위치날씨" onclick="weatherCheck2()" class="pretty-button info"/>
      <hr/>
      <div id="demo"></div>
      <hr/>
      <div class="weather-cards">
        <div class="card weather-card">
          <div class="SeoulIcon"></div>
          <div class="card-body">
            <h4 class="card-title">서울</h4>
            <p class="card-text SeoulNowtemp">현재기온:</p>
            <p class="card-text SeoulLowtemp">최저기온:</p>
            <p class="card-text SeoulHightemp">최고기온:</p>
          </div>
        </div>
        <div class="card weather-card dispForm2" style="display:none;">
          <div class="icon2"></div>
          <div class="card-body">
            <h4 class="card-title">현재위치</h4>
            <p class="card-text nowtemp">현재기온:</p>
            <p class="card-text lowtemp">최저기온:</p>
            <p class="card-text hightemp">최고기온:</p>
          </div>
        </div>
        <div class="card weather-card dispForm3" style="display:none;">
          <div class="icon3"></div>
          <div class="card-body">
            <h4 class="card-title jiyukName"></h4>
            <p class="card-text nowTempl">현재기온:</p>
            <p class="card-text lowTempl">최저기온:</p>
            <p class="card-text highTempl">최고기온:</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25842eaa8d7542aca1b754697717a5ab&libraries=services"></script> 
<!-- 검색어로 검색된 지역을 출력시켜줄 스크립트 앞쪽('kakaoEx3.jsp의 스크립트')에 기술후, 그 아래 '카테고리별 장소 검색하기'스크립트 처리한다.(화면 검색후 주변처리해야하기때문..) --> 
	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(36.635094996846895, 127.4595267180685), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	
		// 앞에서 작업한 kakaoEx3.jsp의 스크립트부분을 똑같이 복사해서 작업처리했다.
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		// 키워드로 장소를 검색합니다
		ps.keywordSearch('${address}', placesSearchCB); 

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}

		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });

		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        //infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        //infowindow.open(map, marker);
		        
		        $("#selectAddress").val(place.place_name);
		        $("#latitude").val(place.y);
		        $("#longitude").val(place.x);
		        $("#demo").html("장소명:"+place.place_name+" , 위도:"+place.y+" , 경도:"+place.x);
		    });
		} 
	</script>
	
	<!-- 주변지역의 검색지점을 표출시켜줄 스크립트를 뒤쪽에 기술해준다.(샘플 : '카테고리별 장소 검색하기') -->
  <script>
		//마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
	  var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
	      contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
	      markers = [], // 마커를 담을 배열입니다
	      currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
	   
	  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	      mapOption = {
	          center: new kakao.maps.LatLng(36.63508163115122, 127.45948750459904), // 지도의 중심좌표
	          level: 5 // 지도의 확대 레벨
	      };  
	
	  // 지도를 생성합니다    
	  var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	  // 장소 검색 객체를 생성합니다
	  var ps = new kakao.maps.services.Places(map); 
	
	  // 지도에 idle 이벤트를 등록합니다
	  kakao.maps.event.addListener(map, 'idle', searchPlaces);
	
	  // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	  contentNode.className = 'placeinfo_wrap';
	
	  // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	  // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
	  addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	  addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
	
	  // 커스텀 오버레이 컨텐츠를 설정합니다
	  placeOverlay.setContent(contentNode);  
	
	  // 각 카테고리에 클릭 이벤트를 등록합니다
	  addCategoryClickEvent();
	
	  // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	  function addEventHandle(target, type, callback) {
	      if (target.addEventListener) {
	          target.addEventListener(type, callback);
	      } else {
	          target.attachEvent('on' + type, callback);
	      }
	  }
	
	  // 카테고리 검색을 요청하는 함수입니다
	  function searchPlaces() {
	      if (!currCategory) {
	          return;
	      }
	      
	      // 커스텀 오버레이를 숨깁니다 
	      placeOverlay.setMap(null);
	
	      // 지도에 표시되고 있는 마커를 제거합니다
	      removeMarker();
	      
	      ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
	  }
	
	  // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	  function placesSearchCB(data, status, pagination) {
	      if (status === kakao.maps.services.Status.OK) {
	
	          // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	          displayPlaces(data);
	      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	          // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요
	
	      } else if (status === kakao.maps.services.Status.ERROR) {
	          // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	          
	      }
	  }
	
	  // 지도에 마커를 표출하는 함수입니다
	  function displayPlaces(places) {
	
	      // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
	      // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
	      var order = document.getElementById(currCategory).getAttribute('data-order');
	
	      
	
	      for ( var i=0; i<places.length; i++ ) {
	
	              // 마커를 생성하고 지도에 표시합니다
	              var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
	
	              // 마커와 검색결과 항목을 클릭 했을 때
	              // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	              (function(marker, place) {
	                  kakao.maps.event.addListener(marker, 'click', function() {
	                      displayPlaceInfo(place);
	                  });
	              })(marker, places[i]);
	      }
	  }
	
	  // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	  function addMarker(position, order) {
	      var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	          imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
	          imgOptions =  {
	              spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
	              spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	              offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	          },
	          markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	              marker = new kakao.maps.Marker({
	              position: position, // 마커의 위치
	              image: markerImage 
	          });
	
	      marker.setMap(map); // 지도 위에 마커를 표출합니다
	      markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	      return marker;
	  }
	
	  // 지도 위에 표시되고 있는 마커를 모두 제거합니다
	  function removeMarker() {
	      for ( var i = 0; i < markers.length; i++ ) {
	          markers[i].setMap(null);
	      }   
	      markers = [];
	  }
	
	  // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
	  function displayPlaceInfo (place) {
	      var content = '<div class="placeinfo">' +
	                      '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   
	
	      if (place.road_address_name) {
	          content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
	                      '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
	      }  else {
	          content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
	      }                
	     
	      content += '    <span class="tel">' + place.phone + '</span>' + 
	                  '</div>' + 
	                  '<div class="after"></div>';
	
	      contentNode.innerHTML = content;
	      placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
	      placeOverlay.setMap(map);  
	  }
	
	
	  // 각 카테고리에 클릭 이벤트를 등록합니다
	  function addCategoryClickEvent() {
	      var category = document.getElementById('category'),
	          children = category.children;
	
	      for (var i=0; i<children.length; i++) {
	          children[i].onclick = onClickCategory;
	      }
	  }
	
	  // 카테고리를 클릭했을 때 호출되는 함수입니다
	  function onClickCategory() {
	      var id = this.id,
	          className = this.className;
	
	      placeOverlay.setMap(null);
	
	      if (className === 'on') {
	          currCategory = '';
	          changeCategoryClass();
	          removeMarker();
	      } else {
	          currCategory = id;
	          changeCategoryClass(this);
	          searchPlaces();
	      }
	  }
	
	  // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
	  function changeCategoryClass(el) {
	      var category = document.getElementById('category'),
	          children = category.children,
	          i;
	
	      for ( i=0; i<children.length; i++ ) {
	          children[i].className = '';
	      }
	
	      if (el) {
	          el.className = 'on';
	      } 
	  } 
  </script>
</body>
</html>