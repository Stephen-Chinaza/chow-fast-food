// ignore_for_file: prefer_const_constructors

import 'package:chow/res/app_images.dart';
import 'package:chow/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/products/products.dart';
import '../../model/data_models/cart_info.dart';
import '../../model/view_models/products_view_model.dart';
import '../../requests/repositories/products_repository/product_repository_impl.dart';
import '../../res/app_strings.dart';
import '../../res/enum.dart';
import '../../utils/app_utils.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_toggle.dart';
import '../widgets/meal_detail.dart';
import '../widgets/quantity_view.dart';
import 'widget/chow_container.dart';
import 'widget/select_combo_overlay.dart';

class CreateComboScreen extends StatefulWidget {
  const CreateComboScreen({Key? key}) : super(key: key);

  @override
  State<CreateComboScreen> createState() => _CreateComboScreenState();
}

class _CreateComboScreenState extends State<CreateComboScreen> {
  bool mixState = false;
  var singleVendor;
  String selectedVendorName = '';
  String selectedVendorLocation = '';
  String selectedVendorId = '';
  int selectedIndex = -1;
  String changed = '';
  String editing = '';
  late int selectedPercentageIndex;
  late int selectedProteinIndex;

  List<Food> foodListItem = [];

  List<CartInfo> cartItem = [];

  var singleFoodItem;

  var map;

  String name = '';
  String image = '';
  int percentage = 100;
  String protein = '';
  String category = '';
  int quantity = 1;

  _mixPercentage() {
    setState(() {
      if (mixState) {
        mixState = false;
        selectedPercentageIndex = -1;
      } else {
        mixState = true;
        selectedPercentageIndex = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    selectedPercentageIndex = -1;
    selectedProteinIndex = -1;

    WidgetsBinding.instance.addPostFrameCallback((_) => oPenVendorOverlay());
  }

  Future oPenVendorOverlay() async {
    singleVendor = await Modals.showBottomSheetModal(context,
        borderRadius: 25,
        page: const SelectCombo(overlayType: CreateComboOverlayType.vendors),
        isScrollControlled: true,
        heightFactor: 0.9);

    if (singleVendor != null) {
      selectedVendorLocation = singleVendor.location ?? '';
      selectedVendorName = singleVendor.businessName ?? '';
      selectedVendorId = singleVendor.id ?? '';
    } else {
      selectedVendorLocation = '';
      selectedVendorId = '';

      selectedVendorName = 'Please Select a Vendor';
    }
    setState(() {});
  }

  Future oPenVendorChowOverlay() async {
    map = await Modals.showBottomSheetModal(context,
        borderRadius: 25,
        page: SelectCombo(
            vendorId: selectedVendorId,
            overlayType: CreateComboOverlayType.chow),
        isScrollControlled: true,
        heightFactor: 0.9);

    if (map == null) {
      selectedIndex = -1;
      changed = '';
      editing = '';
    }

    if (map[0] != null) {
      if (selectedIndex != -1 && changed != '') {
        foodListItem[selectedIndex] = map[0];
        selectedIndex = -1;
        changed = '';
      } else {
        foodListItem.add(map[0]);
      }
      setState(() {});
    } else {}

    if (map[1] != null) {
      if (selectedIndex != -1 && changed != '') {
        cartItem[selectedIndex] = map[1];
        selectedIndex = -1;
        changed = '';
      } else {
        cartItem.add(map[1]);
        setState(() {});
      }
    }
  }

  double subTotal = 0.0;
  @override
  Widget build(BuildContext context) {
    updateSubTotal();
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
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: true,
              title: CustomText(
                size: 24,
                text: 'Create Combo',
                color: Theme.of(context).textTheme.bodyText1!.color,
                weight: FontWeight.w600,
              ),
            ),
            body: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 32),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: CustomText(
                    size: 24,
                    text: 'Food Vendor',
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  color: Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            size: 18,
                            text: selectedVendorName,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            weight: FontWeight.w600,
                          ),
                          const Spacer(),
                          ButtonView(
                              onPressed: () => oPenVendorOverlay(),
                              expanded: false,
                              color: Colors.transparent,
                              borderWidth: 1,
                              borderColor:
                                  Theme.of(context).colorScheme.secondary,
                              borderRadius: 6.0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 15.0),
                              child: Text(
                                  (singleVendor == null) ? 'Select' : 'Change',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)))
                        ],
                      ),
                      const SizedBox(height: 27),
                      Row(
                        children: [
                          const ImageView.svg(AppImages.icHouse),
                          const SizedBox(width: 12),
                          Flexible(
                            child: CustomText(
                              size: 13,
                              text: selectedVendorLocation,
                              color: Theme.of(context).textTheme.caption!.color,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 21),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: CustomText(
                    size: 24,
                    text: 'My Chow',
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 27),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: foodListItem.length,
                  itemBuilder: ((context, index) {
                    return ChowContainer(
                      vendorId: selectedVendorId,
                      dataLength: foodListItem.length,
                      index: index,
                      foodItem: foodListItem[index],
                      onRemove: (value) {
                        selectedIndex = value;
                        if (selectedIndex != -1) {
                          setState(() {
                            foodListItem.removeAt(selectedIndex);
                          });
                          selectedIndex = -1;
                        }
                      },
                      onChange: (value, change) {
                        selectedIndex = value;
                        if (selectedIndex != -1) {
                          setState(() {
                            changed = change;
                            oPenVendorChowOverlay();
                          });
                        }
                      },
                      onEdit: (value, edit) {
                        // selectedIndex = value;
                        // if (selectedIndex != -1) {
                        //   setState(() {
                        //     editing = edit;

                        //     editProduct(
                        //       cat: foodListItem[index].category,
                        //       id: foodListItem[index].productId,
                        //       img: foodListItem[index].image,
                        //       nam: foodListItem[index].name,
                        //       price: foodListItem[index].image,
                        //     );
                        //   });
                        // }
                      },
                    );
                  }),
                ),
                const SizedBox(height: 27),
                InkWell(
                  onTap: () {
                    if (singleVendor != null) {
                      oPenVendorChowOverlay();
                    } else {
                      Modals.showToast('Please select a vendor',
                          messageType: MessageType.error);
                    }
                  },
                  child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: SizedBox(
                        height: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle,
                                color: Theme.of(context).colorScheme.secondary),
                            const SizedBox(width: 15),
                            Text('Add Item',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))
                          ],
                        ),
                      )),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Sub-total',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color:
                                  Theme.of(context).textTheme.caption!.color)),
                      const SizedBox(
                        width: 16,
                      ),
                      Text.rich(TextSpan(children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: const Offset(0, 0),
                            child: Text('NGN',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                          ),
                        ),
                        TextSpan(
                            text: AppUtils.convertPrice('$subTotal'),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 32.09))
                      ])),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (foodListItem.isEmpty) ...[
                    ButtonView(
                        onPressed: () {
                          if (singleVendor != null) {
                            oPenVendorChowOverlay();
                          } else {
                            Modals.showToast('Please select a vendor',
                                messageType: MessageType.error);
                          }
                        },
                        child: const Text('Create Combo',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18))),
                  ] else ...[
                    ButtonView(
                        processing: state is ProductsLoading,
                        onPressed: () {
                          Modals.showAlertOptionDialog(context,
                                  title: 'Add to Cart',
                                  message: AppStrings.proceedMessage)
                              .then((result) {
                            if (result != null && result) {
                              context.read<ProductsCubit>().addToCart(cartItem);
                            }
                          });
                        },
                        child: const Text('Add to Cart',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18))),
                  ],
                ],
              ),
            ),
          );
        }));
  }

  editProduct(
      {required String cat,
      required String img,
      required String nam,
      required String id,
      required String price}) async {
    image = img;
    name = nam;
    category = cat;

    if (category.toString() == 'swallow') {
      map = await Modals.showBottomSheetModal(context,
          borderRadius: 25,
          page: MealDetail(
              imageUrl: image,
              child: addMeal(
                context,
                () {},
                name,
                price,
                id,
              )),
          isScrollControlled: true,
          heightFactor: 0.9);

      if (selectedIndex != -1 && editing != '') {
        setState(() {
          foodListItem[selectedIndex] = map[0];
          selectedIndex = -1;
          editing = '';
        });
      }
    } else {
      map = await Modals.showBottomSheetModal(
        context,
        borderRadius: 25,
        page: MealDetail(
          child: createCombo(
            price,
            id,
          ),
          imageUrl: image,
        ),
        isScrollControlled: true,
        heightFactor: 0.9,
      );

      if (selectedIndex != -1 && editing != '') {
        setState(() {
          foodListItem[selectedIndex] = map[0];
          selectedIndex = -1;
          editing = '';
        });
      }

      if (map[1] != null) {
        if (selectedIndex != -1 && editing != '') {
          cartItem[selectedIndex] = map[1];
          selectedIndex = -1;
          editing = '';
        }
      }
    }
  }

  createCombo(price, productId) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 70),
          Align(
            alignment: Alignment.center,
            child: Text(name,
                style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CustomText(
              size: 14,
              text: 'Choose protein options',
              color: Theme.of(context).textTheme.bodyText1!.color,
              weight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 70,
            child: CustomToggle(
              scrollable: false,
              initialIndex: selectedProteinIndex,
              selectedIndex: selectedProteinIndex,
              backgroundColor: Colors.transparent,
              height: 32,
              title: const ['Beef', 'Goat Meat', 'Fish'],
              contentMargin: const EdgeInsets.all(8.0),
              onSelected: (int i) {
                setState((() {
                  selectedProteinIndex = i;
                  switch (i) {
                    case 0:
                      protein = 'Beef';
                      break;
                    case 1:
                      protein = 'Goat Meat';
                      break;
                    case 2:
                      protein = 'Fish';
                      break;
                  }
                }));
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _mixPercentage();
                if (mixState) {
                  percentage = 20;
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(children: [
                (mixState)
                    ? const ImageView.svg(AppImages.icCheck)
                    : const ImageView.svg(AppImages.icUncheck),
                const SizedBox(width: 6),
                CustomText(
                  size: 18,
                  text: 'Mix by percentage',
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  weight: FontWeight.w500,
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 41.67,
          ),
          SizedBox(
            height: 70,
            child: CustomToggle(
              scrollable: false,
              initialIndex: selectedPercentageIndex,
              selectedIndex: selectedPercentageIndex,
              backgroundColor: Colors.transparent,
              height: 32,
              title: const ['20%', '50%', '80%'],
              contentMargin: const EdgeInsets.all(8.0),
              onSelected: (int i) {
                setState((() {
                  selectedPercentageIndex = i;

                  switch (i) {
                    case 0:
                      percentage = 20;
                      break;
                    case 1:
                      percentage = 50;
                      break;
                    case 2:
                      percentage = 80;
                      break;
                  }
                }));
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ButtonView(
                onPressed: () {
                  Navigator.pop(context, [
                    Food(
                      category: category,
                      image: image,
                      name: name,
                      percentage: percentage,
                      protein: protein,
                      price: price,
                      productId: productId,
                      quantity: quantity.toString(),
                    ),
                    CartInfo(
                      percentageComposition: percentage,
                      proteinOption: protein,
                      productId: productId,
                      quantity: null,
                    )
                  ]);
                },
                child: const Text('Add to Combo',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18))),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
    });
  }

  Widget addMeal(
      BuildContext context, Function()? addOnPressed, title, price, productId) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return ListView(shrinkWrap: true, children: [
        const SizedBox(height: 75),
        Center(
          child: Text(title,
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.caption!.color,
                  fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 75),
        Align(
            alignment: Alignment.center,
            child: QuantityView(
                defaultCount: 1,
                minCount: 1,
                onChange: (count, state) {
                  setState(() {
                    quantity = count;
                  });
                })),
        const SizedBox(height: 75),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 31.0),
            child: ButtonView(
              onPressed: () {
                Navigator.pop(context, [
                  Food(
                    category: category,
                    image: image,
                    name: name,
                    percentage: quantity,
                    protein: '',
                    price: price,
                    productId: productId,
                    quantity: quantity.toString(),
                  ),
                  CartInfo(
                    percentageComposition: quantity,
                    proteinOption: '',
                    productId: productId,
                    quantity: null,
                  )
                ]);
              },
              child: Center(
                child: CustomText(
                  text: 'Add to Combo',
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
  }

  void updateSubTotal() {
    subTotal = 0.0;
    foodListItem.forEach((element) {
      subTotal += double.parse(element.price);
    });
  }
}
