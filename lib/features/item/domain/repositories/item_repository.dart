import '../models/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();

  Future<Item> getItemById(String id);

  Future<Item> createItem(Item item);

  Future<Item> updateItem(Item item);

  Future<void> deleteItem(String id);

  Future<void> claimItem(String itemId);

  Future<List<Item>> getUserItems(String userId);

  Future<List<Item>> getClaimedItems(String userId);
} 