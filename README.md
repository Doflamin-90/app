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

| 1. 초기 / 미완료 상태 | 2. 완료 / 상태 변경 화면 |
| :---: | :---: |
| ![State Lab 1](./week5_state_lab/evidence/ac1-initial.png) | ![State Lab 2](./week5_state_lab/evidence/ac2-done.png) |
| 할 일 목록 및 초기 상태 | 완료 체크 및 상태 업데이트 |

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
| ![Async Test](./week6_widget_demo/evidence/async-test.png) | ![Heavy Test](./week6_widget_demo/evidence/heavy-test.png) | ![Isolate Test](./week6_widget_demo/evidence/isolate-test.png) |
| 비동기 처리 확인 | 메인 스레드 연산 완료 | 스레드 분리 병렬 연산 완료 |

---

# 🎨 아트 타임라인 (Art Timeline) — 개인 앱 기획서 (1부 & 2부)

---

## 1부. 사용자 문제 정의 (따라하기 1)

### 1. 사용자 · 상황 · 행동 · 불편 표 정리

| 사용자 | 상황 | 행동 | 불편 |
| :--- | :--- | :--- | :--- |
| 대학생 (본인) | 손그림과 디지털 일러스트를 병행하며 모아둘 때 | 스마트폰 갤러리에 폴더별 저장 및 SNS 업로드 | 어떤 그림을 언제 그렸는지 찾기 힘들고 날짜별 태그나 작업 방식(손그림/디지털)별 분류가 되지 않아 성장 과정을 한눈에 정리하기 불편함 |

### 2. 확인한 사실과 아직 확인하지 않은 가정 구분

* **확인한 사실 (제시된 경험 근거)**
  * 사용자는 대학생이며, 손그림과 디지털 일러스트를 모두 그린다.
  * 현재 스마트폰 갤러리 폴더 저장과 SNS 업로드 방식을 사용하고 있다.
  * 기존 방식으로는 날짜별 태그나 작업 방식(손그림/디지털)별 분류가 되지 않는다.
  * 언제 그린 그림인지 찾기 어렵고 성장 과정을 한눈에 모아보기 불편하다.
* **아직 확인하지 않은 가정**
  * 다른 일러스트 작성자들도 날짜/작업방식별 분류 및 성장기록 모아보기 기능을 원할 것이다.
  * 갤러리 저장이나 SNS 업로드 대신 별도의 전용 정제 앱을 지속적으로 사용할 의향이 있을 것이다.

### 3. 문제 문장 2개 제안

1. **문장 1**: 손그림과 디지털 일러스트를 함께 그리는 대학생은, 과거 그려둔 작업물을 찾으려고 할 때, 스마트폰 갤러리에서 작업 방식(손그림/디지털) 및 날짜별 분류가 되지 않아 정리에 어려움을 겪는다.
2. **문장 2**: 자신의 그림 실력 변화를 확인하고 싶은 대학생 일러스트 작성자는, 기존 저장 방식으로 작품을 보관할 때, 시간 흐름에 따른 성장 과정을 한눈에 정돈하여 모아보기 불편하다.

### 4. 가정을 확인할 사용자 질문

* **질문 1 (문장 1 가정 검증)**: "평소 작성한 손그림과 디지털 그림을 따로 분류하여 보관하시나요? 보관 시 가장 자주 경험하는 불편함은 무엇인가요?"
* **질문 2 (문장 2 가정 검증)**: "과거 그림과 현재 그림을 비교하며 성장 과정을 확인하고 싶을 때, 주로 어떤 방식을 사용하며 불편한 점은 무엇인가요?"

---

## 2부. 기획 매직 키워드 (DDD & PRD)

### 1. DDD (도메인 주도 설계) 핵심 개념 정제

* **`Artwork` (작품 Entity)**: 정체성(Identity)을 지닌 핵심 도메인 객체 (`id`, `title`, `date`, `workType`)
* **`WorkType` (작업 방식 Value Object)**: 불변 값을 갖는 작업 형태 구분값 (`handDrawn` / `digital`)
* **`Timeline` (성장기록 Aggregate / Domain Service)**: `Artwork` 집합을 시간 순서대로 정렬하고 작업 방식별로 필터링하여 제공하는 서비스

### 2. 상세 PRD (Product Requirement Document) 초안

#### 📄 제품 개요
* **제품명**: 아트 타임라인 (Art Timeline)
* **목적**: 손그림과 디지털 일러스트를 작업 방식 및 날짜별로 정제 보관하여 성장 과정을 직관적으로 확인하게 함.

#### 🎯 핵심 기능 (Key Features)
1. **작품 등록 및 분류**: 제목 입력 및 작업 방식(손그림/디지털) 선택 등록
2. **타임라인 피드**: 날짜순 작품 정렬 및 성장 기록 시각화
3. **작업 방식 필터링**: 전체 / 손그림만 / 디지털만 필터링 기능

#### 📋 수용 조건 (Acceptance Criteria, AC)
* **AC1 (등록)**: 사용자가 제목과 작업 방식(손그림/디지털)을 선택하여 등록하면 작품 목록 및 대시보드 카운트에 즉시 반영된다.
* **AC2 (필터)**: '손그림' 또는 '디지털' 필터 칩 클릭 시 해당 작업 방식의 작품만 타임라인에 표시된다.
* **AC3 (타임라인)**: 모든 작품은 생성된 날짜순으로 타임라인 상에 바르게 나열된다.

#### ⚠️ 제약사항
* 외부 상태관리 패키지 없이 `StatefulWidget` 및 `setState` 사용
* `flutter analyze` 수행 시 warning/error가 0개여야 함

 ---

# CONTEXT_PACKET: Art Timeline App

## 2부. 컨텍스트 엔지니어링 & 바이브코딩

## 📌 목표 및 역할
- 목표: 손그림/디지털 일러스트를 분류하고 시간 순서대로 보여주는 Flutter 단일 화면 구성
- 대상 파일: `lib/main.dart`

## 🛠️ 핵심 도메인 모델
- Artwork: id, title, workType(handDrawn | digital), date

## 🎯 인수 조건 (AC)
- AC1: 작업 방식(손그림/디지털) 필터링 칩(ChoiceChip) 클릭 시 목록이 즉시 변경된다.
- AC2: 상단 카드에서 전체 작품 수, 손그림 수, 디지털 수를 한눈에 확인한다.
- AC3: FloatingActionButton 클릭 시 모달이 떠서 새 작품(제목, 작업 방식, 날짜)을 등록한다.

## 🚫 제약 사항
- 외부 상태관리 패키지(Provider, Riverpod 등) 금지 -> StatefulWidget 및 setState 사용.
- 외부 백엔드 API 연동 없음 (샘플 데모 데이터 활용).
- `flutter analyze` 수행 시 warning/error가 0개여야 함.

---

# 🎨 개인 앱 기획 및 구현 — 아트 타임라인 (`my_art_app`)

## 📌 프로젝트 개요
- **앱 이름**: 아트 타임라인 (Art Timeline)
- **주요 기능**: 손그림 및 디지털 일러스트를 분류하고 생성 날짜순 타임라인으로 보여주는 기록 관리 앱
- **기술 제약**: 단일 파일(`lib/main.dart`), `setState` 활용, `flutter analyze` 0건 통과

---

## 📸 실행 및 인수 조건(AC) 검증 증거

| 1. 전체 화면 (`main_home.png`) | 2. 손그림 필터링 (`hand.png`) |
| :---: | :---: |
| ![Main Home](./my_art_app/evidence/main_home.png) | ![Hand Drawn Filter](./my_art_app/evidence/hand.png) |
| 초기 4개 항목 및 대시보드 | 손그림 항목 2개만 필터링 출력 |

| 3. 디지털 필터링 (`digtal.png`) | 4. 새 작품 등록 모달 (`add_art.png`) |
| :---: | :---: |
| ![Digital Filter](./my_art_app/evidence/digtal.png) | ![Add Art Modal](./my_art_app/evidence/add_art.png) |
| 디지털 항목 2개만 필터링 출력 | 작품 제목 및 분류(손그림/디지털) 선택 등록 |

---
