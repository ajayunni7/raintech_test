import '../../domain/entities/room.dart';
import '../../domain/entities/booking.dart';

class BookingValidationResult {
  final bool isValid;
  final String? errorMessage;

  const BookingValidationResult({required this.isValid, this.errorMessage});
}

int calculateNights(DateTime checkIn, DateTime checkOut) {
  final checkInDate = DateTime(checkIn.year, checkIn.month, checkIn.day);
  final checkOutDate = DateTime(checkOut.year, checkOut.month, checkOut.day);
  return checkOutDate.difference(checkInDate).inDays;
}

double calculateTotalPrice(int nights, double pricePerNight) {
  if (nights < 0) return 0.0;
  return nights * pricePerNight;
}

BookingValidationResult validateDates(DateTime checkIn, DateTime checkOut) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final checkInDate = DateTime(checkIn.year, checkIn.month, checkIn.day);
  final checkOutDate = DateTime(checkOut.year, checkOut.month, checkOut.day);

  if (checkInDate.isBefore(today)) {
    return const BookingValidationResult(
      isValid: false,
      errorMessage: 'Check-in cannot be before today.',
    );
  }

  if (!checkOutDate.isAfter(checkInDate)) {
    return const BookingValidationResult(
      isValid: false,
      errorMessage: 'Check-out must be strictly after check-in.',
    );
  }

  return const BookingValidationResult(isValid: true);
}

bool isRoomAvailable(
  Room room,
  DateTime checkIn,
  DateTime checkOut,
  List<Booking> existingBookings,
) {
  for (final booking in existingBookings) {
    if (booking.roomCode == room.code) {
      final requestedCheckIn = DateTime(checkIn.year, checkIn.month, checkIn.day);
      final requestedCheckOut = DateTime(checkOut.year, checkOut.month, checkOut.day);
      final bookedCheckIn = DateTime(booking.checkIn.year, booking.checkIn.month, booking.checkIn.day);
      final bookedCheckOut = DateTime(booking.checkOut.year, booking.checkOut.month, booking.checkOut.day);

      // Overlap condition:
      if (requestedCheckIn.isBefore(bookedCheckOut) && requestedCheckOut.isAfter(bookedCheckIn)) {
        return false;
      }
    }
  }
  return true;
}
