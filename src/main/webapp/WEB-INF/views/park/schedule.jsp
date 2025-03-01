<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>schedule.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <style>
    #td1,#td8,#td15,#td22,#td29,#td36 {color:red}
    #td7,#td14,#td21,#td28,#td35 {color:blue}
    .today {
      background-color: pink;
      color: #fff;
      font-weight: bolder;
    }
    td {
      text-align: left;
      vertical-align: top;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="text-center">
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="이전년도">◁◁</button>
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="이전월">◀</button>
    <font size="5">${yy}년 ${mm+1}월</font>
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="다음월">▶</button>
    <button type="button" onclick="location.href='${ctp}/park/schedule?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="다음년도">▷▷</button>
    &nbsp;&nbsp;
    <button type="button" onclick="location.href='${ctp}/park/schedule';" class="btn btn-secondary btn-sm" title="오늘날짜"><i class="fa fa-home"></i></button>
  </div>
  <br/>
  <div class="text-center">
    <table class="table table-bordered" style="height:450px">
      <tr class="text-center" style="background-color:#eee">
        <th style="width:13%; color:red; vertical-align:middle">일</th>
        <th style="width:13%; vertical-align:middle">월</th>
        <th style="width:13%; vertical-align:middle">화</th>
        <th style="width:13%; vertical-align:middle">수</th>
        <th style="width:13%; vertical-align:middle">목</th>
        <th style="width:13%; vertical-align:middle">금</th>
        <th style="width:13%; color:blue; vertical-align:middle">토</th>
      </tr>
      <tr>
        <c:set var="cnt" value="${1}"/>
        <!-- 시작일 이전의 공백을 이전달의 날짜로 채워준다. -->
        <c:forEach var="preDay" begin="${preLastDay-(startWeek-2)}" end="${preLastDay}">
          <td style="color:#ccc;font-size:0.6em">${prevYear}-${prevMonth+1}-${preDay}</td>
          <c:set var="cnt" value="${cnt+1}"/>
        </c:forEach>
        
        <!-- 해당월에 대한 날짜를 마지막일자까지 반복 출력한다.(단, gap이 7이되면 줄바꿈한다.) -->
        <c:forEach begin="1" end="${lastDay}" varStatus="st">
          <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
          <td id="td${cnt}" ${todaySw==1 ? 'class=today' : ''} style="font-size:0.9em">
            <c:set var="ymd" value="${yy}-${mm+1}-${st.count}"/>
            
            <%-- <a href="scheduleMenu?ymd=${ymd}"> --%><a href="${ctp}/park/parkList?ymd=${ymd}">${st.count}<br/>
              <c:forEach var="i" begin="0" end="${fn:length(nationalVos)-1}">
                <c:set var="nalja" value="${fn:substring(noneVos[i].noneDate,8,10)}"/>
                <c:set var="no" value="${nalja}"/>
 
 								
                <c:if test="${fn:substring(nalja,0,1) == '0'}"><c:set var="no" value="${fn:substring(nalja,1,2)}"/></c:if>
	
								 
                <c:if test="${st.count == no}">
	              	${nationalVos[i].part}|${nationalVos[i].partCnt}|${noneVos[i].partCnt}|(${nationalVos[i].partCnt - noneVos[i].partCnt})<br/>
                </c:if>
                <c:if test="${st.count != no}">
	              	${nationalVos[i].part}(${nationalVos[i].partCnt})<br/>
                </c:if>

              </c:forEach>
              
            
	              	<%-- ${nationalVos[i].part}(${nationalVos[i].partCnt - noneVos[i].partCnt})<br/> --%>
            
            
	           	<!-- 해당날짜에 일정이 있다면 part를 출력한다.(2023-11-22) -->
	           	<%-- 
	            <c:forEach var="vo" items="${vos}">
	              <c:if test="${fn:substring(vo.visitDate,8,10)==st.count}">
		               - ${vo.part}(${vo.partCnt})<br/> 
	              </c:if>
	            </c:forEach>
	             --%>
            </a>
          </td>
          <c:if test="${cnt % 7 == 0}"></tr><tr></c:if>  <!-- 한주가 꽉차면 줄바꾸기 한다. -->
          <c:set var="cnt" value="${cnt + 1}"/>
        </c:forEach>
        
        <!-- 마지막일 이후를 다음달의 일자로 채워준다. -->
        <c:if test="${nextStartWeek != 1}">
	        <c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay">
	          <td style="color:#ccc;font-size:0.6em">${nextYear}-${nextMonth+1}-${nextDay.count}</td>
	        </c:forEach>
        </c:if>
      </tr>
    </table>
  </div>
  <!-- 페이지네이션 -->
  <div class="d-flex justify-content-center">
    <ul class="pagination">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="boardList?pag=1&pageSize=${pageVO.pageSize}">처음</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="boardList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="boardList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="boardList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막</a></li></c:if>
    </ul>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>