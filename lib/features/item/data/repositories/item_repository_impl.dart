import '../../domain/models/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../api/item_api.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemApi _api;

  ItemRepositoryImpl(this._api);

  @override
  Future<List<Item>> getItems() async {
    return await _api.getItems();
  }

  @override
  Future<Item> getItemById(String id) async {
    return await _api.getItemById(id);
  }

  @override
  Future<Item> createItem(Item item) async {
    return await _api.createItem(item);
  }

  @override
  Future<Item> updateItem(Item item) async {
    return await _api.updateItem(item);
  }

  @override
  Future<void> deleteItem(String id) async {
    await _api.deleteItem(id);
  }

  @override
  Future<void> claimItem(String itemId) async {
    await _api.claimItem(itemId);
  }

  @override
  Future<List<Item>> getUserItems(String userId) async {
    return await _api.getUserItems(userId);
  }

  @override
  Future<List<Item>> getClaimedItems(String userId) async {
    return await _api.getClaimedItems(userId);
  }
} 