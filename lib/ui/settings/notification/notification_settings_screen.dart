import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/account/account.dart';
import '../../../blocs/notifications/notifications.dart';
import '../../../model/view_models/notifications_view_model.dart';
import '../../../requests/repositories/notifications_repository/notifications_repository_impl.dart';
import '../../../res/enum.dart';
import '../../modals.dart';
import 'widget/notification_settings_option.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
        create: (_) => NotificationsCubit(
            notificationsRepository: NotificationsRepositoryImpl(),
            viewModel:
                Provider.of<NotificationsViewModel>(context, listen: false)),
        child: const NotificationSettings());
  }
}

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings>
    with WidgetsBindingObserver {
  late NotificationsCubit _notificationsCubit;

  bool _promoteSpecialOffer = true;

  bool _orderStatus = true;

  bool _announcements = false;

  bool _promosAndDeals = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _asyncInitMethod();

    super.initState();
  }

  void _asyncInitMethod() async {
    _notificationsCubit = context.read<NotificationsCubit>();

    getSettings();
  }

  getSettings({
    bool? specialoffer,
    bool? orderStatus,
    bool? announcement,
    bool? promoDeals,
    bool update = false,
  }) {
    _notificationsCubit.getAllSettings(
        announcement: announcement,
        orderStatus: orderStatus,
        promoDeals: promoDeals,
        specialoffer: specialoffer,
        update: update);

    _promoteSpecialOffer = _notificationsCubit.viewModel.promoteSpecialOffer;
    _orderStatus = _notificationsCubit.viewModel.orderStatus;
    _announcements = _notificationsCubit.viewModel.announcements;
    _promosAndDeals = _notificationsCubit.viewModel.promosAndDeals;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsStates>(
        listener: (context, state) {
      if (state is NotificationsLoading) {
      } else if (state is NotificationsNetworkErr) {
        if (state.message != null) {
          Modals.showToast(state.message!, messageType: MessageType.error);
        }
      } else if (state is NotificationsApiErr) {
        if (state.message != null) {
          Modals.showToast(state.message!, messageType: MessageType.error);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Notification Settings',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            const SizedBox(width: 10)
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          physics: const BouncingScrollPhysics(),
          children: [
            Card(
                elevation: 5,
                margin: EdgeInsets.zero,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(15.0),
                  children: [
                    NotificationSettingsOption(
                        processing: state is NotificationsLoading,
                        value: _promoteSpecialOffer,
                        caption: 'Promotions  & Special Offers',
                        onChanged: (value) {
                          setState(() {
                            _promoteSpecialOffer = value;
                            print(_promoteSpecialOffer);
                          });

                          getSettings(
                              announcement: _announcements,
                              orderStatus: _orderStatus,
                              promoDeals: _promosAndDeals,
                              specialoffer: _promoteSpecialOffer,
                              update: true);
                        }),
                    NotificationSettingsOption(
                        processing: state is NotificationsLoading,
                        value: _orderStatus,
                        caption: 'Order Status',
                        onChanged: (value) {
                          _orderStatus = value;
                          getSettings(
                              announcement: _announcements,
                              orderStatus: _orderStatus,
                              promoDeals: _promosAndDeals,
                              specialoffer: _promoteSpecialOffer,
                              update: true);
                        }),
                    NotificationSettingsOption(
                        processing: state is NotificationsLoading,
                        value: _announcements,
                        caption: 'Announcements',
                        onChanged: (value) {
                          _announcements = value;

                          getSettings(
                              announcement: _announcements,
                              orderStatus: _orderStatus,
                              promoDeals: _promosAndDeals,
                              specialoffer: _promoteSpecialOffer,
                              update: true);
                        }),
                    const SizedBox(height: 15),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                      child: Text('Email Notification',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18)),
                    ),
                    NotificationSettingsOption(
                        processing: state is NotificationsLoading,
                        value: _promosAndDeals,
                        caption: 'Send me promos and deals',
                        onChanged: (value) {
                          _promosAndDeals = value;

                          getSettings(
                              announcement: _announcements,
                              orderStatus: _orderStatus,
                              promoDeals: _promosAndDeals,
                              specialoffer: _promoteSpecialOffer,
                              update: true);
                        })
                  ],
                ))
          ],
        ),
      );
    });
  }
}
