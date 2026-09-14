import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/room.dart';
import '../bloc/booking_bloc.dart';
import '../widgets/booking_summary_widget.dart';
import '../widgets/date_range_picker_widget.dart';
import '../widgets/room_list_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  static const List<Room> _mockRooms = [
    Room(code: 'SGL', type: 'Single Room', pricePerNight: 100.0, maxGuests: 1),
    Room(code: 'DBL', type: 'Double Room', pricePerNight: 150.0, maxGuests: 2),
    Room(code: 'SUITE', type: 'Luxury Suite', pricePerNight: 300.0, maxGuests: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Screen'),
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select Dates',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DateRangePickerWidget(
                    checkInDate: state.checkInDate,
                    checkOutDate: state.checkOutDate,
                    onCheckInSelected: (date) {
                      context.read<BookingBloc>().add(SelectCheckInDate(date));
                    },
                    onCheckOutSelected: (date) {
                      context.read<BookingBloc>().add(SelectCheckOutDate(date));
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Select Room',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: RoomListWidget(
                      rooms: _mockRooms,
                      selectedRoomCode: state.selectedRoom?.code,
                      onRoomSelected: (room) {
                        context.read<BookingBloc>().add(SelectRoom(room));
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  BookingSummaryWidget(
                    nights: state.nights,
                    totalPrice: state.totalPrice,
                    errorMessage: state.errorMessage,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
