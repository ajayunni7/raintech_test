import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/booking_calculator.dart';
import 'booking_event.dart';
import 'booking_state.dart';

export 'booking_event.dart';
export 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingState()) {
    on<SelectRoom>(_onSelectRoom);
    on<SelectCheckInDate>(_onSelectCheckInDate);
    on<SelectCheckOutDate>(_onSelectCheckOutDate);
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

  void _calculateAndEmit(Emitter<BookingState> emit, BookingState newState) {
    // Cannot fully calculate if both dates are missing. Just clear errors and reset calculations.
    if (newState.checkInDate == null || newState.checkOutDate == null) {
      emit(newState.copyWith(
        nights: 0,
        totalPrice: 0.0,
        clearErrorMessage: true,
      ));
      return;
    }

    final validationResult = validateDates(newState.checkInDate!, newState.checkOutDate!);

    if (!validationResult.isValid) {
      emit(newState.copyWith(
        nights: 0,
        totalPrice: 0.0,
        errorMessage: validationResult.errorMessage,
        clearErrorMessage: false,
      ));
      return;
    }

    // Dates are valid, calculate nights and price.
    final nights = calculateNights(newState.checkInDate!, newState.checkOutDate!);
    final pricePerNight = newState.selectedRoom?.pricePerNight ?? 0.0;
    final totalPrice = calculateTotalPrice(nights, pricePerNight);

    emit(newState.copyWith(
      nights: nights,
      totalPrice: totalPrice,
      clearErrorMessage: true, // clear any previous errors
    ));
  }
}
