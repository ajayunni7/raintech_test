import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String roomCode;
  final DateTime checkIn;
  final DateTime checkOut;

  const Booking({
    required this.roomCode,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  List<Object?> get props => [roomCode, checkIn, checkOut];
}
