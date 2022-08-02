# 요구사항

## List UI 구현
아래 내용을 참고하여 UI를 구현해 주세요.

### 설명
* Seoul, London, Chicago, 세 도시의 날씨를 표시하는 앱이에요.
* 위 도시 순서대로 오늘을 포함한 6일 간의 날씨를 표시해주세요.
* 총 3개 도시의 각 6일간의 날씨를 한 화면에 표시해주세요.


### 기능 명세
* API는 아래 페이지를 참고 해주세요 (회원가입 필요)
  - https://openweathermap.org/current

* 스크롤이 가능한 리스트이어야 해요
* 라이브러리의 제약은 없지만, iOS의 경우 스토리보드 사용을 자제 해주세요
* 최대한 자신의 코딩스타일을 표현해 주세요
* 날씨 이미지는 아래 페이지를 참고 해주세요
  - https://erikflowers.github.io/weather-icons/

![unnamed](https://user-images.githubusercontent.com/888140/182286997-9f810a33-8a5f-424e-95bc-992745a98ddb.png)

# 구현사항

동일한 요구사항을 `UIKit`, `SwiftUI` 두가지 타겟으로 구현했습니다.

## 적용기술

### 공통사항
* Alamofire
* Decodable 모델
* Http Client 모듈
* Http Router 모듈
* SwiftDate
* Kingfisher

> `OpenWeatherAPI`는 파라미터로 인증처리, 인증만료 없음
>  -> 인증관련 `RequestAdapter`, `RequestRetrier` 미적용

> Swift `Decodable`은 `[String: Any]` 미지원.
>  -> `Decodable+Any.swift` 확장 처리, [StackOverflow 참고](https://stackoverflow.com/questions/44603248/how-to-decode-a-property-with-type-of-json-dictionary-in-swift-45-decodable-pr)

### WeatherOne
* UIKit
* RxSwift
* RxAlmofire
* MVC
* Code-base UI

### WeatherTwo
* SwiftUI
* Combine
* MVVM

### 기타
* 이미지는 `OpenWeatherAPI` 제공 이미지로 비동기 처리
* 빌트인 API `q={city_name}`는 deprecated 예정이라 `Geocoding API` 사용
* 무료 API `5 day weather forecast`는 하루의 최고/최저 온도가 아니라 가공처리
  - `Daily Forecast 16 Days`는 유료구독 필요

## 스크린샷

![Simulator Screen Shot - iPhone 13 - 2022-08-02 at 12 09 01](https://user-images.githubusercontent.com/888140/182287012-00c0368c-52a2-4c3b-b6a0-32eb2ec8866a.png)


# 마무리
단순한 구현이지만 SwiftUI+Combine+MVVM의 구조적 편리성은 애플 의도대로 괜찮아 보였습니다. 하지만 아직 SwiftUI는 기술이 덜 성숙되 보였고, Combine은 타입 중첩 랩핑과 툴팁이 상당히 별로였어요.

감사합니다 :)

