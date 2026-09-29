import 'package:flutter_test/flutter_test.dart';
import 'package:week4_widget_lab/main.dart';

void main() {
  testWidgets('ProfileApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileApp());
  });
}