import '../../../model/data_models/bookings/booking.dart';
import '../../../model/data_models/bookings/create_bookings.dart';

abstract class BookingsRepository {
  Future<CreateBooking> createBookings({
    required String phone,
    required String comment,
    required double latitude,
    required double longitude,
    required String location,
  });
}
