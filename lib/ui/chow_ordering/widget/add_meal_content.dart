import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/products/products.dart';
import '../../../model/data_models/cart_info.dart';
import '../../../model/view_models/products_view_model.dart';
import '../../../requests/repositories/products_repository/product_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../res/enum.dart';
import '../../../utils/app_utils.dart';
import '../../modals.dart';
import '../../widgets/quantity_view.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';

class AddMealContent extends StatefulWidget {
  final Function()? addOnPressed;
  final String? imageUrl;
  final String businessName;
  final String? prepTime;
  final double price;
  final String productId;
  const AddMealContent(
      {Key? key,
      this.addOnPressed,
      required this.imageUrl,
      required this.businessName,
      required this.prepTime,
      required this.price,
      required this.productId})
      : super(key: key);

  @override
  State<AddMealContent> createState() => _AddMealContentState();
}

class _AddMealContentState extends State<AddMealContent> {
  @override
  Widget build(BuildContext context) {
    List<CartInfo> cartInfo = [];
    int quantity = 1;
    double priceTag = widget.price;

    return BlocProvider<ProductsCubit>(
        create: (BuildContext context) => ProductsCubit(
            productsRepository: ProductRepositoryImpl(),
            viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
        child: BlocConsumer<ProductsCubit, ProductsStates>(
            listener: (context, state) {
          if (state is CartNetworkErr) {
            Modals.showToast(state.message!, messageType: MessageType.error);
          } else if (state is CartApiErr) {
            Modals.showToast(state.message!, messageType: MessageType.error);
          } else if (state is CartLoaded) {
            Modals.showToast('Product added successfully',
                messageType: MessageType.success);
            Navigator.pop(context, true);
          }
        }, builder: (context, state) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return ListView(shrinkWrap: true, children: [
              const SizedBox(
                height: 85,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.businessName,
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.caption!.color,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Row(
                      children: [
                        const ImageView.svg(
                          AppImages.icClockTickOutline,
                          width: 20,
                        ),
                        const SizedBox(width: 5),
                        CustomText(
                          weight: FontWeight.w400,
                          size: 14,
                          maxLines: 2,
                          text: widget.prepTime,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 47),
              Center(
                child: Text('NGN' + AppUtils.convertPrice(priceTag.toString()),
                    style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).textTheme.caption!.color,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 35),
              Align(
                  alignment: Alignment.center,
                  child: QuantityView(
                      defaultCount: 1,
                      minCount: 1,
                      onChange: (count, state) {
                        quantity = count;

                        if (state == 'increment') {
                          setState(() {
                            priceTag = priceTag + widget.price;
                          });
                        } else {
                          setState(() {
                            priceTag = priceTag - widget.price;
                          });
                        }
                      })),
              const SizedBox(height: 78),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31.0),
                  child: ButtonView(
                    processing: state is ProductsLoading,
                    onPressed: () {
                      cartInfo.add(CartInfo(
                        productId: widget.productId,
                        quantity: quantity,
                      ));

                      context.read<ProductsCubit>().addToCart(cartInfo);
                    },
                    child: Center(
                      child: CustomText(
                        text: 'Add to Cart',
                        color: Theme.of(context).primaryColor,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
            ]);
          });
        }));
  }
}
