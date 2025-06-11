import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../controllers/report_controller.dart';

class ReportForm extends ConsumerWidget {
  const ReportForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(reportControllerProvider.notifier);
    final state = ref.watch(reportControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _toggle(
              "Found Item",
              state.isFound,
                  () => controller.setFound(true),
              const Color(0xFF27649A), // Dark blue for selected
              Colors.white, // Text color for selected
            ),
            _toggle(
              "Lost Item",
              !state.isFound,
                  () => controller.setFound(false),
              Colors.grey[300]!, // Light grey for unselected
              Colors.black, // Text color for unselected
            ),
          ],
        ),
        const SizedBox(height: 16),
        _label("Item Name"),
        _input(state.itemNameController),
        const SizedBox(height: 12),
        _label("Location"),
        _input(state.locationController),
        const SizedBox(height: 12),
        _label("Time"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: state.foundDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  controller.setFoundDate(selectedDate);
                }
              },
              child: Text(
                DateFormat('dd MMM yyyy').format(state.foundDate),
                style: _boldStyle(),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(state.foundDate),
                );
                if (selectedTime != null) {
                  controller.setFoundTime(selectedTime);
                }
              },
              child: Text(
                DateFormat('hh:mm a').format(state.foundDate),
                style: _boldStyle(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _label("Description"),
        _input(state.descriptionController, maxLines: 3),
        const SizedBox(height: 12),
        _label("Picture"),
        const SizedBox(height: 8),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/image2.png", // Placeholder image
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  // TODO: Implement image picking functionality
                },
                backgroundColor: const Color(0xFF27649A),
                child: const Icon(Icons.edit, size: 20, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _actionButton("Cancel", Colors.grey[300]!, Colors.black, () => context.pop()),
            _actionButton("Confirm", const Color(0xFF27649A), Colors.white, () async {
              await controller.submitItem();
              if (context.mounted && state.error == null) {
                context.pop(); // Navigate back on success
              }
            }),
          ],
        ),
      ],
    );
  }

  Widget _toggle(String label, bool selected, VoidCallback onTap, Color selectedBg, Color selectedFg) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? selectedBg : Colors.grey[300],
        foregroundColor: selected ? selectedFg : Colors.black,
        elevation: selected ? 6 : 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      ),
      child: Text(label),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
  );

  Widget _input(TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(),
      ),
    );
  }

  TextStyle _boldStyle() => const TextStyle(fontWeight: FontWeight.bold);

  Widget _actionButton(String label, Color bg, Color fg, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
      ),
      child: Text(label),
    );
  }
}
