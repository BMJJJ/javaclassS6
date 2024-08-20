## 산책로 사이트

산책로 정보 공유 및 커뮤니티 사이트 
제작 기간: 2024.07.01 - 2024.08.01 (30일)
인원: 1인

사이트 링크 : [[산책로 사이트 링크}](http://49.142.157.251:9090/)

## 사용 기술 스택

<div>
  
  <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=OpenJDK&logoColor=white">
  <img src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=Spring&logoColor=white">
</div>

* MySQL
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
