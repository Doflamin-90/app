import 'package:flutter_test/flutter_test.dart';
import 'package:week5_state_lab/main.dart';

void main() {
  testWidgets('Week05App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Week05App());
    expect(find.text('나의 할 일'), findsOneWidget);
  });
}