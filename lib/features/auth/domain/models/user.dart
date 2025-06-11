import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

@immutable
class User extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['userId'] as String,
        email: json['email'] as String,
        fullName: json['fullName'] as String,
        role: json['role'] as String,
        token: json['token'] as String,
      );
    } catch (e) {
      throw FormatException('Invalid user data format: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'email': email,
      'fullName': fullName,
      'role': role,
      'token': token,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? role,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

