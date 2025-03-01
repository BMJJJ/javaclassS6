<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberList.jsp</title>
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
    	$("#userDispaly").hide();
    	
    	$("#userInfor").on("click", function(){
    		if($("#userInfor").is(':checked')) {
    			$("#totalList").hide();
    			$("#userDispaly").show();
    		}
    		else {
    			$("#totalList").show();
    			$("#userDispaly").hide();
    		}
    	});
    });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<hr/>
<p><br/></p>
<p><br/></p>
<div class="container">
  <c:if test="${sLevel == 0}">
    <input type="checkbox" name="userInfor" id="userInfor" onclick="userCheck()" /> 비공개회원만보기/전체보기
  </c:if>
  <hr/>
  <div id="totalList">
	  <h3 class="text-center">전체 회원 리스트(총 ${fn:length(vos)}건)</h3>
	  <table class="table table-hover text-center">
	    <tr class="table-dark text-dark">
	      <th>번호</th>
	      <th>아이디</th>
	      <th>닉네임</th>
	      <th>성명</th>
	      <th>생일</th>
	      <th>성별</th>
	      <th>최종방문일</th>
	      <c:if test="${sLevel == 0}">
		      <th>오늘방문횟수</th>
		      <th>활동여부</th>
	      </c:if>
	    </tr>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
	      <c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
	        <c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청"/></c:if>
	        <c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중"/></c:if>
		      <tr>
		        <td>${st.count}</td>
		        <td><a href="MemberSearch.mem?mid=${vo.mid}">${vo.mid}</a></td>
		        <td>${vo.nickName}</td>
		        <td>${vo.name}</td>
		        <td>${fn:substring(vo.birthday,0,10)}</td>
		        <td>${vo.gender}</td>
		        <td>${fn:substring(vo.lastDate,0,10)}</td>
		        <c:if test="${sLevel == 0}">
			        <td>${vo.todayCnt}</td>
			        <td>
			          <c:if test="${vo.userDel == 'OK'}"><font color="red"><b>${active}</b></font></c:if>
			          <c:if test="${vo.userDel != 'OK'}">${active}</c:if>
			        </td>
		        </c:if>
		      </tr>
	      </c:if>
	    </c:forEach>
	    <tr><td colspan="9" class="m-0 p-0"></td></tr>
	  </table>
  </div>
  <div id="userDispaly">
    <c:if test="${sLevel == 0}">
		  <h3 class="text-center">비공개 회원 리스트</h3>
		  <table class="table table-hover text-center">
		    <tr class="table-dark text-dark">
		      <th>번호</th>
		      <th>아이디</th>
		      <th>닉네임</th>
		      <th>성명</th>
		      <th>생일</th>
		      <th>성별</th>
		      <th>최종방문일</th>
		      <th>오늘방문횟수</th>
		    </tr>
		    <c:forEach var="vo" items="${vos}" varStatus="st">
		      <c:if test="${vo.userInfor == '비공개'}">
			      <tr>
			        <td>${vo.idx}</td>
			        <td>${vo.mid}</td>
			        <td>${vo.nickName}</td>
			        <td>${vo.name}</td>
			        <td>${fn:substring(vo.birthday,0,10)}</td>
			        <td>${vo.gender}</td>
			        <td>${fn:substring(vo.lastDate,0,10)}</td>
			        <td>${vo.todayCnt}</td>
			      </tr>
		      </c:if>
		    </c:forEach>
		    <tr><td colspan="8" class="m-0 p-0"></td></tr>
		  </table>
	  </c:if>
  </div>
  <hr/>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</div>
<p><br/></p>
</body>
</html>