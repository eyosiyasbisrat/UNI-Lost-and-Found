import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uni_lost_and_found/core/di/service_locator.dart';
import 'package:uni_lost_and_found/features/profile/presentation/providers/profile_provider.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF27649A),
        centerTitle: true,
        title: const Text(
          'DELETE ACCOUNT',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/image3.png'),
            ),
            const SizedBox(height: 12),
            const Text(
              'deez',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              'deez@gmail.com',
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 40),
            const Text(
              'Are you sure you want to delete your account?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26),
            ),
            const SizedBox(height: 32),
