import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/item.dart';

class ItemApi {
  final String baseUrl;
  final http.Client _client;

  ItemApi({required this.baseUrl}) : _client = http.Client();

  Future<List<Item>> getItems() async {
    final response = await _client.get(Uri.parse('$baseUrl/items'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    }
    throw Exception('Failed to load items');
  }

  Future<Item> getItemById(String id) async {
    final response = await _client.get(Uri.parse('$baseUrl/items/$id'));
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to load item');
  }

  Future<Item> createItem(Item item) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/items'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 201) {
      return Item.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create item');
  }

  Future<Item> updateItem(Item item) async {
    final response = await _client.put(
      Uri.parse('$baseUrl/items/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to update item');
  }

  Future<void> deleteItem(String id) async {
    final response = await _client.delete(Uri.parse('$baseUrl/items/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete item');
    }
  }

  Future<void> claimItem(String itemId) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/items/$itemId/claim'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to claim item');
    }
  }

  Future<List<Item>> getUserItems(String userId) async {
    final response = await _client.get(Uri.parse('$baseUrl/users/$userId/items'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    }
    throw Exception('Failed to load user items');
  }

  Future<List<Item>> getClaimedItems(String userId) async {
    final response = await _client.get(Uri.parse('$baseUrl/users/$userId/claimed-items'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Item.fromJson(json)).toList();
    }
    throw Exception('Failed to load claimed items');
  }
} 