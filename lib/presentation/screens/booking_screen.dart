import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/rooms_data.dart';
import '../bloc/booking_bloc.dart';
import '../widgets/booking_summary_widget.dart';
import '../widgets/date_range_picker_widget.dart';
import '../widgets/room_list_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book a Room', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            final displayedRooms = sampleRooms.where((r) => state.maxGuestsFilter == null || r.maxGuests >= state.maxGuestsFilter!).toList();

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select Dates',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Room',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline, size: 16, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<int?>(
                                value: state.maxGuestsFilter,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                                items: const [
                                  DropdownMenuItem(value: null, child: Text('Any Guests', style: TextStyle(fontSize: 14))),
                                  DropdownMenuItem(value: 1, child: Text('1+ Guests', style: TextStyle(fontSize: 14))),
                                  DropdownMenuItem(value: 2, child: Text('2+ Guests', style: TextStyle(fontSize: 14))),
                                  DropdownMenuItem(value: 3, child: Text('3+ Guests', style: TextStyle(fontSize: 14))),
                                  DropdownMenuItem(value: 4, child: Text('4+ Guests', style: TextStyle(fontSize: 14))),
                                  DropdownMenuItem(value: 5, child: Text('5+ Guests', style: TextStyle(fontSize: 14))),
                                ],
                                onChanged: (value) {
                                  context.read<BookingBloc>().add(FilterGuests(value));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: RoomListWidget(
                      rooms: displayedRooms,
                      selectedRoomCode: state.selectedRoom?.code,
                      roomAvailability: state.roomAvailability,
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


