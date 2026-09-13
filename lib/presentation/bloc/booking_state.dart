import 'package:equatable/equatable.dart';
import '../../domain/entities/room.dart';

class BookingState extends Equatable {
  final Room? selectedRoom;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int nights;
  final double totalPrice;
  final String? errorMessage;

  const BookingState({
    this.selectedRoom,
    this.checkInDate,
    this.checkOutDate,
    this.nights = 0,
    this.totalPrice = 0.0,
    this.errorMessage,
  });

  BookingState copyWith({
    Room? selectedRoom,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? nights,
    double? totalPrice,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return BookingState(
      selectedRoom: selectedRoom ?? this.selectedRoom,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      nights: nights ?? this.nights,
      totalPrice: totalPrice ?? this.totalPrice,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        selectedRoom,
        checkInDate,
        checkOutDate,
        nights,
        totalPrice,
        errorMessage,
      ];
}
