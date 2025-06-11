import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:uni_lost_and_found/main.dart' as app;
import 'package:uni_lost_and_found/features/item/domain/models/item.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Item Feature Integration Test', () {
    testWidgets('Complete item flow test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify initial state
      expect(find.text('ITEMS FOUND'), findsOneWidget);
      expect(find.text('ITEMS LOST'), findsOneWidget);

      // Test navigation between tabs
      await tester.tap(find.text('ITEMS LOST'));
      await tester.pumpAndSettle();
      expect(find.text('ITEMS LOST'), findsOneWidget);

      await tester.tap(find.text('ITEMS FOUND'));
      await tester.pumpAndSettle();
      expect(find.text('ITEMS FOUND'), findsOneWidget);

      // Test item creation flow
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Fill in item details
      await tester.enterText(find.byType(TextFormField).first, 'Test Item');
      await tester.enterText(find.byType(TextFormField).at(1), 'Test Description');
      await tester.enterText(find.byType(TextFormField).at(2), 'Test Location');

      // Select item status
      await tester.tap(find.text('Found'));
      await tester.pumpAndSettle();

      // Submit the form
      await tester.tap(find.text('SUBMIT'));
      await tester.pumpAndSettle();

      // Verify item appears in the list
      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('Test Location'), findsOneWidget);

      // Test item details view
      await tester.tap(find.text('Test Item'));
      await tester.pumpAndSettle();

      // Verify item details
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('Test Location'), findsOneWidget);

      // Test item update
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'Updated Item');
      await tester.tap(find.text('SAVE'));
      await tester.pumpAndSettle();

      // Verify updated item
      expect(find.text('Updated Item'), findsOneWidget);

      // Test item deletion
      await tester.tap(find.text('Updated Item'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // Confirm deletion
      await tester.tap(find.text('DELETE'));
      await tester.pumpAndSettle();

      // Verify item is removed
      expect(find.text('Updated Item'), findsNothing);
    });
  });
} 