# marketap_flutter_example

마켓탭의 Flutter 데모 프로젝트 입니다.

## 상세 연동 가이드
- 마켓탭이 SDK에서 데이터를 어떻게 처리하는지에 대한 내용은 [여기](https://marketap.gitbook.io/marketap-guide/developer/core-concept/sdk-structure)에서 확인이 가능합니다.
- 마켓탭으로 이벤트를 전달하기 위한 방법은 [여기](https://marketap.gitbook.io/marketap-guide/developer/core-concept/data/event)에서 확인이 가능합니다.


## 인앱메세지 예시
- Go to NEXT1 > Go to DETAIL1 페이지에 진입하면 인앱메세지가 노출됩니다.
- 이 메세지는 `mkt_page_view` 이벤트의 path가 /next1/detail1일 경우 노출되도록 지정되어있습니다.


## 푸시메세지 예시
- 로그인에서 간단히 id/pw를 입력한 후, 상품 목록 보기 > 상품 선택 > 구매/장바구니 행동을 수행 시, 푸시메세지가 전달됩니다.
- 이 메세지는 `mkt_purchase`, `mkt_add_to_cart` 이벤트가 일어날 때 푸시가 발송되도록 지정되어있습니다.
