import 'package:chow/model/data_models/payment_info.dart';

import '../../../model/data_models/bookings/booking.dart';
import '../../../model/data_models/bookings/create_bookings.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'bookings_repository.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  @override
  Future<CreateBooking> createBookings(
      {required String phone,
      required String comment,
      required double latitude,
      required double longitude,
      required String location}) async {
    var payload = {
      "phone_number": phone,
      "comment": comment,
      "latitude": latitude,
      "longitude": longitude,
      "location": location
    };
    final map =
        await Requests().post(AppStrings.createBookingUrl, body: payload);

    return CreateBooking.fromMap(map);
  }
}
