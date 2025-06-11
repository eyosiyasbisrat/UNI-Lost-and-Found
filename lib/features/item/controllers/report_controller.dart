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

  void setFoundDate(DateTime date) {
    state = state.copyWith(
      foundDate: DateTime(
        date.year,
        date.month,
        date.day,
        state.foundDate.hour,
        state.foundDate.minute,
      ),
    );
  }

  void setFoundTime(TimeOfDay time) {
    state = state.copyWith(
      foundDate: DateTime(
        state.foundDate.year,
        state.foundDate.month,
        state.foundDate.day,
        time.hour,
        time.minute,
      ),
    );
  }

  Future<void> submitItem() async {
    state = state.copyWith(error: null);

    if (state.itemNameController.text.isEmpty ||
        state.locationController.text.isEmpty ||
        state.descriptionController.text.isEmpty) {
      state = state.copyWith(error: 'All fields must be filled.');
      return;
    }

    // For now, using a placeholder for imageUrl and userId.
    // In a real application, you'd handle image upload and get the actual userId.
    final newItem = Item(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
      name: state.itemNameController.text,
      description: state.descriptionController.text,
      location: state.locationController.text,
      imageUrl: 'https://via.placeholder.com/150', // Placeholder
      status: state.isFound ? ItemStatus.found : ItemStatus.lost,
      userId: 'current_user_id', // Placeholder
      foundDate: state.foundDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await _itemNotifier.addItem(newItem);
      // Clear form after successful submission
      state.itemNameController.clear();
      state.locationController.clear();
      state.descriptionController.clear();
      state = state.copyWith(isFound: true, foundDate: DateTime.now());
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

class ReportState {
  final bool isFound;
  final TextEditingController itemNameController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final DateTime foundDate;
  final String? error;

  ReportState({
    required this.isFound,
    required this.itemNameController,
    required this.locationController,
    required this.descriptionController,
    required this.foundDate,
    this.error,
  });

  
