import 'package:chow/ui/bookings/widget/bookings_meal_card.dart';
import 'package:flutter/material.dart';

import '../../model/data_models/order/order_item.dart';
import '../../model/data_models/user/user.dart';
import '../../res/enum.dart';
import 'filter_search_section.dart';

class MealContainer extends StatefulWidget {
  final List<OrderItem> dataList;
  final Map<String, User>? bookingDetails;
  final List<String>? bookingId;

  final bool showFilter;
  final BookingsType bookingsType;
  const MealContainer.bookings(
      {Key? key,
      required this.dataList,
      this.bookingsType = BookingsType.myBookings,
      this.bookingDetails,
      this.bookingId})
      : showFilter = true,
        super(key: key);

  const MealContainer.request(
      {Key? key,
      required this.dataList,
      this.bookingsType = BookingsType.bookingRequest,
      this.bookingDetails,
      this.bookingId})
      : showFilter = false,
        super(key: key);

  @override
  State<MealContainer> createState() => _MealContainerState();
}

class _MealContainerState extends State<MealContainer> {
  @override
  Widget build(BuildContext context) {
    if (widget.bookingsType == BookingsType.myBookings) {
      return widget.dataList.isEmpty
          ? SizedBox(
              height: 120,
              child: Center(
                  child: Text('No Order',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ))),
            )
          : ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FilterSearchView(showFilter: widget.showFilter),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                    itemCount: widget.dataList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return BookingsMealCard(
                        widget.dataList[index],
                      );
                    }))
              ],
            );
    } else if ((widget.bookingsType == BookingsType.bookingRequest)) {
      return widget.dataList.isEmpty
          ? SizedBox(
              height: 120,
              child: Center(
                  child: Text('No Booking request yet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ))),
            )
          : ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FilterSearchView(showFilter: widget.showFilter),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                    itemCount: widget.dataList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return BookingsMealCard(widget.dataList[index],
                          bookingDetails:
                              widget.bookingDetails?[widget.dataList[index].id],
                          bookingId: widget.bookingId?[index]);
                    }))
              ],
            );
    }

    return const SizedBox.shrink();
  }
}
