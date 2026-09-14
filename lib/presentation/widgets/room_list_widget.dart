import 'package:flutter/material.dart';
import '../../core/utils/currency_formatter.dart';
import '../../domain/entities/room.dart';

class RoomListWidget extends StatelessWidget {
  final List<Room> rooms;
  final String? selectedRoomCode;
  final ValueChanged<Room> onRoomSelected;
  final Map<String, bool> roomAvailability;

  const RoomListWidget({
    super.key,
    required this.rooms,
    required this.selectedRoomCode,
    required this.onRoomSelected,
    this.roomAvailability = const {},
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: rooms.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final room = rooms[index];
        final isSelected = room.code == selectedRoomCode;
        final isAvailable = roomAvailability[room.code] ?? true;

        return InkWell(
          onTap: isAvailable ? () => onRoomSelected(room) : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.05) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected 
                    ? Theme.of(context).colorScheme.primary 
                    : const Color(0xFFE2E8F0),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                if (!isSelected)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            room.type,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isAvailable ? const Color(0xFF0F172A) : Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              room.code,
                              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person_outline, size: 16, color: isAvailable ? const Color(0xFF64748B) : Colors.grey.shade300),
                          const SizedBox(width: 4),
                          Text(
                            'Up to ${room.maxGuests} guests',
                            style: TextStyle(
                              fontSize: 14,
                              color: isAvailable ? const Color(0xFF64748B) : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                      if (!isAvailable) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.event_busy, size: 16, color: Theme.of(context).colorScheme.error),
                            const SizedBox(width: 4),
                            Text(
                              'Not available for selected dates',
                              style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatCurrency(room.pricePerNight),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isAvailable ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
                      ),
                    ),
                    Text(
                      '/ night',
                      style: TextStyle(
                        fontSize: 12,
                        color: isAvailable ? const Color(0xFF64748B) : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
