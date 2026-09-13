import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String code;
  final String type;
  final double pricePerNight;
  final int maxGuests;

  const Room({
    required this.code,
    required this.type,
    required this.pricePerNight,
    required this.maxGuests,
  });

  @override
  List<Object?> get props => [code, type, pricePerNight, maxGuests];
}
