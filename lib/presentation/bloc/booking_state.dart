import 'package:equatable/equatable.dart';
import '../../domain/entities/room.dart';

class BookingState extends Equatable {
  final Room? selectedRoom;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int nights;
  final double totalPrice;
  final String? errorMessage;
  final Map<String, bool> roomAvailability;
  final int? maxGuestsFilter;

  const BookingState({
    this.selectedRoom,
    this.checkInDate,
    this.checkOutDate,
    this.nights = 0,
    this.totalPrice = 0.0,
    this.errorMessage,
    this.roomAvailability = const {},
    this.maxGuestsFilter,
  });

  BookingState copyWith({
    Room? selectedRoom,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? nights,
    double? totalPrice,
    String? errorMessage,
    bool clearErrorMessage = false,
    Map<String, bool>? roomAvailability,
    int? maxGuestsFilter,
    bool clearMaxGuestsFilter = false,
    bool clearSelectedRoom = false,
  }) {
    return BookingState(
      selectedRoom: clearSelectedRoom ? null : (selectedRoom ?? this.selectedRoom),
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      nights: nights ?? this.nights,
      totalPrice: totalPrice ?? this.totalPrice,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      roomAvailability: roomAvailability ?? this.roomAvailability,
      maxGuestsFilter: clearMaxGuestsFilter ? null : (maxGuestsFilter ?? this.maxGuestsFilter),
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
        roomAvailability,
        maxGuestsFilter,
      ];
}
