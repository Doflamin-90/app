import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  testWidgets('오목 앱 로딩 테스트', (WidgetTester tester) async {
    // OmokApp 위젯 렌더링
    await tester.pumpWidget(const OmokApp());

    // 앱 상단 타이틀 텍스트 정상 출력이 되는지 확인
    expect(find.text('프롬프트 엔지니어링 오목 실습'), findsOneWidget);
  });
}