import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/order/order.dart';
import '../../model/data_models/order/order_item.dart';
import '../../model/data_models/user/user.dart';
import '../../model/view_models/order_view_model.dart';
import '../../requests/repositories/order_repository/order_repository_impl.dart';
import '../widgets/cart_icon.dart';
import '../widgets/custom_toggle.dart';
import '../widgets/empty_widget.dart';
import '../widgets/food_container_view.dart';
import '../widgets/loading_page.dart';

class Bookings extends StatelessWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (BuildContext context) => OrderCubit(
        orderRepository: OrderRepositoryImpl(),
        viewModel: Provider.of<OrderViewModel>(context, listen: false),
      ),
      child: const BookingsScreen(),
    );
  }
}

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with WidgetsBindingObserver {
  late PageController _controller;
  int initCount = 0;

  final _scrollController = ScrollController();

  late OrderCubit _orderCubit;

  void _initScrollListener() {
    _scrollController.addListener(() {
      final triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;

      // if (_scrollController.position.pixels > triggerFetchMoreSize) {
      //   _productsCubit.getAllProducts(page: _productsCubit.page);
      // }
    });
  }

  void _asyncInitMethod() {
    _orderCubit = context.read<OrderCubit>();
    _orderCubit.getAllOrder();
    _orderCubit.getRequestedBookings();
  }

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: 0,
    );

    WidgetsBinding.instance.addObserver(this);
    _asyncInitMethod();
    _initScrollListener();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      initCount = index;
    });
  }

  void onFilterSelected(int index) {
    setState(() {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
        centerTitle: true,
        actions: const [CartIcon(), SizedBox(width: 10)],
      ),
      body: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OrderProcessing) {
              return const LoadingPage(length: 12);
            } else if (state is OrderNetworkErr) {
              return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () {
                    _orderCubit.getAllOrder();
                    _orderCubit.getRequestedBookings();
                  });
            } else if (state is OrderApiErr) {
              return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () {
                    _orderCubit.getAllOrder();
                    _orderCubit.getRequestedBookings();
                  });
            }
            final List<OrderItem> orders = _orderCubit.viewModel.myOrder;
            final List<OrderItem> bookings = _orderCubit.viewModel.myBookings;
            final List<String> bookingId = _orderCubit.viewModel.bookingId;

            final Map<String, User> bookingDetails =
                _orderCubit.viewModel.bookingDetails;

            return Column(
              children: [
                SizedBox(
                  height: 70,
                  child: CustomToggle(
                    title: const ['My Bookings', 'Booking Request'],
                    onSelected: onFilterSelected,
                  ),
                ),
                Expanded(
                    child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  onPageChanged: _onPageChanged,
                  children: [
                    MealContainer.bookings(dataList: orders),
                    MealContainer.request(
                        dataList: bookings,
                        bookingDetails: bookingDetails,
                        bookingId: bookingId),
                  ],
                )),
              ],
            );
          }),
    );
  }
}
