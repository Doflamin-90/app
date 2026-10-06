# Flutter·Dart 개발환경 구성

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

---

## 4. 응용 과제: 간단 계산기 구현

- **구현 내용**: AI를 활용하여 Flutter 기반 사칙연산 계산기 UI 및 계산 로직 구현
- **사용한 Device**: Chrome (Web)
- **앱 실행 증거**:

![계산기 실행 화면](./calculator.png)

# Flutter·Dart (`StudyGoal` 앱)

## 1. 수용 조건(AC) 검증 증거 자료 (`evidence/`)

- **`evidence/ac1-valid.png` (정상 입력)**:
  - 입력창에 `Dart 객체지향` 입력 후 추가하여 목록 및 `미완료` 상태가 정상 표시됨.

![AC1 정상 입력](./week3_goal_lab/evidence/ac1-valid.png)

- **`evidence/ac2-empty.png` (공백 입력 오류)**:
  - 빈 값 입력 후 추가 클릭 시 차단되며 `목표를 입력하세요` 오류 문구가 표시됨.

![AC2 공백 입력](./week3_goal_lab/evidence/ac2-empty.png)

- **`evidence/ac3-complete.png` (완료 전환)**:
  - 항목 선택 시 체크박스가 활성화되고 텍스트가 `완료` 상태로 변경됨.

![AC3 완료 전환](./week3_goal_lab/evidence/ac3-complete.png)

---

## 2. 주요 구현 사항 및 해결 과정

- **요구사항 명세 작성 (`FEATURE_CONTEXT.md`)**:
  - 사용자 스토리, 기능 구현 범위(Scope), 수용 조건(AC1~AC3)을 구체화하여 명세서 파일 작성 완료.
- **핵심 기능 구현 (`lib/main.dart`)**:
  - `_toggleGoal` 상태 로직 구현으로 완료/미완료 전환 처리.
  - 공백 입력에 대한 폼 검증(Validation) 처리로 예외 케이스 방지.
- **테스트 코드 오류 해결 (`test/widget_test.dart`)**:
  - 기존 샘플 앱(`MyApp`) 기반 테스트 코드를 새로 구현한 `StudyGoalApp`에 맞게 수정하여 `flutter analyze` 정적 분석 0건(No issues found!) 달성.

---

## 3. 앱 실행 및 정적 분석 결과

- **사용한 Device**: Chrome (Web)
- **정적 분석 결과**:
  ```bash
  flutter analyze
  # Analyzing week3_goal_lab...
  # No issues found!

  # 🎮 Brick Breaker Game (벽돌깨기 게임)

Flutter 기반으로 구현한 클래식 벽돌깨기 게임입니다.

---

## 📸 실행 화면

![벽돌깨기 게임 실행 화면](./brick_breaker_game/game_run.png)

---

## 🕹️ 조작 방법

1. **게임 시작**: 화면 바탕을 마우스로 클릭
2. **패들(바) 이동**: 키보드 좌/우 화살표 키 (`←`, `→`)

---

## 🛠️ 주요 기능

- 패들 반응 속도 향상 및 공 속도 최적화
- 공-패들, 공-벽, 공-벽돌 간의 충돌 감지 및 반사 로직
- 게임 오버 및 승리(ALL CLEAR) 조건 처리 및 재시작 기능

---

## 📱 대표 위젯으로 프로필 화면 만들기

- **주요 내용**: Flutter 기본 위젯(Row, Column, ListView, Card, SnackBar)을 사용한 프로필 화면 구성
- **검증 결과**: `flutter analyze` 0건 통과

### 📸 실행 화면

![4주차 프로필 화면](./week4_widget_lab/evidence/ac1-header.png)

---

## 📱 할 일 앱 상태관리 및 컨텍스트

- **주요 내용**: `StatefulWidget` 및 `setState`를 활용한 완료/취소 토글 및 남은 할 일 수(`_remaining`) 동기적 계산
- **검증 결과**: `flutter analyze` 0건 통과

### 📸 실행 화면 (todo1, todo2)

| 미완료 상태 (todo1) | 완료 클릭 후 상태 (todo2) |
|:---:|:---:|
| ![todo1](./todo_app/evidence/todo1.png) | ![todo2](./todo_app/evidence/todo2.png) |

---

## 📱 상태 관리 및 당근마켓 UI 실습 예제

### 1. 다크 모드 / 라이트 모드 전환
| 다크 모드 | 라이트 모드 |
|:---:|:---:|
| ![dark](./state_lab/evidence/dark.png) | ![light](./state_lab/evidence/light.png) |

---

### 2. 랜덤 컬러 상자
| 변경 전 | 변경 후 |
|:---:|:---:|
| ![randombox](./state_lab/evidence/randombox.png) | ![randombox2](./state_lab/evidence/randombox2.png) |

---

### 3. 폰트 크기 조절 슬라이더
| 기본 크기 | 크기 변경 후 |
|:---:|:---:|
| ![textsize](./state_lab/evidence/textsize.png) | ![textsize2](./state_lab/evidence/textsize2.png) |

---

### 4. 당근마켓 웹 4열 그리드 검색 결과 화면
| 당근마켓 검색 결과 UI |
|:---:|
| ![daangng](./state_lab/evidence/daangng.png) |

---

# 상태 기능과 작업 컨텍스트

## 📌 주요 구현 내용

- **상태 정의**: `_done` 목록을 원본 상태(State)로 관리하고, `_remaining`은 별도 중복 저장 없이 원본 상태에서 직접 계산되도록 구현
- **상태 흐름**: 완료/취소 버튼 클릭 시 `_toggleDone(index)` 이벤트가 발생하여 `_done` 상태가 반전되고 `setState()`를 통해 UI 재렌더링
- **컨텍스트 지도**: 목표, 현재 코드, 제약 사항, 인수 조건을 명시한 `CONTEXT_PACKET.md` 및 `PROMPT_COMPARISON.md` 작성

---

## 📸 실행 및 검증 증거 (Evidence)

| AC1: 초기 화면 (남은 수 2) | AC2: 완료 상태 (남은 수 1) | AC2: 취소 원복 (남은 수 2) |
| :---: | :---: | :---: |
| ![AC1 Initial](evidence/ac1-initial.png) | ![AC2 Done](evidence/ac2-done.png) | ![AC2 Undone](evidence/ac2-undone.png) |
| 시작 시 할 일 2개, 남은 수 2 | 첫 항목 완료 시 취소선 및 남은 수 1 | 다시 취소 시 원복 및 남은 수 2 |

---

# 플러터 레이아웃 위젯 및 병렬성 키워드 확인

## 📌 주요 구현 내용

- **레이아웃 위젯**: `Column`, `Expanded`, `Center`, `Padding`을 통한 UI 구성
- **비동기 및 병렬 연산**:
  - `Future.delayed`: 메인 스레드 멈춤 없이 작동하는 일반 비동기 테스트
  - 동기식 무거운 연산: 메인 스레드 독점 및 UI 블로킹 확인
  - `compute()` / `Isolate`: 백그라운드 스레드로 분리하여 수행하는 병렬 연산 구현

---

## 📸 실행 및 검증 증거 (Evidence)

| 1. 일반 비동기 테스트 | 2. 메인 무거운 연산 | 3. Isolate 병렬 연산 |
| :---: | :---: | :---: |
| ![Async Test](evidence/async-test.png) | ![Heavy Test](evidence/heavy-test.png) | ![Isolate Test](evidence/isolate-test.png) |
| 비동기 처리 확인 | 메인 스레드 연산 완료 | 스레드 분리 병렬 연산 완료 |

---
