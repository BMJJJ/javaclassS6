<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>photoGalleryContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    * {box-sizing: border-box;}
    body {
      font-family: "Karma", sans-serif;
      margin: 0;
      background-color: #f8f9fa;
      color: #343a40;
    }

    .container {
      max-width: 800px;
      margin: 2rem auto;
      padding: 2rem;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    h2 {
      color: #343a40;
      margin-bottom: 1.5rem;
      font-weight: 700;
    }

    .slideshow-container {
      position: relative;
      margin-bottom: 2rem;
    }

    .mySlides img {
      width: 100%;
      height: auto;
      border-radius: 5px;
    }

    .prev, .next {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      padding: 16px;
      color: white;
      font-weight: bold;
      font-size: 20px;
      transition: 0.3s ease;
      border-radius: 50%;
      user-select: none;
      background-color: rgba(0,0,0,0.3);
      text-decoration: none;
    }

    .next {right: 10px;}
    .prev {left: 10px;}

    .prev:hover, .next:hover {
      background-color: rgba(0,0,0,0.8);
    }

    .numbertext {
      color: #f2f2f2;
      font-size: 12px;
      padding: 8px 12px;
      position: absolute;
      top: 0;
    }

    .dot-container {
      text-align: center;
      padding: 10px 0;
    }

    .dot {
      cursor: pointer;
      height: 10px;
      width: 10px;
      margin: 0 4px;
      background-color: #bbb;
      border-radius: 50%;
      display: inline-block;
      transition: background-color 0.3s ease;
    }

    .active, .dot:hover {
      background-color: #3cb371;
    }

    .fade {
      animation-name: fade;
      animation-duration: 0.5s;
    }

    @keyframes fade {
      from {opacity: .4} 
      to {opacity: 1}
    }

    .btn {
      background-color: #3cb371;
      color: white;
      border: none;
      padding: 0.5rem 1rem 0.1rem;
      border-radius: 20px;
      transition: background-color 0.3s ease;
    }

    .btn:hover {
      background-color: #6b8e23;
    }

    /* 모달 스타일 */
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.4);
    }

    .modal-content {
      background-color: #fefefe;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
      max-width: 600px;
      border-radius: 10px;
    }

    .close {
      color: #aaa;
      float: right;
      font-size: 28px;
      font-weight: bold;
    }

    .close:hover,
    .close:focus {
      color: black;
      text-decoration: none;
      cursor: pointer;
    }

    #replyList {
      max-height: 300px;
      overflow-y: auto;
    }

    @media screen and (max-width: 600px) {
      .container {
        padding: 1rem;
      }
    }
    .instagram-comments {
  max-height: 400px;
  overflow-y: auto;
  margin-bottom: 20px;
}

.comment {
  margin-bottom: 15px;
  font-size: 14px;
}

.comment strong {
  font-weight: 600;
  margin-right: 5px;
}

.comment-actions {
  font-size: 12px;
  color: #8e8e8e;
  margin-top: 5px;
}

.delete-comment {
  color: #ed4956;
  margin-left: 10px;
}

.comment-input {
  border-top: 1px solid #dbdbdb;
  padding-top: 15px;
}

.comment-input form {
  display: flex;
}

.comment-input textarea {
  flex-grow: 1;
  border: none;
  resize: none;
  height: 18px;
  max-height: 80px;
  padding: 0;
  font-size: 14px;
}

.comment-input textarea:focus {
  outline: none;
}

.post-button {
  background: none;
  border: none;
  color: #0095f6;
  font-weight: 600;
  cursor: pointer;
}

.post-button:disabled {
  opacity: 0.3;
}

.modal-content {
  max-width: 500px;
  width: 90%;
}
  </style>    
  <script>
    'use strict';
    
    document.addEventListener('DOMContentLoaded', function() {
    	  const textarea = document.querySelector('.comment-input textarea');
    	  const postButton = document.querySelector('.post-button');

    	  textarea.addEventListener('input', function() {
    	    this.style.height = 'auto';
    	    this.style.height = (this.scrollHeight) + 'px';
    	    postButton.disabled = this.value.trim() === '';
    	  });
    	});
    
    function replyHide() {
      $("#replyHideBtn").hide();
      $("#replyShowBtn").show();
      $("#replyList").hide();
    }
    
    function replyShow() {
      $("#replyHideBtn").show();
      $("#replyShowBtn").hide();
      $("#replyList").show();
    }
    
    function replyInputShow() {
      $("#replyInput").toggle();
    }
    
    // 댓글달기
    function replyCheck() {
      let content = $("#content").val();
      if(content.trim() == "") {
        alert("댓글을 입력하세요");
        return false;
      }
      let query = {
        mid       : '${sMid}',
        photoIdx  : '${vo.idx}',
        content   : content
      }
      
      $.ajax({
        url  : "${ctp}/photogallery/photoGalleryReplyInput",
        type : "post",
        data : query,
        success:function(res) {
          if(res != "0") {
            alert("댓글이 입력되었습니다.");
            location.reload();
          }
          else alert("댓글 입력 실패~~");
        },
        error : function() {
          alert("전송 오류!");
        }
      });
    }
    
    // 댓글 삭제하기
    function replyDelete(idx) {
      let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        url  : "${ctp}/photogallery/photoGalleryReplyDelete",
        type : "post",
        data : {idx : idx},
        success:function(res) {
          if(res != "0") {
            alert("댓글이 삭제되었습니다.");
            location.reload();
          }
          else alert("삭제 실패~~");
        },
        error : function() {
          alert("전송 오류!");
        }
      });
    }
    
 // 좋아요 처리 및 취소
    function goodCheck() {
      $.ajax({
        url  : "${ctp}/photogallery/photoGalleryGoodCheck",
        type : "post",
        data : {idx : ${vo.idx}},
        /* data : {idx : idx}, */
        success:function(res) {
          if(res == "1") {
            alert("좋아요를 눌렀습니다.");
            location.reload();
          }
          else if(res == "2") {
            alert("좋아요를 취소했습니다.");
            location.reload();
          }
          else if(res == "0") {
            alert("오류가 발생했습니다.");
          }
        },
        error : function() {
          alert("전송오류");
        }
      });
    }
    
    // 모달 열기
    function openModal() {
      document.getElementById("replyModal").style.display = "block";
    }

    // 모달 닫기
    function closeModal() {
      document.getElementById("replyModal").style.display = "none";
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
      if (event.target == document.getElementById("replyModal")) {
        closeModal();
      }
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2>[${vo.part}] ${vo.title}</h2>
  <div class="row">
    <div class="col">
      ${vo.mid} | ${fn:substring(vo.PDate,0,16)} 
    </div>
    <div class="col text-right">
      <i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt} &nbsp;
      <i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.good} &nbsp;
      <i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum} &nbsp;
      <i class="fa-solid fa-layer-group" title="사진수"></i> ${vo.photoCount}
    </div>
  </div>
  <hr/>
  <div class="slideshow-container">
    <c:set var="imageCount" value="0" />
    <c:forEach var="item" items="${fn:split(vo.content, '\"')}">
      <c:if test="${fn:contains(item, '/javaclassS6/data/')}">
        <c:set var="imageCount" value="${imageCount + 1}" />
        <c:set var="imagePath" value="${fn:substringAfter(item, '/javaclassS6/')}" />
        <div class="mySlides">
          <img src="${ctp}/${imagePath}" alt="Photo ${imageCount}">
          <div class="numbertext">${imageCount} / ${vo.photoCount}</div>
        </div>
      </c:if>
    </c:forEach>
    <a class="prev" onclick="plusSlides(-1)">❮</a>
    <a class="next" onclick="plusSlides(1)">❯</a>
  </div>
  <div class="dot-container">
    <c:forEach var="i" begin="1" end="${vo.photoCount}" varStatus="st">
      <span class="dot" onclick="currentSlide(${i})"></span> 
    </c:forEach>
  </div>

  <div class="row mt-4">
    <div class="col">
      <button onclick="location.href='${ctp}/photoGallery/photoGalleryList';" class="btn">목록보기</button>
      <button onclick="openModal()" class="btn">댓글보기</button>
    </div>
    <div class="col text-right" style="font-size:22px">
      <a href="javascript:openModal()"><i class="fa-regular fa-pen-to-square" title="댓글쓰기"></i></a> ${vo.replyCnt} &nbsp;
      <a href="javascript:goodCheck()"><i class="fa-regular fa-face-grin-hearts text-danger" title="좋아요 선택"></i></a> ${vo.good}
    </div>
  </div>

  <!-- 댓글 모달 부분만 수정합니다 -->
<div id="replyModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h3>댓글 ${vo.replyCnt}개</h3>
    
    <div id="replyList" class="instagram-comments">
      <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
        <div class="comment">
          <strong>${replyVo.mid}</strong>
          <span>${fn:replace(replyVo.content,newLine,"<br/>")}</span>
          <div class="comment-actions">
            <span class="comment-date">${fn:substring(replyVo.prDate, 0, 10)}</span>
            <c:if test="${sMid == replyVo.mid || sLevel == 0}">
              <a href="javascript:replyDelete(${replyVo.replyIdx})" class="delete-comment">삭제</a>
            </c:if>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- 댓글 입력창 -->
    <div id="replyInput" class="comment-input">
      <form name="replyForm" onsubmit="return false;">
        <textarea name="content" id="content" placeholder="댓글 달기..."></textarea>
        <button type="button" onclick="replyCheck()" class="post-button">게시</button>
      </form>
    </div>
  </div>
</div>

      <div id="replyList">
        <!-- 댓글 리스트 보여주기 -->
        <table class="table table-hover">
          <thead>
            <tr class="table-secondary">
              <th>작성자</th>
              <th>댓글내용</th>
              <th>댓글일자</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
              <tr>
                <td>${replyVo.mid}
                  <c:if test="${sMid == replyVo.mid || sLevel == 0}">
                    (<a href="javascript:replyDelete(${replyVo.replyIdx})" title="댓글삭제">x</a>)
                  </c:if>
                </td>
                <td class="text-left">${fn:replace(replyVo.content,newLine,"<br/>")}</td>
                <td>${fn:substring(replyVo.prDate, 0, 10)}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>

<script>
let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
} 
</script>
</body>
</html>