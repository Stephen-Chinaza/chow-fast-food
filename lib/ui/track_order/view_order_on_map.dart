import 'package:chow/model/view_models/user_view_model.dart';
import 'package:chow/ui/location/widgets/map_view.dart';
import 'package:chow/ui/track_order/widget/order_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/location/location_cubit.dart';
import '../../requests/repositories/location_repository/location_repository_impl.dart';
import '../widgets/custom_text.dart';

class ViewOrderOnMap extends StatelessWidget {
  const ViewOrderOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationCubit>(
        create: (_) => LocationCubit(
            locationRepository: LocationRepositoryImpl(),
            userViewModel: Provider.of<UserViewModel>(context, listen: false)),
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: true,
              title: CustomText(
                size: 24,
                text: 'Track Order',
                color: Theme.of(context).textTheme.bodyText1!.color,
                weight: FontWeight.w700,
              ),
              backgroundColor: Theme.of(context).primaryColor),
          body: Stack(children: [
            const MapView(),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(27),
                        topRight: Radius.circular(27))),
                child: Material(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(27),
                        topRight: Radius.circular(27)),
                    elevation: 5,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 21),
                      children: [
                        Row(
                          children: [
                            CustomText(
                              size: 18,
                              text: 'Status',
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              weight: FontWeight.w400,
                            ),
                            const Spacer(),
                            CustomText(
                              size: 14,
                              text: 'See Details',
                              color: Theme.of(context).colorScheme.secondary,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                        const SizedBox(height: 19),
                        CustomText(
                          text: 'Order received by vendor',
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          weight: FontWeight.w700,
                          size: 18,
                        ),
                        const SizedBox(height: 28),
                        const OrderContent.food(),
                        const SizedBox(
                          height: 21,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 26,
                        ),
                        const SizedBox(height: 17),
                        const OrderContent.officer(),
                        const SizedBox(height: 19),
                      ],
                    )),
              ),
            )
          ]),
        ));
  }
}
