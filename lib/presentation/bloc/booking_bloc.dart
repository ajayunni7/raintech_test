import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/booking_calculator.dart';
import '../../data/models/rooms_data.dart';
import '../../data/models/bookings_data.dart';
import '../../domain/entities/room.dart';
import 'booking_event.dart';
import 'booking_state.dart';

export 'booking_event.dart';
export 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(_getInitialState()) {
    on<SelectRoom>(_onSelectRoom);
    on<SelectCheckInDate>(_onSelectCheckInDate);
    on<SelectCheckOutDate>(_onSelectCheckOutDate);
    on<FilterGuests>(_onFilterGuests);
    on<ClearSelection>(_onClearSelection);
  }

  static BookingState _getInitialState() {
    Map<String, bool> availability = {};
    for (final room in sampleRooms) {
      availability[room.code] = true;
    }
    return BookingState(roomAvailability: availability);
  }

  void _onSelectRoom(SelectRoom event, Emitter<BookingState> emit) {
    _calculateAndEmit(
      emit,
      state.copyWith(selectedRoom: event.room),
    );
  }

  void _onSelectCheckInDate(SelectCheckInDate event, Emitter<BookingState> emit) {
    _calculateAndEmit(
      emit,
      state.copyWith(checkInDate: event.date),
    );
  }

  void _onSelectCheckOutDate(SelectCheckOutDate event, Emitter<BookingState> emit) {
    _calculateAndEmit(
      emit,
      state.copyWith(checkOutDate: event.date),
    );
  }

  void _onFilterGuests(FilterGuests event, Emitter<BookingState> emit) {
    _calculateAndEmit(
      emit,
      state.copyWith(
        maxGuestsFilter: event.maxGuests,
        clearMaxGuestsFilter: event.maxGuests == null,
      ),
    );
  }

  void _onClearSelection(ClearSelection event, Emitter<BookingState> emit) {
    _calculateAndEmit(
      emit,
      state.copyWith(clearSelectedRoom: true),
    );
  }

  void _calculateAndEmit(Emitter<BookingState> emit, BookingState newState) {
    Map<String, bool> availability = {};

    if (newState.checkInDate != null && newState.checkOutDate != null) {
      final validationResult = validateDates(newState.checkInDate!, newState.checkOutDate!);

      if (!validationResult.isValid) {
        emit(newState.copyWith(
          nights: 0,
          totalPrice: 0.0,
          errorMessage: validationResult.errorMessage,
          clearErrorMessage: false,
          roomAvailability: {},
        ));
        return;
      }

      for (final room in sampleRooms) {
        availability[room.code] = isRoomAvailable(room, newState.checkInDate!, newState.checkOutDate!, existingBookings);
      }
    } else {
      for (final room in sampleRooms) {
        availability[room.code] = true;
      }
    }

    Room? selected = newState.selectedRoom;
    bool clearSelected = false;

    if (selected != null) {
      if (availability[selected.code] == false) {
        clearSelected = true;
      }
      if (newState.maxGuestsFilter != null && selected.maxGuests < newState.maxGuestsFilter!) {
        clearSelected = true;
      }
    }

    if (newState.checkInDate == null || newState.checkOutDate == null) {
      emit(newState.copyWith(
        clearSelectedRoom: clearSelected,
        nights: 0,
        totalPrice: 0.0,
        clearErrorMessage: true,
        roomAvailability: availability,
      ));
      return;
    }

    // Dates are valid, calculate nights and price.
    final nights = calculateNights(newState.checkInDate!, newState.checkOutDate!);
    final pricePerNight = (clearSelected ? null : selected)?.pricePerNight ?? 0.0;
    final totalPrice = calculateTotalPrice(nights, pricePerNight);

    emit(newState.copyWith(
      clearSelectedRoom: clearSelected,
      nights: nights,
      totalPrice: totalPrice,
      clearErrorMessage: true, // clear any previous errors
      roomAvailability: availability,
    ));
  }
}

