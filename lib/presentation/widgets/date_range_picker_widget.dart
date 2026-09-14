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
    final dateFormat = DateFormat('MMM d, yyyy');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              onTap: () => _pickCheckInDate(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-in', 
                      style: TextStyle(
                        color: Colors.grey.shade600, 
                        fontSize: 12, 
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_month_rounded, size: 18, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          checkInDate != null ? dateFormat.format(checkInDate!) : 'Add Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: checkInDate != null ? FontWeight.w600 : FontWeight.w400,
                            color: checkInDate != null ? const Color(0xFF0F172A) : Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
              onTap: checkInDate == null ? null : () => _pickCheckOutDate(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-out', 
                      style: TextStyle(
                        color: Colors.grey.shade600, 
                        fontSize: 12, 
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded, 
                          size: 18, 
                          color: checkInDate == null ? Colors.grey.shade300 : Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          checkOutDate != null ? dateFormat.format(checkOutDate!) : 'Add Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: checkOutDate != null ? FontWeight.w600 : FontWeight.w400,
                            color: checkOutDate != null 
                                ? const Color(0xFF0F172A) 
                                : (checkInDate == null ? Colors.grey.shade300 : Colors.grey.shade400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
