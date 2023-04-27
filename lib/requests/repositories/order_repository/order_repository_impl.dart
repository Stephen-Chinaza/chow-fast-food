import 'package:chow/model/data_models/order/get_order.dart';
import 'package:chow/model/data_models/order/track_order.dart';

import '../../../model/data_models/bookings/booking.dart';
import '../../../model/data_models/bookings/create_bookings.dart';
import '../../../model/data_models/order/create_order.dart';
import '../../../model/data_models/payment_info.dart';
import '../../../model/data_models/user/user_data.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<PaymentInfo> createOrder({CreateOrder? order}) async {
    final map =
        await Requests().post(AppStrings.createOrderUrl, body: order?.toMap());
    return PaymentInfo.fromMap(map);
  }

  @override
  Future<List<GetOrder>> getAllOrder() async {
    final map = await Requests().get(
      AppStrings.getAllOrderUrl,
    );

    return List<GetOrder>.from(map.map((x) => GetOrder.fromMap(x)));
  }

  @override
  Future<List<CreateBooking>> getRequestedBookings() async {
    final map = await Requests().get(AppStrings.getRequestedBookingUrl);

    return List<CreateBooking>.from(map.map((x) => CreateBooking.fromMap(x)));
  }

  @override
  Future<UserData> getSingleOrder({required String orderId}) async {
    final map = await Requests().get(
      AppStrings.getSingleOrderUrl(orderId: orderId),
    );
    return UserData.fromMap(map);
  }

  @override
  void deleteSingleOrder({required String orderId}) async {
    final value = await Requests().delete(
      AppStrings.deleteSingleOrderUrl(orderId: orderId),
    );
  }

  @override
  Future<TrackUserOrder> trackOrder({required String orderId}) async {
    final map = await Requests().get(
      AppStrings.trackOrderUrl(orderId: orderId),
    );
    return TrackUserOrder.fromMap(map);
  }

  @override
  Future<Booking> settleBooking(
      {required String paymentMethod, required String bookingId}) async {
    var payload = {"payment_method": paymentMethod, "booking_id": bookingId};

    final map =
        await Requests().post(AppStrings.settleBookingUrl, body: payload);

    return Booking.fromMap(map);
  }
}
