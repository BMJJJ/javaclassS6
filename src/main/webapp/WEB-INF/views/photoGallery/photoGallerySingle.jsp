<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>photoGallerySingle.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    // 무한 스크롤 구현(aJax처리)
    let lastScroll = 0;
    let curPage = 1;
    
    $(document).scroll(function(){
    	let currentScroll = $(this).scrollTop();			// 스크롤바 위쪽시작 위치, 처음은 0이다.
    	let documentHeight = $(document).height();		// 화면에 표시되는 전체 문서의 높이
    	let nowHeight = $(this).scrollTop() + $(window).height();	// 현재 화면상단 + 현재 화면높이
    	
    	// 스크롤이 아래로 내려갔을때 이벤트 처리..
    	if(currentScroll > lastScroll) {
    		if(documentHeight < (nowHeight + (documentHeight*0.05))) {
    			console.log("다음페이지 가져오기");
    			curPage++;
    			//getList(curPage);
    			$.ajax({
  	    		url  : "photoGallerySinglePaging",
  	    		type : "post",
  	    		data : {pag : curPage},
  	    		success:function(res) {
  	    			$("#list-wrap").append(res);
  	    		}
  	    	});
    		}
    	}
    	lastScroll = currentScroll;
    });
    
    // 화살표클릭시 화면 상단으로 부드럽게 이동하기
    $(window).scroll(function(){
    	if($(this).scrollTop() > 100) {
    		$("#topBtn").addClass("on");
    	}
    	else {
    		$("#topBtn").removeClass("on");
    	}
    	
    	$("#topBtn").click(function(){
    		window.scrollTo({top:0, behavior: "smooth"});
    	});
    });
  </script>
  <style>
		<style>
  .container {
    width: 1000px;
    margin: 0 auto;
  }
  
  .card {
    width: 100%;
    margin-bottom: 20px;
  }
  
  .image-container {
    width: 100%;
    overflow: hidden;
  }
  
  .image-container img {
    max-width: 100%;
    height: auto;
    display: block;
  }
</style>
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td colspan="2"><h2 class="text-center">포토 갤러리</h2></td>
    </tr>
    <tr>
      <td>
      </td>
      <td class="text-right">
        <input type="button" value="사진올리기" onclick="location.href='photoGalleryInput';" class="btn btn-success"/>
        <input type="button" value="여러장씩보기" onclick="location.href='photoGalleryList';" class="btn btn-info mr-2"/>
      </td>
    </tr>
  </table>
  <section id="list-wrap">
	  <c:forEach var="vo" items="${vos}" varStatus="st">
		  <div class="card mb-5">
		    <div class="card-body">
		      <b>번호:${vo.idx} / 분야:${vo.part} / 제목:${vo.title} / 사진수량:${vo.photoCount}</b><br/>
		      <div class="image-container">
		        ${vo.content}
		      </div>
		      <hr/>
		      <p>${vo.expl}</p>
		    </div>
		  </div>
		</c:forEach>
  </section>
</div>
<p style="clear:both;"><br/></p>
<!-- 위로가기 버튼 -->
<h6 id="topBtn" class="text-right mr-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동"/></h6>
</body>
</html>