import 'package:flutter/material.dart';
import '../../domain/models/item.dart';
import '../../domain/repositories/item_repository.dart';

class ItemProvider extends ChangeNotifier {
  final ItemRepository _repository;
  List<Item> _items = [];
  bool _isLoading = false;
  String? _error;

  ItemProvider(this._repository);

  List<Item> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Item> get foundItems => _items.where((item) => item.status == ItemStatus.found).toList();
  List<Item> get lostItems => _items.where((item) => item.status == ItemStatus.lost).toList();
  List<Item> get myItems => _items.where((item) => item.userId == 'current_user_id').toList();

  List<Item> get todayFoundItems {
    final now = DateTime.now();
    return foundItems.where((item) {
      return item.foundDate.year == now.year &&
          item.foundDate.month == now.month &&
          item.foundDate.day == now.day;
    }).toList();
  }

  List<Item> get lastSevenDaysFoundItems {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return foundItems.where((item) {
      return item.foundDate.isAfter(sevenDaysAgo) &&
          item.foundDate.isBefore(now);
    }).toList();
  }

  List<Item> get todayLostItems {
    final now = DateTime.now();
    return lostItems.where((item) {
      return item.foundDate.year == now.year &&
          item.foundDate.month == now.month &&
          item.foundDate.day == now.day;
    }).toList();
  }

  List<Item> get lastSevenDaysLostItems {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    return lostItems.where((item) {
      return item.foundDate.isAfter(sevenDaysAgo) &&
          item.foundDate.isBefore(now);
    }).toList();
  }

  Future<void> loadItems() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _items = await _repository.getItems();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(Item item) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newItem = await _repository.createItem(item);
      _items.add(newItem);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateItem(Item item) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedItem = await _repository.updateItem(item);
      final index = _items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _items[index] = updatedItem;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteItem(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.deleteItem(id);
      _items.removeWhere((item) => item.id == id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> claimItem(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.claimItem(id);
      // Optionally, you can refresh the item list or update the claimed status if your model supports it
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 
