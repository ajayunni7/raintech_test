import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerWidget extends StatelessWidget {
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final ValueChanged<DateTime> onCheckInSelected;
  final ValueChanged<DateTime> onCheckOutSelected;

  const DateRangePickerWidget({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.onCheckInSelected,
    required this.onCheckOutSelected,
  });

  Future<void> _pickCheckInDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final initialDate = checkInDate != null && !checkInDate!.isBefore(firstDate) 
        ? checkInDate! 
        : firstDate;
    
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      onCheckInSelected(pickedDate);
    }
  }

  Future<void> _pickCheckOutDate(BuildContext context) async {
    if (checkInDate == null) return;

    final now = DateTime.now();
    // check-out must be strictly after check-in based on business logic, 
    // so we can set firstDate to checkInDate + 1 day.
    final minDate = checkInDate!.add(const Duration(days: 1));
    final initialDate = checkOutDate != null && !checkOutDate!.isBefore(minDate) 
        ? checkOutDate! 
        : minDate;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: minDate,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate != null) {
      onCheckOutSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd();

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _pickCheckInDate(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Check-in Date',
                border: OutlineInputBorder(),
              ),
              child: Text(
                checkInDate != null ? dateFormat.format(checkInDate!) : 'Select',
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: checkInDate == null ? null : () => _pickCheckOutDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Check-out Date',
                border: const OutlineInputBorder(),
                filled: checkInDate == null,
                fillColor: checkInDate == null ? Colors.grey.shade200 : null,
              ),
              child: Text(
                checkOutDate != null ? dateFormat.format(checkOutDate!) : 'Select',
                style: TextStyle(
                  color: checkInDate == null ? Colors.grey : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
