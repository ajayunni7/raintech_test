import '../../domain/entities/room.dart';

final List<Room> sampleRooms = [
  const Room(code: 'S101', type: 'Single', pricePerNight: 500.0, maxGuests: 1),
  const Room(code: 'D201', type: 'Double', pricePerNight: 800.0, maxGuests: 2),
  const Room(code: 'F301', type: 'Family', pricePerNight: 1200.0, maxGuests: 4),
  const Room(
    code: 'K401',
    type: 'King Suite',
    pricePerNight: 1500.0,
    maxGuests: 2,
  ),
  const Room(
    code: 'P501',
    type: 'Penthouse',
    pricePerNight: 3000.0,
    maxGuests: 6,
  ),
];
