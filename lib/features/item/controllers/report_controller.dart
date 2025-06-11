import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uni_lost_and_found/features/item/domain/models/item.dart';
import 'package:uni_lost_and_found/features/item/presentation/providers/item_provider.dart';

final reportControllerProvider =
StateNotifierProvider<ReportController, ReportState>((ref) {
  final itemNotifier = ref.read(itemProvider.notifier);
  return ReportController(itemNotifier);
});

class ReportController extends StateNotifier<ReportState> {
  final ItemNotifier _itemNotifier;

  ReportController(this._itemNotifier)
      : super(ReportState(
    isFound: true,
    itemNameController: TextEditingController(),
    locationController: TextEditingController(),
    descriptionController: TextEditingController(),
    foundDate: DateTime.now(),
    error: null,
  ));

  void setFound(bool value) {
    state = state.copyWith(isFound: value);
  }

  