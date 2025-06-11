import '../../domain/models/admin_stats.dart';
import '../../domain/repositories/admin_repository.dart';
import '../api/admin_api.dart';
import '../../../profile/domain/models/profile.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminApi _api;

  AdminRepositoryImpl(this._api);

  @override
  Future<AdminStats> getStats() async {
    try {
      return await _api.getStats();
    } catch (e) {
      throw Exception('Failed to fetch admin stats: $e');
    }
  }

  @override
  Future<List<Profile>> getAllUsers() async {
    try {
      return await _api.getAllUsers();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _api.deleteUser(userId);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<void> updateUserRole(String userId, bool isAdmin) async {
    try {
      await _api.updateUserRole(userId, isAdmin);
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }

  @override
  Future<void> banUser(String userId) async {
    try {
      await _api.banUser(userId);
    } catch (e) {
      throw Exception('Failed to ban user: $e');
    }
  }

  @override
  Future<void> unbanUser(String userId) async {
    try {
      await _api.unbanUser(userId);
    } catch (e) {
      throw Exception('Failed to unban user: $e');
    }
  }
