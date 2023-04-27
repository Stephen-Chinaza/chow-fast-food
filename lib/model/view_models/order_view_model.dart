import 'package:chow/model/data_models/user/user.dart';
import 'package:chow/res/enum.dart';

import '../data_models/bookings/create_bookings.dart';
import '../data_models/order/get_order.dart';
import '../data_models/order/order_item.dart';
import '../data_models/order/track_order.dart' as trak;
import '../data_models/user/user_data.dart';
import 'base_viewmodel.dart';

class OrderViewModel extends BaseViewModel {
  List<CreateBooking>? _bookings;

  UserData? _getOrder;
  trak.TrackUserOrder? _trackOrder;
  List<GetOrder>? _order;

  getUserOrder(UserData getOrder) {
    _getOrder = getOrder;
    setViewState(ViewState.success);
  }

  Future<void> getAllOrders(
    List<GetOrder> order,
  ) async {
    _order = order;

    setViewState(ViewState.success);
  }

  deleteUserOrder() {
    setViewState(ViewState.success);
  }

  trackUserOrder(trak.TrackUserOrder trackOrder) {
    _trackOrder = trackOrder;
    setViewState(ViewState.success);
  }

  Future<void> getRequestedBooking(
    List<CreateBooking> booking,
  ) async {
    _bookings = booking;

    setViewState(ViewState.success);
  }

  UserData? get getOrderData => _getOrder;
  trak.TrackUserOrder? get trackOrderData => _trackOrder;

  List<OrderItem> get myOrder => orderList();

  List<OrderItem> orderList() {
    List<OrderItem> list = [];

    for (var item in _order ?? []) {
      list.addAll(item.orderItem);
    }

    return list;
  }

  List<OrderItem> get myBookings => bookingList();

  List<String> bookingId = [];

  Map<String, User> bookingDetails = {};

  List<OrderItem> bookingList() {
    List<OrderItem> list = [];

    for (var item in _bookings ?? []) {
      list.addAll(item.order.orderItem);
      bookingId.add(item.id);
      for (var orderItem in item.order.orderItem) {
        bookingDetails[orderItem.id] = item.bookingFrom;
      }
    }

    return list;
  }
}
