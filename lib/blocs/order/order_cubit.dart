import 'package:chow/model/data_models/order/create_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/order_view_model.dart';
import '../../requests/repositories/order_repository/order_repository.dart';
import '../../utils/exceptions.dart';
import 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit({required this.orderRepository, required this.viewModel})
      : super(const InitialState());
  final OrderRepository orderRepository;
  final OrderViewModel viewModel;

  Future<void> createOrder(CreateOrder order) async {
    try {
      emit(OrderProcessing());

      final paymentInfo = await orderRepository.createOrder(order: order);

      emit(CreateOrderLoaded(paymentInfo));
    } on ApiException catch (e) {
      emit(OrderApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(OrderNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getAllOrder() async {
    try {
      emit(OrderProcessing());

      final allOrder = await orderRepository.getAllOrder();

      emit(GetAllOrderLoaded(allOrder));
      await viewModel.getAllOrders(
        allOrder,
      );
    } on ApiException catch (e) {
      emit(AllOrderApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(AllOrderNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getRequestedBookings() async {
    try {
      emit(OrderProcessing());

      final bookings = await orderRepository.getRequestedBookings();

      await viewModel.getRequestedBooking(bookings);
      emit(RequestedBookingsLoaded(bookings));
    } on ApiException catch (e) {
      emit(RequestedBookingsApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(RequestedBookingsNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> settleBooking(
      {required String paymentMethod, required String bookingId}) async {
    try {
      emit(OrderProcessing());

      final paymentInfo = await orderRepository.settleBooking(
          paymentMethod: paymentMethod, bookingId: bookingId);

      emit(SettleBookingsLoaded(paymentInfo));
    } on ApiException catch (e) {
      emit(SettleBookingsApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(SettleBookingsNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getSingleOrder({
    required String orderId,
  }) async {
    try {
      emit(OrderProcessing());

      final order = await orderRepository.getSingleOrder(
        orderId: orderId,
      );

      await viewModel.getUserOrder(order);
      // emit(GetOrderLoaded(order));
    } on ApiException catch (e) {
      emit(OrderApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException) {
        emit(OrderNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> deleteSingleOrder({
    required String orderId,
  }) async {
    try {
      emit(OrderProcessing());

      final order = orderRepository.deleteSingleOrder(
        orderId: orderId,
      );

      await viewModel.deleteUserOrder();
      emit(const DeleteOrderDone());
    } on ApiException catch (e) {
      emit(OrderApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException) {
        emit(OrderNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> trackUserOrder({
    required String orderId,
  }) async {
    try {
      emit(OrderProcessing());

      final trackUserOrder = await orderRepository.trackOrder(orderId: orderId);

      await viewModel.trackUserOrder(trackUserOrder);
      emit(TrackUserData(trackUserOrder));
    } on ApiException catch (e) {
      emit(OrderApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException) {
        emit(OrderNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
