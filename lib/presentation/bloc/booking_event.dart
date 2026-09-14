import 'package:equatable/equatable.dart';
import '../../domain/entities/room.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class SelectRoom extends BookingEvent {
  final Room room;

  const SelectRoom(this.room);

  @override
  List<Object?> get props => [room];
}

class SelectCheckInDate extends BookingEvent {
  final DateTime date;

  const SelectCheckInDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectCheckOutDate extends BookingEvent {
  final DateTime date;

  const SelectCheckOutDate(this.date);

  @override
  List<Object?> get props => [date];
}

class FilterGuests extends BookingEvent {
  final int? maxGuests;

  const FilterGuests(this.maxGuests);

  @override
  List<Object?> get props => [maxGuests];
}
