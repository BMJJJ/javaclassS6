<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>산책로 - 자연과 함께하는 순간</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
body, h1, h2, h3, h4, h5, h6 {
    font-family: "Karma", sans-serif;
}
.w3-bar, h1, button {
    font-family: "Karma", sans-serif;
}
.nature-image {
    max-width: 100%;
    height: auto;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    transition: transform 0.3s ease-in-out;
}
.nature-image:hover {
    transform: scale(1.05);
}
.w3-quarter {
    padding: 16px;
}
.image-caption {
    background-color: rgba(255,255,255,0.8);
    padding: 10px;
    border-radius: 0 0 15px 15px;
}
.footer {
    background-color: #333;
    color: white;
    padding: 20px 0;
}
</style>
</head>
<body>
<!-- Navbar -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- Page content -->
<div class="w3-content" style="max-width:1100px;margin-top:80px;margin-bottom:80px">

  <div class="w3-panel">
    <h1><b>산책로에서 발견한 아름다운 순간들</b></h1>
    <p>자연과 함께하는 평화로운 시간, 그 순간을 공유합니다.</p>
  </div>

  <!-- Photo Grid -->
  <div class="w3-row-padding">
    <div class="w3-quarter">
      <img src="${ctp}/images/5.jpg" alt="숲길" class="nature-image">
      <div class="image-caption">
        <h3>고요한 숲길</h3>
        <p>아침 안개 속 숲길, 새로운 하루의 시작을 알립니다.</p>
      </div>
    </div>
    <div class="w3-quarter">
      <img src="${ctp}/images/2.jpg" alt="꽃길" class="nature-image">
      <div class="image-caption">
        <h3>봄의 향연</h3>
        <p>색색의 꽃들이 피어난 길, 봄의 생동감을 느껴보세요.</p>
      </div>
    </div>
    <div class="w3-quarter">
      <img src="${ctp}/images/122.jpg" alt="호수" class="nature-image">
      <div class="image-caption">
        <h3>호수의 잔잔함</h3>
        <p>잔잔한 호수에 비친 하늘, 마음의 평화를 찾아보세요.</p>
      </div>
    </div>
    <div class="w3-quarter">
      <img src="${ctp}/images/4.jpg" alt="단풍길" class="nature-image">
      <div class="image-caption">
        <h3>가을의 정취</h3>
        <p>붉게 물든 단풍길, 계절의 변화를 느껴보세요.</p>
      </div>
    </div>
  </div>

  <!-- Pagination -->
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
      <a href="#" class="w3-bar-item w3-button w3-hover-black">«</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">1</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">2</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">3</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">4</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">»</a>
    </div>
  </div>

  <hr>

  <!-- About Section -->
  <div class="w3-container w3-padding-32 w3-center">  
    <h2 class="w3-wide">산책로 이야기</h2>
    <p class="w3-opacity"><i>자연과 함께하는 우리들의 이야기</i></p>
    <p class="w3-justify">우리의 산책로는 단순한 길이 아닙니다. 그것은 우리의 일상에서 벗어나 자연과 소통하는 특별한 공간입니다. 
    이곳에서 우리는 계절의 변화를 느끼고, 새소리에 귀 기울이며, 바람의 숨결을 느낍니다. 
    때로는 고요히 명상을 하고, 때로는 활기차게 운동을 하며, 우리는 이 길에서 많은 것을 배우고 느낍니다. 
    여러분도 이 특별한 여정에 함께하시길 바랍니다.</p>
  </div>

  <jsp:include page="/WEB-INF/views/include/slide2.jsp" />

	<hr/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>

</body>
</html>
