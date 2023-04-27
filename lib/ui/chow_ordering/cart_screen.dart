import 'package:chow/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/bookings/bookings.dart';
import '../../blocs/order/order.dart';
import '../../blocs/products/products.dart';
import '../../model/data_models/order/create_order.dart';
import '../../model/data_models/product/cart.dart';
import '../../model/view_models/order_view_model.dart';
import '../../model/view_models/products_view_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/bookings_repository/booking_repository_impl.dart';
import '../../requests/repositories/order_repository/order_repository_impl.dart';
import '../../requests/repositories/products_repository/product_repository_impl.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import '../widgets/text_edit_view.dart';
import 'widget/amount_summary_card.dart';
import 'widget/cart_item_card.dart';
import 'widget/delivery_options_card.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<OrderCubit>(
        create: (BuildContext context) => OrderCubit(
            orderRepository: OrderRepositoryImpl(),
            viewModel: Provider.of<OrderViewModel>(context, listen: false)),
      ),
      BlocProvider<ProductsCubit>(
        create: (BuildContext context) => ProductsCubit(
            productsRepository: ProductRepositoryImpl(),
            viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      ),
      BlocProvider<BookingsCubit>(
        create: (BuildContext context) => BookingsCubit(
          bookingRepository: BookingsRepositoryImpl(),
        ),
      ),
    ], child: const CartScreen());
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  late ProductsCubit _productsCubit;
  late BookingsCubit _bookingsCubit;

  late OrderCubit _orderCubit;
  bool isLoading = false;
  double cartTotalAmount = 0.0;

  List<Items> cartItems = [];
  PaymentMethod paymentMethod = PaymentMethod.none;

  var phoneNumberController = TextEditingController();
  var commentController = TextEditingController();

  @override
  void initState() {
    _productsCubit = context.read<ProductsCubit>();
    _orderCubit = context.read<OrderCubit>();
    _bookingsCubit = context.read<BookingsCubit>();
    _productsCubit.getCartProduct().then((value) => {
          setState(() {}),
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false).user!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: CustomText(
          size: 24,
          text: 'Cart',
          color: Theme.of(context).textTheme.bodyText1!.color,
          weight: FontWeight.w600,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(
              Icons.more_vert_outlined,
              size: 22,
            ),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomText(
              size: 24,
              text: 'Items Ordered',
              color: Theme.of(context).textTheme.bodyText1!.color,
              weight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocConsumer<ProductsCubit, ProductsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const LoadingPage(
                    length: 3,
                  );
                } else if (state is CartNetworkErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getCartProduct(),
                  );
                } else if (state is CartApiErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: () => _productsCubit.getCartProduct(),
                  );
                }
                cartItems = _productsCubit.viewModel.cart;

                cartTotalAmount = _productsCubit.viewModel.cartTotalAmount;

                if (cartItems.isEmpty) {
                  return SizedBox(
                    height: 120,
                    child: Center(
                        child: Text('Add Items to cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.secondary,
                            ))),
                  );
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final cart = cartItems[index];

                        return CartItemCard(
                          minCount: 1,
                          onPressed: () => _productsCubit.getCartProduct(
                              productId: cart.product?.id ?? ''),
                          defaultCount:
                              cart.quantity != null ? cart.quantity.toInt() : 0,
                          amount: cart.product?.price ?? '',
                          currency: 'NGN ',
                          image: cart.product?.image ?? '',
                          showCombo: (cart.quantity == null) ? true : false,
                          showQuantity: (cart.quantity != null) ? true : false,
                          subTitle: cart.product?.vendor?.businessName ?? '',
                          title: cart.product?.name ?? '',
                        );
                      }));
                }
              }),
          DeliveryOption(address: user.location ?? ''),
          const SizedBox(
            height: 19,
          ),
          Consumer<ProductsViewModel>(builder: (BuildContext context,
              ProductsViewModel viewModel, Widget? child) {
            cartItems = viewModel.cart;

            return AmountSummaryCard(
                amount: AppUtils.convertPrice(
                    viewModel.cartTotalAmount.toString()));
          }),
          const SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: BlocConsumer<OrderCubit, OrderStates>(
              builder: (context, state) {
                return ButtonView(
                    disabled: cartItems.isEmpty ? true : false,
                    onPressed: () {
                      AppNavigator.pushAndStackNamed(context,
                              name: AppRoutes.paymentMethodScreen,
                              arguments: cartTotalAmount.toString())
                          .then((method) {
                        paymentMethod = method;

                        switch (method) {
                          case PaymentMethod.card:
                            {
                              final order = CreateOrder(
                                  latitude: user.longitude ?? '',
                                  longitude: user.latitude ?? '',
                                  location: user.location ?? '',
                                  paymentMethod: 'card');
                              _orderCubit.createOrder(order);
                              break;
                            }
                          case PaymentMethod.wallet:
                            {
                              final order = CreateOrder(
                                  latitude: user.longitude ?? '',
                                  longitude: user.latitude ?? '',
                                  location: user.location ?? '',
                                  paymentMethod: 'wallet');
                              _orderCubit.createOrder(order);
                              break;
                            }
                          case PaymentMethod.bank:
                            {
                              break;
                            }
                        }
                      });
                    },
                    processing: state is OrderProcessing,
                    child: const Text('Pay now',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)));
              },
              listener: (_, state) {
                if (state is CreateOrderLoaded) {
                  if (paymentMethod != PaymentMethod.none) {
                    if (paymentMethod == PaymentMethod.card) {
                      AppNavigator.pushAndStackNamed(context,
                              name: AppRoutes.webViewScreen,
                              arguments: state.info.paymentUrl)
                          .then((successful) {
                        if (successful != null) {
                          if (successful) {
                            Navigator.popUntil(
                                context,
                                (route) =>
                                    route.settings.name == AppRoutes.dashboard);
                          } else {
                            Modals.showToast('Transaction failed',
                                messageType: MessageType.error);
                          }
                        }
                      });
                    } else if (paymentMethod == PaymentMethod.wallet) {
                      _productsCubit.getCartProduct();
                    }
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 25),
          BlocConsumer<BookingsCubit, BookingsStates>(
              listener: (context, state) {
            if (state is BookingsProcessing) {
              isLoading = true;
              resetState();
            } else if (state is BookingsNetworkErr) {
              isLoading = false;

              Modals.showToast(state.message ?? '',
                  messageType: MessageType.error);
            } else if (state is BookingsApiErr) {
              isLoading = false;

              Modals.showToast(state.message ?? '',
                  messageType: MessageType.error);
            } else if (state is BookingsLoaded) {
              isLoading = false;

              Modals.showToast('Request Created Successfully',
                  messageType: MessageType.success);
              Navigator.pop(context);
            }
          }, builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ButtonView(
                  disabled: cartItems.isEmpty ? true : false,
                  onPressed: () => Modals.showBottomSheetModal(context,
                          borderRadius: 25, page: StatefulBuilder(
                              builder: (context, StateSetter setStates) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 34),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Request Payment',
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    size: 24,
                                    weight: FontWeight.w700,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const ImageView.svg(
                                      AppImages.dropDown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextEditView(
                                      controller: phoneNumberController,
                                      hintText: 'Phone number',
                                      borderRadius: 8,
                                      borderColor: Colors.transparent,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CustomText(
                                      maxLines: 2,
                                      text:
                                          'Enter the phone number of the person you are requesting payment from.',
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      size: 12,
                                      weight: FontWeight.w400,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextEditView(
                                      controller: commentController,
                                      maxLines: 5,
                                      filled: true,
                                      hintText: 'Add comment',
                                      borderRadius: 8,
                                      borderColor: Colors.transparent,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CustomText(
                                      text: 'Add comment to your request',
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      size: 12,
                                      weight: FontWeight.w400,
                                    ),
                                    const SizedBox(
                                      height: 23,
                                    ),
                                    ButtonView(
                                        processing: isLoading,
                                        onPressed: () {
                                          if (commentController
                                                  .text.isNotEmpty &&
                                              phoneNumberController
                                                  .text.isNotEmpty) {
                                            setStates(() {});

                                            _bookingsCubit.createBookings(
                                                comment: commentController.text,
                                                latitude: double.parse(
                                                    user.latitude ?? '0.0'),
                                                longitude: double.parse(
                                                    user.longitude ?? '0.0'),
                                                location: user.location ?? '',
                                                phone:
                                                    phoneNumberController.text);
                                          } else {
                                            Modals.showToast('fields required',
                                                messageType:
                                                    MessageType.success);
                                          }
                                        },
                                        child: const Text('Send Request',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18))),
                                  ]),
                            ),
                          ],
                        );
                      }), isScrollControlled: true, heightFactor: 0.9),
                  borderWidth: 1,
                  color: Colors.transparent,
                  child: Text('Ask a friend',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18))),
            );
          }),
          const SizedBox(height: 27),
        ],
      ),
    );
  }

  resetState() {
    setState(() {});
  }
}
