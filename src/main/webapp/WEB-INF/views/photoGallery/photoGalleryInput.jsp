<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>photoGalleryInput.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
   /*  function fCheck() {
    	let fName = document.getElementById("file").value;
    	let ext = "";
    	let fileSize = 0;
    	let maxSize = 1024 * 1024 * 20;	// 기본 단위 : Byte,   1024 * 1024 * 20 = 20MByte 허용
    	
    	if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요");
    		return false;
    	}
    	
    	let fileLength = document.getElementById("file").files.length;	// 선택한 파일의 갯수
    	
    	for(let i=0; i<fileLength; i++) {
    		fName = document.getElementById("file").files[i].name;		// 선택된 1개의 파일이름가져오기
    		ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	    	fileSize = document.getElementById("file").files[i].size;
	    	if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
	    		alert("업로드 가능한 파일은 'jpg/gif/png'만 가능합니다.");
	    	}
    	}
    	
    	if(fileSize > maxSize) {
    		alert("업로드 파일의 최대용량은 20MByte입니다.");
    	}
    	else {
    		myform.submit();
    	}
    } */
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>사진파일 업로드</h2>
  <div>(Shift/Ctrl키를 사용하여 여러장의 사진을 업로드할수 있습니다.)</div>
  <hr/>
  <form name="myform" method="post" enctype="multipart/form-data">
    <div class="input-group mb-2">
      <div class="input-group-prepend input-group-text">분 류</div>
      <select name="part" id="part" class="form-control">
        <option value="풍경" selected>풍경</option>
        <option value="인물">인물</option>
        <option value="음식">음식</option>
        <option value="여행">여행</option>
        <option value="사물">사물</option>
        <option value="기타">기타</option>
      </select>
    </div>
    <div class="input-group mb-2">
      <div class="input-group-prepend input-group-text">제 목</div>
      <input type="text" name="title" id="title" class="form-control"/>
    </div>
    <div class="mb-2">
    	<textarea name="content" id="CKEDITOR" rows="6" class="form-control" required></textarea>
        <script>
          CKEDITOR.replace("content",{
        	  height:480,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",
        	  uploadUrl : "${ctp}/imageUpload"
          });
        </script>
    </div>
    <div class="row">
    	<div class="col"><input type="submit" value="이야기 공유하기" class="btn btn-outline-success mr-2"/></div>
    	<div class="col text-right"><input type="button" value="돌아가기" onclick="location.href='photoGalleryList';" class="btn btn-warning"/></div>
    </div>
    <input type="hidden" name="mid" value="${sMid}" />
    <input type="hidden" name="nickName" value="${sNickName}" />
  </form>
  <hr/>
</div>
<p><br/></p>
</body>
</html>