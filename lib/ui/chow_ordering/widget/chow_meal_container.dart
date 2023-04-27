import 'package:flutter/material.dart';
import '../../../model/data_models/cart_info.dart';
import '../../../model/data_models/product/product.dart';
import '../../../res/app_images.dart';
import '../../modals.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_toggle.dart';
import '../../widgets/image_view.dart';
import '../../widgets/meal_detail.dart';
import '../../widgets/quantity_view.dart';
import 'select_combo_overlay.dart';

class ChowMealContainer extends StatefulWidget {
  final List<Product> product;
  final String? vendorId;

  const ChowMealContainer(
      {Key? key, required this.product, required this.vendorId})
      : super(key: key);

  @override
  State<ChowMealContainer> createState() => _ChowMealContainerState();
}

class _ChowMealContainerState extends State<ChowMealContainer> {
  late int selectedPercentageIndex;
  late int selectedProteinIndex;

  bool mixState = false;

  List<Product> vendorMeal = [];

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
    selectedPercentageIndex = -1;
    selectedProteinIndex = -1;

    vendorMeal =
        widget.product.where((p) => p.vendor?.id == widget.vendorId).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return (vendorMeal.isEmpty)
          ? SizedBox(
              height: 120,
              child: Center(
                  child: Text('No Meal for this vendor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ))),
            )
          : ListView.builder(
              itemCount: vendorMeal.length,
              itemBuilder: ((context, index) {
                return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ImageView.network(vendorMeal[index].image,
                                height: 75, width: 75, fit: BoxFit.fill),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: vendorMeal[index].name,
                                      color: Colors.black,
                                      size: 16,
                                      weight: FontWeight.w700,
                                    ),
                                    const SizedBox(height: 12),
                                    CustomText(
                                      text: vendorMeal[index].category,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color,
                                      size: 14,
                                      weight: FontWeight.w400,
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      image = vendorMeal[index].image;
                                      name = vendorMeal[index].name;
                                      category = vendorMeal[index].category;

                                      if (vendorMeal[index].category ==
                                          'swallow') {
                                        Modals.showBottomSheetModal(context,
                                            borderRadius: 25,
                                            page: MealDetail(
                                                imageUrl:
                                                    vendorMeal[index].image,
                                                child: addMeal(
                                                  context,
                                                  () {},
                                                  vendorMeal[index].name,
                                                  vendorMeal[index].price,
                                                  vendorMeal[index].id,
                                                )),
                                            isScrollControlled: true,
                                            heightFactor: 0.9);
                                      } else {
                                        Modals.showBottomSheetModal(
                                          context,
                                          borderRadius: 25,
                                          page: MealDetail(
                                            child: createCombo(
                                              vendorMeal[index].price,
                                              vendorMeal[index].id,
                                            ),
                                            imageUrl: vendorMeal[index].image,
                                          ),
                                          isScrollControlled: true,
                                          heightFactor: 0.9,
                                        );
                                      }
                                    },
                                    child: const ImageView.svg(AppImages.icAdd))
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
              }));
    });
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
                    // quantity: null,
                  )
                ]);
                Navigator.pop(context, [
                  Food(
                    category: category,
                    image: image,
                    name: name,
                    percentage: quantity,
                    protein: '',
                    price: price,
                    productId: '',
                    quantity: '',
                  ),
                  CartInfo(
                    percentageComposition: quantity,
                    // proteinOption: '',
                    productId: productId,
                    // quantity: null,
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
}
