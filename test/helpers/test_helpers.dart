import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_lost_and_found/features/item/domain/repositories/item_repository.dart';
import 'package:uni_lost_and_found/features/profile/domain/repositories/profile_repository.dart';

class MockItemRepository extends Mock implements ItemRepository {}
class MockProfileRepository extends Mock implements ProfileRepository {}

Widget createTestableWidget(Widget child) {
  return MaterialApp(
    home: ProviderScope(
      child: child,
    ),
  );
}

Future<void> pumpWidget(
  WidgetTester tester,
  Widget widget, {
  List<Override> overrides = const [],
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: widget,
      ),
    ),
  );
} 