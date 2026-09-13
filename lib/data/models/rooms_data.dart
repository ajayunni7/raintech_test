import '../../domain/entities/room.dart';

final List<Room> sampleRooms = [
  const Room(
    code: 'S101',
    type: 'Single',
    pricePerNight: 50.0,
    maxGuests: 1,
  ),
  const Room(
    code: 'D201',
    type: 'Double',
    pricePerNight: 80.0,
    maxGuests: 2,
  ),
  const Room(
    code: 'F301',
    type: 'Family',
    pricePerNight: 120.0,
    maxGuests: 4,
  ),
  const Room(
    code: 'K401',
    type: 'King Suite',
    pricePerNight: 150.0,
    maxGuests: 2,
  ),
  const Room(
    code: 'P501',
    type: 'Penthouse',
    pricePerNight: 300.0,
    maxGuests: 6,
  ),
];
