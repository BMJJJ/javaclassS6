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
  <title>boardContent.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      font-family: "Karma", sans-serif !important;
      background-color: #f8f9fa;
      color: #495057;
    }
    .container {
      background-color: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 30px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }
    h2 {
      color: #2c3e50;
      text-align: center;
      margin-bottom: 30px;
    }
    .table {
      background-color: #fff; 
      border-radius: 10px;
      overflow: hidden;
    }
    th {
      background-color: #e8f5e9;
      text-align: center;
    }
    .btn-nature {
      background-color: #4CAF50;
      color: white;
      border: none;
    }
    .btn-nature:hover {
      background-color: #45a049;
    }
    .pagination .page-link {
      color: #4CAF50;
    }
    .pagination .page-item.active .page-link {
      background-color: #4CAF50;
      border-color: #4CAF50;
    }
    .search-form {
      background-color: #e8f5e9;
      padding: 20px;
      border-radius: 10px;
      margin-top: 20px;
    }
    .modal-header {
      background-color: #4CAF50;
      color: white;
    }
    .footer {
      background-color: #2c3e50;
      color: #ecf0f1;
      padding: 20px 0;
      margin-top: 30px;
    }
    .content-img {
      max-width: 100%;
      height: auto;
    }
  </style>
  <script>
    'use strict';
    
    function boardDelete() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "boardDelete?idx=${vo.idx}";
    }
    
    function goodCheck() {
        $.ajax({
            url  : "${ctp}/board/boardGoodCheck",
            type : "post",
            data : {idx : ${vo.idx}},
            success:function(res) {
                if(res == "1") {
                    alert("좋아요를 눌렀습니다.");
                    location.reload();
                }
                else if(res == "2") {
                    alert("좋아요를 취소했습니다.");
                    location.reload();
                }
                else {
                    alert("오류가 발생했습니다.");
                }
            },
            error : function() {
                alert("전송오류");
            }
        });
    }
    
    // 신고시 '기타'항목 선택시에 textarea 보여주기
    function etcShow() {
    	$("#complaintTxt").show();
    }
    
    // 신고화면 선택후 신고사항 전송하기
    function complaintCheck() {
    	if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
    		alert("신고항목을 선택하세요");
    		return false;
    	}
    	//if($("input[type=radio][id=complaint7]:checked") && $("#complaintTxt").val() == "")
    	if($("input[type=radio]:checked").val() == '기타' && $("#complaintTxt").val() == "") {
    		alert("기타 사유를 입력해 주세요.");
    		return false;
    	}
    	
    	let cpContent = modalForm.complaint.value;
    	if(cpContent == '기타') cpContent += '/' + $("#complaintTxt").val();
    	
    	//alert("신고내용 : " + cpContent);
    	let query = {
    			part   : 'board',
    			partIdx: ${vo.idx},
    			cpMid  : '${sMid}',
    			cpContent : cpContent
    	}
    	
    	$.ajax({
    		url  : "${ctp}/board/boardComplaintInput",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("신고 되었습니다.");
    				location.reload();
    			}
    			else alert("신고 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
   		});
    }
    
    // 원본글에 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		$("#content").focus();
    		return false;
    	}
    	let openSw = $('input[name="openSw"]:checked').val();
    	let query = {
    			boardIdx 	: ${vo.idx},
    			mid				: '${sMid}',
    			nickName	: '${sNickName}',
    			hostIp    : '${pageContext.request.remoteAddr}',
    			content		: content,
    			openSw 		: openSw
    	}
    	
    	$.ajax({
    		url  : "${ctp}/board/boardReplyInput",
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
    if (!ans) return false;

    $.ajax({
        url: "${ctp}/board/boardReplyDelete",
        type: "post",
        data: { idx: idx },
        success: function(res) {
            if (res != "0") {
                alert("댓글이 삭제되었습니다.");
                location.reload();
            } else {
                alert("삭제 실패~~");
            }
        },
        error: function() {
            alert("전송 오류!");
        }
    });
	}
    
    
    // 처음에는 대댓글 '닫기'버튼은 보여주지 않는다.
    $(function(){
    	$(".replyCloseBtn").hide();
    });
    
    // 대댓글 입력버튼 클릭시 입력박스 보여주기
    function replyShow(idx) {
    	$("#replyShowBtn"+idx).hide();
    	$("#replyCloseBtn"+idx).show();
    	$("#replyDemo"+idx).slideDown(100);
    }
    
    // 대댓글 박스 감추기
    function replyClose(idx) {
    	$("#replyShowBtn"+idx).show();
    	$("#replyCloseBtn"+idx).hide();
    	$("#replyDemo"+idx).slideUp(300);
    }
    
    // 대댓글(부모댓글의 답변글)의 입력처리
    function replyCheckRe(idx, re_step, re_order) {
    	let content = $("#contentRe"+idx).val();
    	if(content.trim() == "") {
    		alert("답변글을 입력하세요");
    		$("#contentRe"+idx).focus();
    		return false;
    	}
    	let openSw = $('input[name="openSw"]:checked').val();
    	let query = {
    			boardIdx : ${vo.idx},
    			re_step : re_step,
    			re_order : re_order,
    			mid      : '${sMid}',
    			nickName : '${sNickName}',
    			hostIp   : '${pageContext.request.remoteAddr}',
    			content  : content,
    			openSw 		: openSw
    	}
    	
    	$.ajax({
    		url  : "${ctp}/board/boardReplyInputRe",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("답변글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("답변글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">To.us</h2>
  <!-- <table class="table table-bordered"> -->
  <table class="table table-borderless">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate, 0, 16)}</td>
    </tr>
    <tr>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">
        ${vo.title}/
        <a href="javascript:goodCheck()">
		    	<i class="fa-<c:choose><c:when test="${isLiked}">solid</c:when><c:otherwise>regular</c:otherwise></c:choose> fa-moon text-warning" title="좋아요 선택"></i>
		  	</a> ${vo.good}
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4">
        <div class="row">
	        <div class="col">
	        	<c:if test="${empty flag}"><input type="button" value="돌아가기" onclick="location.href='boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-success" /></c:if>
	        	<c:if test="${!empty flag}"><input type="button" value="돌아가기" onclick="location.href='boardSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-outline-dark" /></c:if>
	        </div>
	        <c:if test="${sNickName == vo.nickName || sLevel == 0}">
		        <div class="col text-right">
	        		<c:if test="${complaint == 'OK'}"><font color='red'><b>현재 이글은 신고중입니다.</b></font></c:if>
			        <input type="button" value="수정" onclick="location.href='boardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-primary" />
			        <input type="button" value="삭제" onclick="boardDelete()" class="btn btn-outline-danger text-right" />
		        </div>
	        </c:if>
	        <c:if test="${sNickName != vo.nickName}">
		        <div class="col text-right">
		          <c:if test="${vo.complaint == 'OK'}"><font color='red'><b>현재 이글은 신고중입니다.</b></font></c:if>
			        <c:if test="${vo.complaint != 'OK'}"><input type="button" value="신고하기" data-toggle="modal" data-target="#myModal" class="btn btn-danger text-right" /></c:if>
		        </div>
	        </c:if>
        </div>
      </td>
    </tr>
  </table>
  <hr/>
  <!-- 이전글/ 다음글 출력하기 -->
  <table class="table table-borderless">
    <tr>
      <td>
        <c:if test="${!empty nextVo.title}">
          ☝ <a href="boardContent?idx=${nextVo.idx}">다음글 : ${nextVo.title}</a><br/>
        </c:if>
        <c:if test="${!empty preVo.title}">
        	👇 <a href="boardContent?idx=${preVo.idx}">이전글 : ${preVo.title}</a><br/>
        </c:if>
      </td>
    </tr>
  </table>
</div>
<p><br/></p>

<!-- 댓글 처리(리스트/입력) -->
<div class="container">
	<!-- 댓글 리스트 보여주기 -->
	<table class="table table-hover text-center">
	  <tr>
	    <th>작성자</th>
	    <th>댓글내용</th>
	    <th>댓글일자</th>
	    <th>답글</th>
	  </tr>
	  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
	    <tr>
	      <td class="text-left">
	        <c:if test="${replyVo.re_step >= 1}">
	          <c:forEach var="i" begin="1" end="${replyVo.re_step}"> &nbsp;&nbsp;</c:forEach> └▶
	        </c:if>
	        ${replyVo.nickName}
	        <c:if test="${sMid == replyVo.mid || sLevel == 0}">
	          (<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제">x</a>)
	        </c:if>
	      </td>
	      <td class="text-left">
	      	<c:if test="${replyVo.openSw == 'NO' && !(sMid == replyVo.mid || sLevel == 0 || sNickName == vo.nickName || sNickName == replyVo.nickName)}">
        		<i>(비밀 댓글입니다.)</i>&nbsp;
        	</c:if>
        	<c:if test="${replyVo.openSw == 'OK' || preReplyNickName == sNickName || (replyVo.openSw == 'NO' && (sMid == replyVo.mid || sLevel == 0 || sNickName == vo.nickName || sNickName == replyVo.nickName))}">
	      		${fn:replace(replyVo.content, newLine, "<br/>")}
	      	</c:if>
	      </td>
	      <td>${fn:substring(replyVo.WDate, 0, 10)}</td>
	      <td>
	        <a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge badge-success">답글</a>
	        <a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge badge-warning replyCloseBtn">닫기</a>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="5" class="m-0 p-0">
	        <div id="replyDemo${replyVo.idx}" style="display:none">
	          <table class="table table-center">
	            <tr>
	              <td style="85%" class="text-left">답글내용 :
	                <textarea rows="4" name="contentRe" id="contentRe${replyVo.idx}" class="form-control">@${replyVo.nickName}</textarea>
	              </td>
	              <td style="15%">
	                <br/>
	                <c:if test="${replyVo.openSw == 'NO' && !(sMid == replyVo.mid || sLevel == 0 || sNickName == vo.nickName)}">
									    <i>(비밀 댓글입니다.)</i>
									</c:if>:${preReplyNickName}:
									<c:if test="${replyVo.openSw == 'OK' || preReplyNickName == sNickName || (replyVo.openSw == 'NO' && (sMid == replyVo.mid || sLevel == 0 || sNickName == vo.nickName || preReplyNickName == '말숙킥'))}">
									    <input type="button" value="답글달기" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-outline-secondary btn-sm"/>
									    <input type="radio" name="openSw" id="openSw1" value="OK" checked /> 공개 &nbsp;
									    <input type="radio" name="openSw" id="openSw2" value="NO" /> 비공개
									</c:if>
	              </td>
	            </tr>
	          </table>
	        </div>
	      </td>
	    </tr>
	    <c:set var="preReplyNickName" value="${replyVo.nickName}"/>
	  </c:forEach>
	  <tr><td colspan="4" class='m-0 p-0'></td></tr>
	</table>
	
	<!-- 댓글 입력창 -->
	<form name="replyForm">
	  <table class="table table-center">
	    <tr>
	      <td style="width:85%" class="text-left">
	        글내용 :
	        <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	      </td>
	      <td style="width:15%">
	        <br/>
	        <p>작성자 : ${sNickName}</p>
	        <p><input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-info btn-sm"/></p>
	        <input type="radio" name="openSw" id="openSw1" value="OK" checked /> 공개 &nbsp;
          <input type="radio" name="openSw" id="openSw2" value="NO" /> 비공개
	      </td>
	    </tr>
	  </table>
	</form>
	<br/>
</div>
<!-- 댓글 처리 -->

	<!-- 신고하기 폼 모달창 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">현재 게시글을 신고합니다.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <b>신고사유 선택</b>
          <hr/>
          <form name="modalForm">
            <div><input type="radio" name="complaint" id="complaint1" value="광고,홍보,영리목적"/> 광고,홍보,영리목적</div>
            <div><input type="radio" name="complaint" id="complaint2" value="욕설,비방,차별,혐오"/> 욕설,비방,차별,혐오</div>
            <div><input type="radio" name="complaint" id="complaint3" value="불법정보"/> 불법정보</div>
            <div><input type="radio" name="complaint" id="complaint4" value="음란,청소년유해"/> 음란,청소년유해</div>
            <div><input type="radio" name="complaint" id="complaint5" value="개인정보노출,유포,거래"/> 개인정보노출,유포,거래</div>
            <div><input type="radio" name="complaint" id="complaint6" value="도배,스팸"/> 도배,스팸</div>
            <div><input type="radio" name="complaint" id="complaint7" value="기타" onclick="etcShow()"/> 기타</div>
            <div id="etc"><textarea rows="2" id="complaintTxt" class="form-control" style="display:none"></textarea></div>
            <hr/>
            <input type="button" value="확인" onclick="complaintCheck()" class="btn btn-success form-control" />
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
  </div>
  
</body>
</html>
