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
