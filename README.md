## 산책로 사이트

산책로 정보 공유 및 커뮤니티 사이트 
제작 기간: 2024.07.01 - 2024.08.01 (30일)
인원: 1인

사이트 링크 : [[산책로 사이트 링크}](http://49.142.157.251:9090/)

## 사용 기술 스택

<div>
  <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=OpenJDK&logoColor=white">
  <img src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=Spring&logoColor=white">
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=MySQL&logoColor=white">
  <img src="https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=CSS&logoColor=white">
  <img src="https://img.shields.io/badge/HTML-E34F26?style=for-the-badge&logo=HTML&logoColor=white">
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white">
</div>
<div>
  <img src="https://img.shields.io/badge/Selenium-43B02A?style=for-the-badge&logo=Selenium&logoColor=white">
  <svg role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>CKEditor 4</title><path d="M16.1237 3.7468a4.5092 4.5092 0 0 0-.469 2.009c0 2.5006 2.0271 4.5278 4.5278 4.5278a4.447 4.447 0 0 0 .0967-.001v6.3413a2.1307 2.1307 0 0 1-1.0654 1.8453l-8.0089 4.6239a2.1307 2.1307 0 0 1-2.1307 0l-8.0088-4.624A2.1307 2.1307 0 0 1 0 16.624V7.3761c0-.7613.4061-1.4647 1.0654-1.8453L9.0742.907a2.1307 2.1307 0 0 1 2.1307 0zM5.733 7.9753a.5327.5327 0 0 0-.5327.5327v.2542c0 .2942.2385.5327.5327.5327h8.9963a.5327.5327 0 0 0 .5327-.5327V8.508a.5327.5327 0 0 0-.5327-.5327zm0 3.281a.5327.5327 0 0 0-.5327.5326v.2542c0 .2942.2385.5327.5327.5327h6.5221a.5327.5327 0 0 0 .5327-.5327v-.2542a.5327.5327 0 0 0-.5327-.5327zm0 3.2809a.5327.5327 0 0 0-.5327.5327v.2542c0 .2942.2385.5326.5327.5326h8.9963a.5327.5327 0 0 0 .5327-.5326v-.2542a.5327.5327 0 0 0-.5327-.5327zm14.5383-5.1414c-2.0593 0-3.7287-1.6694-3.7287-3.7288 0-2.0593 1.6694-3.7287 3.7287-3.7287S24 3.6077 24 5.667c0 2.0594-1.6694 3.7288-3.7288 3.7288zm.6347-2.7825h.393v-.5904h-.397V4.139h-.8144l-1.1668 1.8623v.612H20.27v.5991h.636zm-.632-1.7277v1.1373h-.6928l.6807-1.1373Z"/></svg>
</div>
* HTML/CSS/JavaScript
* 그외 : Kakao Maps API / SweetAlert2 / CKEditor4 / 날씨 API / 구글 CHART

## 구현 기능

* **회원 관련**
   * 로그인, 로그아웃, 회원가입, 회원탈퇴
   * ID찾기
   * 비밀번호 재발급 - 이메일 전송
   * MyPage(예약 내역,방명록 쓴글 게시판 쓴글)

* **산책로 정보**
   * 산책로 목록 및 상세 정보
   * 지도 기반 산책로 표시
   * 버튼 페이징
   * 거리순, 인기순, 평점순 정렬
   * 리뷰 CRUD

* **커뮤니티**
   * 자유게시판 CRUD
   * 방명록 CRUD
   * 포토 갤러리 CRUD

* **날씨 정보**
   * 현재 위치 기반 날씨 정보 제공
   * 산책로 날씨씨

* **관리자 페이지 관련**
   * 회원관리
   * 산책로 관리
   * 커뮤니티 관리
   * 문의 / 공지 관리

## 주요 페이지 구성

* **메인 페이지**
   * 상단 : 최신 공지사항 
   * 계절별 사진
   * 산책하며 듣기 좋은 노래

* **로그인 / 회원가입 / 아이디찾기 / 비밀번호찾기**
   * 프론트 유효성 검사
   * BYCRYPT 사용 비밀번호

* **MyPage**
   * 산책 기록 조회 / 회원정보
   * 포인트 / 리뷰
   * 즐겨찾기 관리

* **산책로 정보**
   * 버튼 페이징
   * 즐겨찾기 추가
   * 리뷰 작성 및 조회

* **관리자 페이지 기능**
   * [회원 관리] 회원정보, 활동 내역
   * [산책로 관리] 산책로 정보 CRUD
   * [커뮤니티 관리] 게시글, 댓글 관리
   * [리뷰 관리] 리뷰 승인 및 삭제
   * [통계] 사용자 통계, 산책로 이용 통계

* **기타**
   * 자동화 처리 (일일 날씨 정보 업데이트, 주간 인기 산책로 선정) - Spring Scheduler
   * 산책 거리 측정 기능
 
     ![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=BMJJJ&layout=compact)
