<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberPwdCheck.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      background-color: #f0f4f0;
      color: #343a40;
      font-family: 'Roboto', sans-serif;
    }
    .container {
      background-color: #ffffff;
      padding: 40px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border-radius: 12px;
      margin-top: 50px;
    }
    h2 {
      font-weight: 700;
      margin-bottom: 30px;
    }
    h5 {
      color: #6c757d;
      font-weight: 600;
    }
    .profile-img {
      border-radius: 50%;
      border: 3px solid #007bff;
      transition: transform 0.3s ease;
    }
    .profile-img:hover {
      transform: scale(1.05);
    }
    .stats p {
      font-size: 1.1rem;
      margin-bottom: 15px;
    }
    .table {
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }
    .table thead {
      background-color: #f1f3f5;
    }
    .activity-icon {
      font-size: 1.5rem;
      margin-right: 10px;
      color: #007bff;
    }
    .footer {
      margin-top: 40px;
      padding-top: 20px;
      border-top: 1px solid #dee2e6;
    }
    .badge {
      padding-top: 10px;
    	
    }
  </style>
  <script>
    'use strict';
    
    $(function(){
    	$("#pwdDemo").hide();
    });
    
    function pwdCheck() {
    	let pwd = $("#pwd").val().trim();
    	if(pwd == "") {
    		alert("현재 비밀번호를 입력하세요!");
    		$("#pwd").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/member/memberPwdCheck",
    		type : "post",
    		data : {
    			pwd : pwd,
    			mid : '${sMid}'
    		},
    		success:function(res) {
    			if(res != "0") {
    				if('${pwdFlag}' == 'p') {
    					$("#pwdDemo").show();
    					$("#pwdForm").hide();
    				}
    				else location.href = '${ctp}/member/memberUpdate';
    			}
    			else {
    				alert("비밀번호가 틀립니다. 확인해주세요");
    				$("#pwd").focus();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    function pwdChangeCheck() {
    	let pwdCheck = $("#pwdCheck").val();
    	let pwdCheckRe = $("#pwdCheckRe").val();
    	
    	if(pwdCheck.trim() == "" || pwdCheckRe.trim() == "") {
    		alert("변경할 비밀번호를 입력하세요");
    		$("#pwdCheck").focus();
    		return false;
    	}
    	else if(pwdCheck.trim() != pwdCheckRe.trim()) {
    		alert("새로 입력한 비밀번호가 틀립니다. 확인하세요");
    		$("#pwdCheck").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/member/memberPwdChangeOk",
    		type : "post",
    		data : {
    			pwd : pwdCheck,
    			mid : '${sMid}'
    		},
    		success:function(res) {
    			if(res != "0") {
    				alert('비밀번호가 변경되었습니다.\n다시 로그인 하세요');
    				location.href = '${ctp}/member/memberLogout';
    			}
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
<p><br/></p>
<div class="container">
  <form name="myform" id="pwdForm" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <td colspan="2">
          <h3>비밀번호 확인</h3>
          <div>(회원 정보 수정을 하기위해 현재 비밀번호를 확인합니다.)</div>
        </td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" class="form-control" autofocus required /></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="비밀번호확인" onclick="pwdCheck()" class="btn btn-success mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-info mr-2"/>
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-warning mr-2"/>
        </td>
      </tr>
    </table>
    <br/>
  </form>
  <div id="pwdDemo">
    <form name="pwdForm" method="post" action="MemberPwdChangeCheck.mem">
      <table class="table table-bordered">
        <tr>
          <td colspan="2" class="text-center">
            <h4>비밀번호 변경</h4>
          </td>
        </tr>
        <tr>
          <td>변경할 비밀번호를 입력하세요</td>
          <td><input type="password" name="pwdCheck" id="pwdCheck" class="form-control"/></td>
        </tr>
        <tr>
          <td>비밀번호 확인</td>
          <td><input type="password" name="pwdCheckRe" id="pwdCheckRe" class="form-control"/></td>
        </tr>
        <tr>
          <td colspan="2" class="text-center">
            <input type="button" value="비밀번호변경하기" onclick="pwdChangeCheck()" class="btn btn-secondary"/>
            <input type="reset" value="다시입력" class="btn btn-info mr-2"/>
            <input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-warning mr-2"/>
          </td>
        </tr>
      </table>
    </form>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
<p><br/></p>
</body>
</html>