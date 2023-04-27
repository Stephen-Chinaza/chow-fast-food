import 'package:flutter_bloc/flutter_bloc.dart';

import '../../requests/repositories/bookings_repository/bookings_repository.dart';
import '../../utils/exceptions.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsStates> {
  BookingsCubit({
    required this.bookingRepository,
  }) : super(const InitialState());
  final BookingsRepository bookingRepository;

  Future<void> createBookings(
      {required String phone,
      required String comment,
      required double latitude,
      required double longitude,
      required String location}) async {
    try {
      emit(BookingsProcessing());

      final bookings = await bookingRepository.createBookings(
        phone: phone,
        comment: comment,
        latitude: latitude,
        longitude: longitude,
        location: location,
      );

      emit(BookingsLoaded(bookings));
    } on ApiException catch (e) {
      emit(BookingsApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(BookingsNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
