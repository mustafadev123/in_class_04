import 'package:flutter_test/flutter_test.dart';

import 'package:cyber_tactile_console/main.dart';

void main() {
  testWidgets('command deck exposes its initial controls', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CyberTactileApp());

    expect(find.text('SENTINEL-07'), findsOneWidget);
    expect(find.textContaining('ON PATROL'), findsOneWidget);
    expect(find.text('LASER BLAST'), findsOneWidget);
    expect(find.text('RESCUE CIVILIANS'), findsOneWidget);
  });

  testWidgets('rescue action updates the mission status', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CyberTactileApp());

    await tester.tap(find.text('RESCUE CIVILIANS'));
    await tester.pump();

    expect(find.textContaining('CIVILIAN RESCUED'), findsOneWidget);
    expect(find.text('1 / 3'), findsOneWidget);
  });
}
