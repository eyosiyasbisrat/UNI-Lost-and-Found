import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uni_lost_and_found/features/item/domain/models/item.dart';
import 'package:uni_lost_and_found/features/item/domain/repositories/item_repository.dart';
import 'package:uni_lost_and_found/features/item/presentation/providers/item_provider.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late MockItemRepository mockRepository;
  late ItemNotifier itemNotifier;

  setUp(() {
    mockRepository = MockItemRepository();
    itemNotifier = ItemNotifier(mockRepository);
  });

  group('ItemNotifier', () {
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
        status: ItemStatus.lost,
        userId: 'user1',
        foundDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    test('initial state is correct', () {
      expect(itemNotifier.state.items, []);
      expect(itemNotifier.state.isLoading, false);
      expect(itemNotifier.state.error, null);
    });

    test('loadItems success', () async {
      when(mockRepository.getItems()).thenAnswer((_) async => testItems);

      await itemNotifier.loadItems();

      expect(itemNotifier.state.items, testItems);
      expect(itemNotifier.state.isLoading, false);
      expect(itemNotifier.state.error, null);
    });

    test('loadItems error', () async {
      when(mockRepository.getItems()).thenThrow(Exception('Test error'));

      await itemNotifier.loadItems();

      expect(itemNotifier.state.items, []);
      expect(itemNotifier.state.isLoading, false);
      expect(itemNotifier.state.error, 'Exception: Test error');
    });

    test('addItem success', () async {
      final newItem = testItems[0];
      when(mockRepository.createItem(newItem)).thenAnswer((_) async => newItem);

      await itemNotifier.addItem(newItem);

      expect(itemNotifier.state.items, [newItem]);
      expect(itemNotifier.state.isLoading, false);
      expect(itemNotifier.state.error, null);
    });

    test('updateItem success', () async {
      final item = testItems[0];
      final updatedItem = Item(
        id: item.id,
        name: 'Updated Name',
        description: item.description,
        location: item.location,
        imageUrl: item.imageUrl,
        status: item.status,
        userId: item.userId,
        foundDate: item.foundDate,
        createdAt: item.createdAt,
        updatedAt: DateTime.now(),
      );

      when(mockRepository.updateItem(updatedItem)).thenAnswer((_) async => updatedItem);
      itemNotifier.state = itemNotifier.state.copyWith(items: [item]);

      await itemNotifier.updateItem(updatedItem);

      expect(itemNotifier.state.items, [updatedItem]);
      expect(itemNotifier.state.isLoading, false);
      expect(itemNotifier.state.error, null);
    });

    test('deleteItem success', () async {
      final item = testItems[0];
      when(mockRepository.deleteItem(item.id)).thenAnswer((_) async => {});
      itemNotifier.state = itemNotifier.state.copyWith(items: [item]);

      await itemNotifier.deleteItem(item.id);

      expect(itemNotifier.state.items, []);
      expect(itemNotifier.state.isLoading, false);
      expect(itemNotifier.state.error, null);
    });
  });
} 