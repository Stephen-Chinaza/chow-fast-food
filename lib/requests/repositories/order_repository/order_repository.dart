import '../../../model/data_models/bookings/booking.dart';
import '../../../model/data_models/bookings/create_bookings.dart';
import '../../../model/data_models/order/create_order.dart';
import '../../../model/data_models/order/get_order.dart';
import '../../../model/data_models/order/track_order.dart';
import '../../../model/data_models/payment_info.dart';
import '../../../model/data_models/user/user_data.dart';

abstract class OrderRepository {
  Future<PaymentInfo> createOrder({CreateOrder order});

  Future<UserData> getSingleOrder({required String orderId});
  Future<List<CreateBooking>> getRequestedBookings();

  Future<TrackUserOrder> trackOrder({required String orderId});
  Future<List<GetOrder>> getAllOrder();
  void deleteSingleOrder({required String orderId});

  Future<Booking> settleBooking(
      {required String paymentMethod, required String bookingId});
}
