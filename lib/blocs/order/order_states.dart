import 'package:equatable/equatable.dart';
import '../../model/data_models/bookings/booking.dart';
import '../../model/data_models/bookings/create_bookings.dart';
import '../../model/data_models/order/get_order.dart';
import '../../model/data_models/order/track_order.dart';
import '../../model/data_models/payment_info.dart';

abstract class OrderStates extends Equatable {
  const OrderStates();
}

class InitialState extends OrderStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderStates {
  @override
  List<Object> get props => [];
}

class OrderProcessing extends OrderStates {
  @override
  List<Object> get props => [];
}

class CreateOrderLoaded extends OrderStates {
  final PaymentInfo info;
  const CreateOrderLoaded(this.info);
  @override
  List<Object> get props => [info];
}

class GetAllOrderLoaded extends OrderStates {
  final List<GetOrder> order;
  const GetAllOrderLoaded(this.order);
  @override
  List<Object> get props => [order];
}

class AllOrderNetworkErr extends OrderStates {
  final String? message;
  const AllOrderNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class AllOrderApiErr extends OrderStates {
  final String? message;
  const AllOrderApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class DeleteOrderDone extends OrderStates {
  const DeleteOrderDone();
  @override
  List<Object> get props => [];
}

class TrackUserData extends OrderStates {
  final TrackUserOrder trackUserOrder;
  const TrackUserData(this.trackUserOrder);
  @override
  List<Object> get props => [trackUserOrder];
}

class OrderNetworkErr extends OrderStates {
  final String? message;
  const OrderNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class OrderApiErr extends OrderStates {
  final String? message;
  const OrderApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class RequestedBookingsLoaded extends OrderStates {
  final List<CreateBooking> bookingsData;
  const RequestedBookingsLoaded(this.bookingsData);
  @override
  List<Object> get props => [bookingsData];
}

class RequestedBookingsNetworkErr extends OrderStates {
  final String? message;
  const RequestedBookingsNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class RequestedBookingsApiErr extends OrderStates {
  final String? message;
  const RequestedBookingsApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class SettleBookingsLoading extends OrderStates {
  @override
  List<Object> get props => [];
}

class SettleBookingsLoaded extends OrderStates {
  final Booking bookingsData;
  const SettleBookingsLoaded(this.bookingsData);
  @override
  List<Object> get props => [bookingsData];
}

class SettleBookingsNetworkErr extends OrderStates {
  final String? message;
  const SettleBookingsNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class SettleBookingsApiErr extends OrderStates {
  final String? message;
  const SettleBookingsApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
