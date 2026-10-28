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

# 중간평가 시험 대비 및 복습 계획표 (`midterm-plan.md`)

- **시험 범위**: 1~7주차 전체 (교재 6.1~6.2, 13.1~13.3 개념 및 수업 실습 내용)
- **문항 구성**: 총 30문항 30점 (객관식 25문항 + 주관식 5문항)
- **핵심 목표**: 단순 용어 암기를 넘어 화면·코드·기획 상황에 대한 직접적 적용 및 문제 해결 능력 검증

---

## 1. 1~7주차 단원별 학습 점검 및 복습 준비표

| 주차 | 복습할 핵심 내용 | 스스로 설명 및 코드 적용할 핵심 질문 | 현재 상태 | 보완 행동 및 참고 자료 위치 | 확인 계획 |
| :---: | :--- | :--- | :---: | :--- | :--- |
| **1** | 강의 개요 · AI 협업 · 도구 선택 | AI 제안 코드/기획을 바로 채택하지 않고 검토해야 하는 이유는? | 설명 가능 | AI 환각(Hallucination) 검증 및 프로젝트 제약 조건 대조 (`01주차_기초내용.md`) | 시험 3일 전 재독 |
| **2** | Flutter 환경 · 진단 · 실행 · Git | `flutter doctor` 성공과 `flutter run` 앱 실행 성공의 차이는? | 설명 가능 | doctor는 개발 환경 설정 검사이며, 앱 실행은 실제 빌드 및 브라우저/디바이스 구동 검증임 (`02주차_기초내용.md`) | 교재 2장 내용 정리 |
| **3** | 요구사항 · 제약 · 객체지향 (DDD) | 기능 요구사항과 관찰 가능한 완료 조건(AC)은 어떻게 연결되는가? | 예제 적용 가능 | 사용자 문제를 인수 조건(AC)으로 구체화하여 정상/오류/빈 상태 검증 (`03주차_기초내용.md`) | 객체지향 엔티티 구조 복습 |
| **4** | 위젯 · 레이아웃 · Material3 패턴 | 화면 구조에 맞는 위젯(Column, Row, Expanded, Card 등) 선택 기준은? | 예제 적용 가능 | 단일/다중 자식 위젯의 역할 구분 및 Material3 디자인 가이드 준수 (`04주차_기초내용.md`) | Flutter 공식 위젯 문서 확인 |
| **5** | 상태 관리 · 이벤트 · UI 요청 설계 | 사용자 행동(이벤트) 실행 후 무엇이 바뀌고 어떻게 화면이 다시 그려지는가? | 예제 적용 가능 | 이벤트 발생 ➔ `setState()` ➔ 내부 상태 변화 ➔ `build()` 재호출되어 UI 갱신 (`05주차_기초내용.md`) | StatefulWidget 리빌드 흐름 작성 |
| **6** | 비동기 처리 · 도구 계약 · 프롬프트 | Future와 Stream의 차이, 로딩 상태와 데이터 요청 실패 상태의 구분법은? | 보완 필요 | Future는 단일 완료 결과, Stream은 지속적 데이터 흐름. 예외 발생 시 UI 로딩/에러 분기 (`06주차_기초내용.md`) | 6주차 비동기 실습 코드 재구현 |
| **7** | 앱 기획 · 컨텍스트 엔지니어링 | AI 작업 요청 시 5가지 요소(목표/근거/제약/현재상태/확인기준)를 주는 이유는? | 설명 가능 | 컨텍스트 오염 방지 및 바이브 코딩 시 명확한 맥락 전달 (`07주차_기초내용.md`) | `context-pack.md` 템플릿 검토 |

*상태 표기: `설명 가능` / `예제 적용 가능` / `보완 필요`*

---

## 2. 주관식 5문항 대비 집중 유형별 복습 전략

### 🎯 1) `StatefulWidget` 및 `setState()`의 구동 원리 (5주차)
* **주관식 출제 포인트**: 버튼 클릭 시 UI가 업데이트되는 일련의 과정 설명.
* **핵심 키워드**: `StatefulWidget`, `State` 객체, `setState()`, `build()` 재호출(Rebuild).
* **답안 서술 팁**: "사용자 이벤트가 발생하면 `setState()` 메서드를 호출하여 상태 변수의 값을 변경하고, 이로 인해 `build()` 메서드가 다시 실행되어 변경된 상태가 화면에 반영된다."

### 🎯 2) 인수 조건(Acceptance Criteria, AC) 작성 요소 (3, 4, 7주차)
* **주관식 출제 포인트**: 단순 희망 사항("입력이 잘 됨")과 관찰 가능한 인수 조건(AC)의 차이 서술.
* **핵심 키워드**: 시작 상태, 사용자 입력/행동, 관찰 가능한 기대 결과, 통과 여부 검증.
* **답안 서술 팁**: "AC는 정상 입력, 잘못된 입력(공백 등), 빈 데이터 상태를 포함해야 하며, 실행 전에는 '미실행' 상태로 관리하고 구체적인 확인 방법이 제시되어야 한다."

### 🎯 3) 비동기(Async) 처리: `Future` vs `Stream` (6주차)
* **주관식 출제 포인트**: `Future`와 `Stream`의 단일/연속 데이터 처리 차이점.
* **핵심 키워드**: `Future`(한 번의 미래 결과), `Stream`(시간에 따른 연속적 데이터 이벤트), `async`/`await`.
* **답안 서술 팁**: "`Future`는 한 번만 응답을 받아 처리하는 비동기 작업에 사용되며, `Stream`은 시간에 따라 계속해서 발생하는 여러 데이터 흐름을 수신할 때 사용한다."

### 🎯 4) 컨텍스트 엔지니어링의 5대 핵심 요소 (7주차)
* **주관식 출제 포인트**: AI 개발 협업 시 프롬프트 외에 전달해야 하는 작업 컨텍스트 구성 요소 5가지.
* **핵심 키워드**: 
  1. **목표** (이번에 할 작은 작업)
  2. **근거** (읽을 문서, 제목 규칙, 기존 코드)
  3. **제약** (유지할 범위, 금지 패키지/서버)
  4. **현재 상태** (확인된 사실, 문제점, 미정 항목)
  5. **확인 기준** (연결된 AC 및 검증 절차)

### 🎯 5) DDD(도메인 주도 설계) 및 PRD의 핵심 역할 (3, 6주차)
* **주관식 출제 포인트**: `Artwork`(Entity)과 `WorkType`(Value Object)의 개념 구분 및 PRD 작성 이유.
* **핵심 키워드**: 정체성(Identity), 불변성(Immutability), 핵심 가치, 기술/기능 전 문제 정의 선행.

---

## 3. 가장 먼저 보완할 우선순위 2가지 및 실행 계획

1. **6주차 비동기 처리 및 예외 상태 구분 (`보완 필요`)**
   - **이유**: `Future`와 `Stream` 개념 및 UI 로딩/실패 예외 처리 구현에 대한 주관식 단골 문제 대비.
   - **실행 행동**: 6주차 강의 자료의 비동기 코드 구조를 직접 손으로 작성해 보고 로딩 status 분기 흐름을 익힘.
2. **5주차 StatefulWidget 리빌드 매커니즘 (`예제 적용 가능`)**
   - **이유**: Flutter UI 갱신 원리는 객관식/주관식 모두 높은 비중으로 출제됨.
   - **실행 행동**: `lib/main.dart`의 `_showAddDialog` 및 `_addNewArtwork` 메서드가 상태를 변경할 때 `build()`가 어디서부터 작동하는지 다이어그램으로 그려보기.
