import 'package:flutter_test/flutter_test.dart';
import 'package:state_lab/main.dart';

void main() {
  testWidgets('테마 변경 앱 기본 위젯 렌더링 테스트', (WidgetTester tester) async {
    // App1 위젯 빌드
    await tester.pumpWidget(const App1());

    // '1. 테마 변경 앱' 텍스트가 화면에 존재해 정상 출력되는지 확인
    expect(find.text('1. 테마 변경 앱'), findsOneWidget);
  });
}