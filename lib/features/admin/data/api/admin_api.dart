import 'package:dio/dio.dart';
import '../../domain/models/admin_stats.dart';
import '../../../profile/domain/models/profile.dart';

class AdminApi {
  final Dio _dio;

  AdminApi(this._dio);

  Future<AdminStats> getStats() async {
    try {
      final response = await _dio.get('/admin/stats');
      return AdminStats.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Profile>> getAllUsers() async {
    try {
      final response = await _dio.get('/admin/users');
      return (response.data as List)
          .map((json) => Profile.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _dio.delete('/admin/users/$userId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateUserRole(String userId, bool isAdmin) async {
    try {
      await _dio.put(
        '/admin/users/$userId/role',
        data: {'isAdmin': isAdmin},
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> banUser(String userId) async {
    try {
      await _dio.put('/admin/users/$userId/ban');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> unbanUser(String userId) async {
    try {
      await _dio.put('/admin/users/$userId/unban');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getSystemLogs() async {
    try {
      final response = await _dio.get('/admin/logs');
      return (response.data as List)
          .map((json) => json as Map<String, dynamic>)
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.response?.statusCode == 401) {
      return Exception('Unauthorized access');
    }
    if (error.response?.statusCode == 403) {
      return Exception('Access forbidden');
    }
    if (error.response?.statusCode == 404) {
      return Exception('Resource not found');
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout. Please check your internet connection.');
    }
    if (error.type == DioExceptionType.unknown) {
      return Exception('No internet connection');
    }
    return Exception('An error occurred. Please try again.');
  }
}