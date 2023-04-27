import 'package:chow/res/enum.dart';
import 'package:chow/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../modals.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/text_edit_view.dart';

class CardDetailsScreen extends StatefulWidget {
  final bool? isTopUpPage;
  final String amount;
  const CardDetailsScreen(
      {Key? key, required this.amount, this.isTopUpPage = false})
      : super(key: key);

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  int _isSelectedIndex = 0;

  changeCard({required int index}) {
    setState(() {
      _isSelectedIndex = index;
    });
  }

  bool saveCardState = true;

  _saveCardState() {
    setState(() {
      if (saveCardState) {
        saveCardState = false;
      } else {
        saveCardState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // CustomText(
        //   text: 'Select Card',
        //   size: 24,
        //   weight: FontWeight.w600,
        //   color: Theme.of(context).textTheme.bodyText1!.color,
        // ),
        // Container(
        //     margin: const EdgeInsets.only(top: 18),
        //     padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 22),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     child: Material(
        //       elevation: 5,
        //       borderRadius: BorderRadius.circular(12),
        //       child: ListView(
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         children: [
        //           ListView.builder(
        //               itemCount: 2,
        //               shrinkWrap: true,
        //               physics: const NeverScrollableScrollPhysics(),
        //               itemBuilder: ((context, index) {
        //                 return InkWell(
        //                   onTap: (() {
        //                     changeCard(index: index);
        //                   }),
        //                   child: Container(
        //                     margin: const EdgeInsets.only(bottom: 21),
        //                     child: Row(
        //                       children: [
        //                         _isSelectedIndex == index
        //                             ? const ImageView.svg(
        //                                 AppImages.icVisaCard,
        //                               )
        //                             : ImageView.svg(AppImages.icVisaCard,
        //                                 color: Theme.of(context)
        //                                     .textTheme
        //                                     .caption!
        //                                     .color),
        //                         const SizedBox(width: 25),
        //                         Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             CustomText(
        //                               text: 'Visa ***1234',
        //                               size: 17.5,
        //                               weight: FontWeight.w600,
        //                               color: _isSelectedIndex == index
        //                                   ? Theme.of(context)
        //                                       .colorScheme
        //                                       .secondary
        //                                   : Theme.of(context)
        //                                       .textTheme
        //                                       .caption!
        //                                       .color,
        //                             ),
        //                             const SizedBox(height: 8),
        //                             CustomText(
        //                               text: 'Benard Okechukwu',
        //                               size: 17.5,
        //                               weight: FontWeight.w600,
        //                               color: _isSelectedIndex == index
        //                                   ? Theme.of(context)
        //                                       .textTheme
        //                                       .bodyText1!
        //                                       .color
        //                                   : Theme.of(context)
        //                                       .textTheme
        //                                       .caption!
        //                                       .color,
        //                             ),
        //                             const SizedBox(height: 3),
        //                             CustomText(
        //                               text: 'Expires 01/2024',
        //                               size: 17.5,
        //                               weight: FontWeight.w600,
        //                               color: _isSelectedIndex == index
        //                                   ? Theme.of(context)
        //                                       .textTheme
        //                                       .bodyText1!
        //                                       .color
        //                                   : Theme.of(context)
        //                                       .textTheme
        //                                       .caption!
        //                                       .color,
        //                             ),
        //                           ],
        //                         ),
        //                         const Spacer(),
        //                         _isSelectedIndex == index
        //                             ? const ImageView.svg(AppImages.icRadioOn)
        //                             : const ImageView.svg(AppImages.icRadioOff),
        //                       ],
        //                     ),
        //                   ),
        //                 );
        //               })),
        //           const SizedBox(height: 21),
        //           ButtonView(
        //               onPressed: () => Modals.showBottomSheetModal(context,
        //                   borderRadius: 25,
        //                   page: addCardOverlay(),
        //                   isScrollControlled: true,
        //                   heightFactor: 0.9),
        //               borderWidth: 1,
        //               color: Colors.transparent,
        //               child: Text('Use a new Card',
        //                   style: TextStyle(
        //                       fontWeight: FontWeight.w600,
        //                       color: Theme.of(context).colorScheme.secondary,
        //                       fontSize: 18)))
        //         ],
        //       ),
        //     )),
        const SizedBox(height: 50),
        if (!widget.isTopUpPage!) ...[
          Align(
            alignment: Alignment.centerRight,
            child: Text.rich(TextSpan(children: [
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0, 0),
                  child: Text('Pay: NGN ',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.caption!.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 12)),
                ),
              ),
              TextSpan(
                  text: AppUtils.convertPrice(widget.amount),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.caption!.color,
                      fontSize: 14))
            ])),
          )
        ],
        const SizedBox(height: 10),
        if (widget.isTopUpPage!) ...[
          Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).primaryColor,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: Column(children: [
                CustomText(
                  text: 'Top up wallet with',
                  color: Theme.of(context).textTheme.caption!.color,
                  size: 18,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 15),
                Text.rich(TextSpan(children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0, 0),
                      child: Text('NGN ',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                  ),
                  TextSpan(
                      text: AppUtils.convertPrice(widget.amount),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontSize: 24))
                ])),
                const SizedBox(height: 38),
                ButtonView(
                    onPressed: () => Navigator.pop(context, PaymentMethod.card),
                    child: const Text('Top up',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18))),
              ]),
            ),
          )
        ] else ...[
          ButtonView(
              onPressed: () => Navigator.pop(context, PaymentMethod.card),
              child: const Text('Pay',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)))
        ],
      ]),
    ));
  }

  addCardOverlay() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Add New Card',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  textAlign: TextAlign.center,
                  size: 24,
                  weight: FontWeight.w700,
                ),
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const ImageView.svg(AppImages.dropDown))
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Expanded(
                flex: 8,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextEditView(
                      controller: TextEditingController(text: ''),
                      hintText: 'Card Number',
                      borderRadius: 8,
                      borderColor: Colors.transparent,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextEditView(
                            controller: TextEditingController(text: ''),
                            hintText: 'Expiry date',
                            borderRadius: 8,
                            borderColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextEditView(
                            controller: TextEditingController(text: ''),
                            hintText: 'CVV',
                            borderRadius: 8,
                            borderColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextEditView(
                      controller: TextEditingController(text: ''),
                      hintText: 'Card Holder’s full name',
                      borderRadius: 8,
                      borderColor: Colors.transparent,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        setState((() {
                          _saveCardState();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(children: [
                          (saveCardState)
                              ? const ImageView.svg(AppImages.icCheck)
                              : const ImageView.svg(AppImages.icUncheck),
                          const SizedBox(width: 6),
                          CustomText(
                            size: 16,
                            text: 'Save Card',
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            weight: FontWeight.w400,
                          ),
                        ]),
                      ),
                    ),
                  ],
                )),
            const Spacer(),
            ButtonView(
                onPressed: () {},
                child: const Text('Add Card',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18))),
          ],
        ),
      );
    });
  }

  // makePayment(BuildContext ctx) {
  //   ctx.read<OrderCubit>().createOrder(
  //       latitude: '',
  //       location: '',
  //       longitude: '',
  //       paymentMethod: '',
  //       productId: '',
  //       quantity: '');
  // }
}
