# 실습 과제

## 와이어프레임

책 등록 화면|책 목록  화면
---|---
<img src=https://user-images.githubusercontent.com/39197978/164747403-a83cddde-d822-4bf5-9e56-ab62ac138b77.png width=300>|<img src=https://user-images.githubusercontent.com/39197978/164748503-9eb88df1-a568-4002-8554-d8f3c45eda4f.png width=275>


### 책 목록  화면  
 - 앱 재시작시 유지됩니다.
 - 로컬 저장소에서 로드시 3초가 걸림을 가정합니다. (비동기가 필요하므로)
 - 책 목록에서 삭제가 가능해야합니다.
 - 가격 합계가 노출 됩니다.   

### 책 등록 화면 
- 책 이름 / 카테고리 / 출판 일자 / 가격 정보를 입력 받습니다.
- 책는 책 이름 / 카테고리 / 출판 일자 / 가격 정보를 보여줍니다.
- 카테고리는 `소설`, `기술`, `경제`, `시집` 를 보여줍니다.
- 책 목록  화면에서 선택 시, 카테고리에 따라 다른 동작을 합니다.
    - `소설`를 누르면 - 핸드폰이 진동합니다.
    - `기술`를 누르면 - 뷰가 빨개졋다 돌아옵니다
    - `경제`를 누르면 - 아무일도 일어나지 않습니다.
    - `시집`를 누르면 - 알럿으로 "으악! 🧟" 이 표시됩니다.
    
    
## 구현

- 기술 : XCTest, Quick, Nimble 

책 등록 화면|책 목록  화면
---|---
<img width="300" alt="스크린샷 2022-11-10 오전 4 43 46" src="https://user-images.githubusercontent.com/56102421/200926154-492c7686-e1db-4083-a12e-8a830b8d2d43.png">|<img width="300" alt="스크린샷 2022-11-10 오전 4 43 56" src="https://user-images.githubusercontent.com/56102421/200926163-90ed18b9-5ac6-4add-9643-43c16e66e403.png">

기술 클릭 화면|책 목록  화면
---|---
<img width="300" alt="스크린샷 2022-11-10 오전 4 45 15" src="https://user-images.githubusercontent.com/56102421/200926403-cf9e4df9-3b1e-4841-938e-e388f96fbd40.png">|<img width="300" alt="스크린샷 2022-11-10 오전 4 45 12" src="https://user-images.githubusercontent.com/56102421/200926505-f229cb32-3365-4a8b-8422-3210097112b2.png">






