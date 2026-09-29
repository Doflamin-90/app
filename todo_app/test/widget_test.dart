import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';

void main() {
  testWidgets('나의 할 일 앱 기본 위젯 렌더링 테스트', (WidgetTester tester) async {
    // 앱 빌드 및 프레임 트리거
    await tester.pumpWidget(const TodoApp());

    // '나의 할 일' 텍스트가 화면에 존재하는지 확인
    expect(find.text('나의 할 일'), findsOneWidget);

    // '남은 할 일 ' 텍스트가 존재하는지 확인
    expect(find.textContaining('남은 할 일'), findsOneWidget);
  });
}