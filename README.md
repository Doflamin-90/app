# 1주차 과제 | Flutter·Dart 개발환경 구성

## 1. 개발환경 체크리스트 (`flutter doctor -v`)

- **`flutter doctor -v` 실행 결과 (상세)**:

![flutter doctor 상세 결과 1](./doctor1.png)
![flutter doctor 상세 결과 2](./doctor2.png)

---

## 2. 오류 및 해결 과정

`flutter doctor`를 실행하여 개발환경을 확인한 결과, `Android toolchain` 항목에서 Android SDK 관련 오류가 발생하였습니다.

- **원인**: Android 개발에 필요한 SDK 및 Command-line Tools가 설치되어 있지 않았기 때문입니다.
- **해결 방법**:
  1. Android Studio의 `SDK Manager`에서 Android SDK, Build-Tools, Platform-Tools, Command-line Tools를 설치하였습니다.
  2. 명령 프롬프트(CMD)에서 아래 명령어를 수행하여 Android 라이선스 동의를 완료하였습니다.
     ```bash
     flutter doctor --android-licenses
     ```

---

## 3. 첫 앱 실행 화면 및 사용 Device

- **사용한 Device**: Chrome (Web)
- **앱 실행 증거**:

![첫 앱 실행 화면](./app_run.png)

- **결과**: Chrome 브라우저 환경에서 첫 Flutter 기본 앱이 성공적으로 실행됨을 확인하였습니다.