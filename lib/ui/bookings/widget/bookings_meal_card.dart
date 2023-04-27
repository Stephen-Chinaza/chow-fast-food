import 'package:chow/res/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/order/order.dart';
import '../../../model/data_models/order/order_item.dart';
import '../../../model/data_models/user/user.dart';
import '../../../model/view_models/order_view_model.dart';
import '../../../requests/repositories/order_repository/order_repository_impl.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../../res/app_routes.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../chow_ordering/widget/add_meal_content.dart';
import '../../modals.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/delivery_status_widget.dart';
import '../../widgets/image_view.dart';
import '../../widgets/order_button.dart';
import '../../widgets/meal_detail.dart';

class BookingsMealCard extends StatefulWidget {
  final OrderItem mealData;
  final User? bookingDetails;
  final String? bookingId;
  const BookingsMealCard(this.mealData,
      {Key? key, this.bookingDetails, this.bookingId})
      : super(key: key);

  @override
  State<BookingsMealCard> createState() => _BookingsMealCardState();
}

class _BookingsMealCardState extends State<BookingsMealCard>
    with WidgetsBindingObserver {
  late OrderCubit _orderCubit;

  PaymentMethod paymentMethod = PaymentMethod.none;

  @override
  void initState() {
    _orderCubit = context.read<OrderCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeliveryStatus deliveryStatus = DeliveryStatus.none;

    switch (widget.mealData.status) {
      case 'processing':
        deliveryStatus = DeliveryStatus.pending;
        break;
      case 'delivered':
        deliveryStatus = DeliveryStatus.delivered;
        break;
      case 'requested':
        deliveryStatus = DeliveryStatus.requested;
        break;
    }

    return Card(
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ImageView.network(widget.mealData.product.image,
                    height: 96, width: 96, fit: BoxFit.fill),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: widget.mealData.product.vendor?.businessName ??
                              '',
                          color: Theme.of(context).textTheme.caption!.color,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                        const Spacer(),
                        CustomText(
                          text: AppUtils.formatComplexDate(
                              dateTime:
                                  widget.mealData.createdAt.toIso8601String()),
                          size: 12,
                          color: Theme.of(context).textTheme.caption!.color,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: widget.mealData.product.name,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      size: 18,
                      weight: FontWeight.w700,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text.rich(TextSpan(children: [
                      WidgetSpan(
                        child: Transform.translate(
                          offset: const Offset(0, 0),
                          child: Text('NGN ',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11)),
                        ),
                      ),
                      TextSpan(
                          text: AppUtils.convertPrice(
                              widget.mealData.product.price),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18))
                    ])),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DeliveryStatusWidget(deliveryStatus),
                        const Spacer(),
                        if (deliveryStatus == DeliveryStatus.requested) ...[
                          GestureDetector(
                            child: OrderButton.outline(
                              width: 100,
                              height: 32,
                              onPressed: () => Modals.showBottomSheetModal(
                                  context,
                                  borderRadius: 25, page: StatefulBuilder(
                                      builder:
                                          (context, StateSetter setStates) {
                                return MealDetail(
                                    imageUrl: widget.mealData.product.image,
                                    child: ListView(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 31.0, vertical: 8.0),
                                      children: [
                                        const SizedBox(height: 70),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                  widget.mealData.product.name,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                                widget.mealData.product.vendor
                                                        ?.businessName ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .color,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const SizedBox(height: 20),
                                            Text.rich(TextSpan(children: [
                                              WidgetSpan(
                                                child: Transform.translate(
                                                  offset: const Offset(0, 0),
                                                  child: Text('NGN ',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11)),
                                                ),
                                              ),
                                              TextSpan(
                                                  text: AppUtils.convertPrice(
                                                      widget.mealData.product
                                                          .price),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color,
                                                      fontSize: 18))
                                            ])),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                detailsColumn(
                                                  context: context,
                                                  title: 'Requested by:',
                                                  detail:
                                                      '${widget.bookingDetails?.firstName} ${widget.bookingDetails?.lastName}',
                                                ),
                                                const Spacer(),
                                                detailsColumn(
                                                    context: context,
                                                    title: 'Phone Number',
                                                    detail: widget
                                                        .bookingDetails
                                                        ?.phoneNumber),
                                                const SizedBox(height: 20),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            const ImageView.svg(
                                              AppImages.icClock,
                                              width: 30,
                                            ),
                                            const SizedBox(height: 20),
                                            Center(
                                              child: Text(
                                                  widget.mealData.product
                                                          .preparationTime ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                            const SizedBox(height: 40),
                                            BlocProvider<OrderCubit>(
                                              create: (BuildContext context) =>
                                                  OrderCubit(
                                                      orderRepository:
                                                          OrderRepositoryImpl(),
                                                      viewModel: Provider.of<
                                                              OrderViewModel>(
                                                          context,
                                                          listen: false)),
                                              child: BlocConsumer<OrderCubit,
                                                  OrderStates>(
                                                listener: (_, state) {
                                                  if (state
                                                      is OrderProcessing) {
                                                  } else if (state
                                                      is SettleBookingsLoaded) {
                                                    if (paymentMethod !=
                                                        PaymentMethod.none) {
                                                      if (paymentMethod ==
                                                          PaymentMethod.card) {
                                                        AppNavigator.pushAndStackNamed(
                                                                context,
                                                                name: AppRoutes
                                                                    .webViewScreen,
                                                                arguments: state
                                                                    .bookingsData
                                                                    .paymentUrl)
                                                            .then((successful) {
                                                          if (successful !=
                                                              null) {
                                                            if (successful) {
                                                              Navigator.popUntil(
                                                                  context,
                                                                  (route) =>
                                                                      route
                                                                          .settings
                                                                          .name ==
                                                                      AppRoutes
                                                                          .dashboard);
                                                            } else {
                                                              Modals.showToast(
                                                                  'Transaction failed',
                                                                  messageType:
                                                                      MessageType
                                                                          .error);
                                                            }
                                                          }
                                                        });
                                                      } else if (paymentMethod ==
                                                          PaymentMethod
                                                              .wallet) {}
                                                    }
                                                  }
                                                },
                                                builder: (context, state) {
                                                  return ButtonView(
                                                    processing:
                                                        state is OrderLoading,
                                                    onPressed: () {
                                                      AppNavigator.pushAndStackNamed(
                                                              context,
                                                              name: AppRoutes
                                                                  .paymentMethodScreen,
                                                              arguments: widget
                                                                  .mealData
                                                                  .product
                                                                  .price)
                                                          .then((method) {
                                                        paymentMethod = method;

                                                        switch (method) {
                                                          case PaymentMethod
                                                              .card:
                                                            {
                                                              setStates(() {});

                                                              _orderCubit.settleBooking(
                                                                  paymentMethod:
                                                                      'card',
                                                                  bookingId:
                                                                      widget.bookingId ??
                                                                          '');
                                                              break;
                                                            }
                                                          case PaymentMethod
                                                              .wallet:
                                                            {
                                                              setStates(() {});

                                                              _orderCubit.settleBooking(
                                                                  paymentMethod:
                                                                      'wallet',
                                                                  bookingId:
                                                                      widget.bookingId ??
                                                                          '');

                                                              break;
                                                            }
                                                          case PaymentMethod
                                                              .bank:
                                                            {
                                                              break;
                                                            }
                                                        }
                                                      });
                                                    },
                                                    child: Center(
                                                      child: CustomText(
                                                        text: 'Pay for this',
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 18,
                                                        weight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ));
                              }), isScrollControlled: true, heightFactor: 0.9),
                              child: Center(
                                child: CustomText(
                                  text: 'Pay for this',
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 14,
                                ),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        ] else if (deliveryStatus ==
                            DeliveryStatus.pending) ...[
                          OrderButton.normal(
                            width: 100,
                            height: 32,
                            onPressed: () {},
                            child: Center(
                              child: CustomText(
                                text: 'Track Order',
                                color: Theme.of(context).primaryColor,
                                size: 14,
                              ),
                            ),
                            color: AppColors.yellow,
                          )
                        ] else ...[
                          OrderButton.outline(
                            width: 100,
                            height: 32,
                            onPressed: () {
                              Modals.showBottomSheetModal(context,
                                      borderRadius: 25,
                                      page: MealDetail(
                                          child: AddMealContent(
                                            businessName: widget
                                                    .mealData
                                                    .product
                                                    .vendor
                                                    ?.businessName ??
                                                '',
                                            imageUrl:
                                                widget.mealData.product.image,
                                            price: double.parse(
                                                widget.mealData.product.price),
                                            prepTime: widget.mealData.product
                                                    .preparationTime ??
                                                '',
                                            productId:
                                                widget.mealData.product.id,
                                          ),
                                          imageUrl:
                                              widget.mealData.product.image),
                                      isScrollControlled: true,
                                      heightFactor: 0.9)
                                  .then((value) => {
                                        if (value)
                                          {
                                            Modals.showToast(
                                                'Proceed to make payment',
                                                messageType:
                                                    MessageType.success),
                                            AppNavigator.pushAndStackNamed(
                                                context,
                                                name: AppRoutes.cartScreen,
                                                arguments: 'drinks_cart'),
                                          }
                                      });
                            },
                            child: Center(
                              child: CustomText(
                                text: 'Re-order',
                                color: Theme.of(context).colorScheme.secondary,
                                size: 14,
                              ),
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        ]
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  detailsColumn({String? title, String? detail, BuildContext? context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!,
            style: TextStyle(
                fontSize: 14,
                color: Theme.of(context!).textTheme.caption!.color,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Text(detail!,
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.caption!.color,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}
