import 'package:equatable/equatable.dart';

import '../../model/data_models/bookings/create_bookings.dart';

abstract class BookingsStates extends Equatable {
  const BookingsStates();
}

class InitialState extends BookingsStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class BookingsLoading extends BookingsStates {
  @override
  List<Object> get props => [];
}

class BookingsProcessing extends BookingsStates {
  @override
  List<Object> get props => [];
}

class BookingsLoaded extends BookingsStates {
  final CreateBooking bookingsData;
  const BookingsLoaded(this.bookingsData);
  @override
  List<Object> get props => [bookingsData];
}

class BookingsNetworkErr extends BookingsStates {
  final String? message;
  const BookingsNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class BookingsApiErr extends BookingsStates {
  final String? message;
  const BookingsApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
