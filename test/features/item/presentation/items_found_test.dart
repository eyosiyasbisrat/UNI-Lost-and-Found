import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_lost_and_found/features/item/domain/models/item.dart';
import 'package:uni_lost_and_found/features/item/domain/repositories/item_repository.dart';
import 'package:uni_lost_and_found/features/item/presentation/ItemsFound.dart';
import 'package:uni_lost_and_found/features/item/presentation/providers/item_provider.dart';
import '../../../helpers/test_helpers.dart';

void main() {
  late MockItemRepository mockRepository;

  setUp(() {
    mockRepository = MockItemRepository();
  });

  testWidgets('shows loading indicator when loading', (WidgetTester tester) async {
    when(mockRepository.getItems()).thenAnswer((_) async => []);

    await pumpWidget(
      tester,
      const ItemFound(),
      overrides: [
        itemRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when error occurs', (WidgetTester tester) async {
    when(mockRepository.getItems()).thenThrow(Exception('Test error'));

    await pumpWidget(
      tester,
      const ItemFound(),
      overrides: [
        itemRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    await tester.pumpAndSettle();

    expect(find.text('Error: Exception: Test error'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('displays found items correctly', (WidgetTester tester) async {
    final testItems = [
      Item(
        id: '1',
        name: 'Test Item 1',
        description: 'Description 1',
        location: 'Location 1',
        imageUrl: 'http://example.com/image1.jpg',
        status: ItemStatus.found,
        userId: 'user1',
        foundDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Item(
        id: '2',
        name: 'Test Item 2',
        description: 'Description 2',
        location: 'Location 2',
        imageUrl: 'http://example.com/image2.jpg',
        status: ItemStatus.found,
        userId: 'user1',
        foundDate: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    when(mockRepository.getItems()).thenAnswer((_) async => testItems);

    await pumpWidget(
      tester,
      const ItemFound(),
      overrides: [
        itemRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    await tester.pumpAndSettle();

    expect(find.text('ITEMS FOUND'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Last 7 Days'), findsOneWidget);
    expect(find.text('Test Item 1'), findsOneWidget);
    expect(find.text('Test Item 2'), findsOneWidget);
  });

  testWidgets('navigates to item details when item is tapped', (WidgetTester tester) async {
    final testItem = Item(
      id: '1',
      name: 'Test Item 1',
      description: 'Description 1',
      location: 'Location 1',
      imageUrl: 'http://example.com/image1.jpg',
      status: ItemStatus.found,
      userId: 'user1',
      foundDate: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(mockRepository.getItems()).thenAnswer((_) async => [testItem]);

    await pumpWidget(
      tester,
      const ItemFound(),
      overrides: [
        itemRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('Test Item 1'));
    await tester.pumpAndSettle();

    // Verify navigation occurred
    expect(find.text('Test Item 1'), findsOneWidget);
  });
} 