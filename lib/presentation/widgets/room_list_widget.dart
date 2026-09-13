import 'package:flutter/material.dart';
import '../../domain/entities/room.dart';

class RoomListWidget extends StatelessWidget {
  final List<Room> rooms;
  final String? selectedRoomCode;
  final ValueChanged<Room> onRoomSelected;

  const RoomListWidget({
    super.key,
    required this.rooms,
    required this.selectedRoomCode,
    required this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        final isSelected = room.code == selectedRoomCode;

        return Card(
          elevation: isSelected ? 4.0 : 1.0,
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
          child: ListTile(
            title: Text('${room.type} (${room.code})'),
            subtitle: Text('Max Guests: ${room.maxGuests}'),
            trailing: Text('\$${room.pricePerNight.toStringAsFixed(2)} / night'),
            onTap: () => onRoomSelected(room),
            selected: isSelected,
          ),
        );
      },
    );
  }
}
