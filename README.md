## 오류 및 해결 과정

`flutter doctor`를 실행하여 개발환경을 확인한 결과,
Android toolchain 항목에서 Android SDK 관련 오류가 발생하였다.

원인은 Android 개발에 필요한 SDK와 Command-line Tools가
설치되어 있지 않았기 때문이었다.

해결을 위해 Android Studio의 SDK Manager에서
Android SDK, Build-Tools, Platform-Tools,
Command-line Tools를 설치하였다.

이후 아래 명령어를 사용하여 Android 라이선스에 동의하였다.

flutter doctor --android-licenses