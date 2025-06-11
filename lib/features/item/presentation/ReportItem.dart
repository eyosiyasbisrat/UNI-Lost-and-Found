import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uni_lost_and_found/features/item/controllers/report_controller.dart';
import 'package:uni_lost_and_found/features/item/widgets/report_form.dart';
import '../../../../widgets/custom_bottom_nav_bar.dart';

class ReportItemFoundScreen extends ConsumerWidget {
  const ReportItemFoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(reportControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF27649A),
        centerTitle: true,
        title: const Text(
          'REPORT ITEM',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ReportForm(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}