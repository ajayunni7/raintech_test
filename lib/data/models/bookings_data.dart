import '../../domain/entities/booking.dart';

final List<Booking> existingBookings = [
  Booking(
    roomCode: 'S101',
    checkIn: DateTime.now().add(const Duration(days: 1)),
    checkOut: DateTime.now().add(const Duration(days: 3)),
  ),
  Booking(
    roomCode: 'D201',
    checkIn: DateTime.now().add(const Duration(days: 2)),
    checkOut: DateTime.now().add(const Duration(days: 5)),
  ),
  Booking(
    roomCode: 'F301',
    checkIn: DateTime.now().add(const Duration(days: 5)),
    checkOut: DateTime.now().add(const Duration(days: 10)),
  ),
];
