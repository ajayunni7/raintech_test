import 'package:flutter_test/flutter_test.dart';
import 'package:raintech_test/core/utils/booking_calculator.dart';

void main() {
  group('Booking Calculator Tests', () {
    test('calculateNights correctly calculates nights for multi-night stay', () {
      final checkIn = DateTime(2023, 10, 1);
      final checkOut = DateTime(2023, 10, 5);
      expect(calculateNights(checkIn, checkOut), 4);
    });

    test('calculateTotalPrice correctly calculates total price', () {
      expect(calculateTotalPrice(4, 150.0), 600.0);
    });

    test('validateDates returns valid for normal case', () {
      final now = DateTime.now();
      final checkIn = now.add(const Duration(days: 1));
      final checkOut = now.add(const Duration(days: 5));
      final result = validateDates(checkIn, checkOut);
      
      expect(result.isValid, isTrue);
      expect(result.errorMessage, isNull);
    });

    test('validateDates returns invalid for same-day dates', () {
      final now = DateTime.now();
      final checkIn = now.add(const Duration(days: 1));
      final checkOut = checkIn;
      final result = validateDates(checkIn, checkOut);
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Check-out must be strictly after check-in.');
    });

    test('validateDates returns invalid for checkout before checkin', () {
      final now = DateTime.now();
      final checkIn = now.add(const Duration(days: 5));
      final checkOut = now.add(const Duration(days: 2));
      final result = validateDates(checkIn, checkOut);
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Check-out must be strictly after check-in.');
    });

    test('validateDates returns invalid for past check-in', () {
      final now = DateTime.now();
      final checkIn = now.subtract(const Duration(days: 2));
      final checkOut = now.add(const Duration(days: 2));
      final result = validateDates(checkIn, checkOut);
      
      expect(result.isValid, isFalse);
      expect(result.errorMessage, 'Check-in cannot be before today.');
    });
  });
}
