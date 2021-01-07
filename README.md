# HappyHouse
아파트 정보 및 주변 상권 정보 조회 웹 서비스

### :octocat: 설명
집 정보 뿐 아니라 집 주변 다양한 요소에 대해 정보를 얻고 싶을 때 사용할 수 있는 고객 맞춤형 서비스를 제공하는 웹서비스입니다.
서울 지역의 건물 정보를 제공하며 해당 건물 주위 상권 정보도 함께 제공합니다. 
고객의 관심지역 내 건물 중 취향을 파악하여 건물을 추천해주고 고객은 나만의 찜 목록을 통해 원하는 목록을 관리할 수 있습니다.
뿐만 아니라 코로나 19 관련 선별진료소와 국민안심병원 리스트를 제공합니다.

### :octocat: 개발환경
+ Java 1.8 (openJDK)
+ Spring Boot 2.3.5
+ Maven
+ mybatis

### :octocat: 스크린샷
#### <메인화면>
<img src="https://user-images.githubusercontent.com/37521568/103904821-25924880-5141-11eb-9a1c-6d3e422c4fb4.gif" width="800" height="500">
사이트에 접속했을 때 볼 수 있는 첫 화면입니다. 깔끔한 색상 조합과 심플한 인터페이스로 고객친화적인 UI를 제공합니다.

#### <로그인>
<img src="https://user-images.githubusercontent.com/37521568/103906243-009ed500-5143-11eb-8ecf-eca77ae895d4.gif" width="800" height="500">
로그인 화면입니다. signup을 눌러 간편하게 회원가입이 가능하고 signin에서 일반로그인과 페이스북, 카카오 ID를 이용한 소셜로그인이 가능합니다. 
회원가입시 유효성 검사를 실시하고 로그인 화면에서 비밀번호 찾기가 가능합니다.
로그인 후 마이페이지에서 회원정보 확인 및 수정, 탈퇴, 찜목록 확인이 가능합니다.

#### <게시판>
+ 공지사항 게시판
<img src="https://user-images.githubusercontent.com/37521568/103907927-3fce2580-5145-11eb-97d9-f3d8c50206c2.gif" width="800" height="500">
관리자로 로그인했을 때만 글 작성이 가능합니다. 단순한 CRUD 기능이 구현되어 있습니다.

+ QnA 게시판
<img src="https://user-images.githubusercontent.com/37521568/103907953-49578d80-5145-11eb-87d0-82e8c6dc8a0d.gif" width="800" height="500">
한단계 업그레이드해서 비밀글 기능이 추가되었습니다. 관리자만 답변을 작성할 수 있고 게시글 목록에서 답변 여부를 확인할 수 있습니다.

+ 자유 게시판
<img src="https://user-images.githubusercontent.com/37521568/103907993-54122280-5145-11eb-8162-4aa114d97285.gif" width="800" height="500">
댓글 기능이 추가되었습니다. 

#### <매물목록>
<img src="https://user-images.githubusercontent.com/37521568/103911527-802fa280-5149-11eb-9fd9-342d6a2910b7.gif" width="800" height="500">
메인화면에서 집보러가기를 클릭하면 매물목록을 확인할 수 있습니다.
검색필터와 검색어를 설정해 매물 검색이 가능하며 매물 이름을 클릭하면 주변 상권정보를 보여주고 지도에 매물 위치와 상권 위치를 띄웁니다.
해당 매물의 연간 거래가내역을 확인할 수 있으며 매물을 찜하여 찜목록에 넣을 수 있습니다.

#### <관심지역>
<img src="https://user-images.githubusercontent.com/37521568/103912244-5f1b8180-514a-11eb-844d-6de6277a9103.gif" width="800" height="500">
관심지역을 설정하면 해당 지역의 매물목록을 확인할 수 있으며 필터를 통해 조건 검색이 가능하고 비슷한 취향의 다른 매물을 추천해줍니다.

#### <찜목록>
<img src="https://user-images.githubusercontent.com/37521568/103912773-0ef0ef00-514b-11eb-9e00-f3171a48d0d2.gif" width="800" height="500">
마이페이지에서 찜목록으로 이동할 수 있습니다. 찜목록에서는 구역별로 찜한 매물을 확인할 수 있고 매물을 클릭하면 
상세정보를 확인할 수 있으며 두 매물을 선택해 비교해볼 수 있습니다.

### :octocat: 결과물
+ 설계서
+ UCC
