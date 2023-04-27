import 'package:chow/requests/repositories/notifications_repository/notifications_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/account/account.dart';
import '../../../blocs/notifications/notifications.dart';
import '../../../model/view_models/notifications_view_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../../requests/repositories/notifications_repository/notifications_repository.dart';
import '../../../res/app_images.dart';
import '../../../res/app_routes.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/badger_icon.dart';
import '../../widgets/image_view.dart';
import '../../widgets/loading_page.dart';
import 'widget/notifications_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationsCubit>(
        create: (_) => NotificationsCubit(
            notificationsRepository: NotificationsRepositoryImpl(),
            viewModel:
                Provider.of<NotificationsViewModel>(context, listen: false)),
        child: const Notification());
  }
}

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification>
    with WidgetsBindingObserver {
  late NotificationsCubit _notificationsCubit;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _asyncInitMethod();

    super.initState();
  }

  void _asyncInitMethod() async {
    _notificationsCubit = context.read<NotificationsCubit>();
    _notificationsCubit.getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
        centerTitle: true,
        actions: [
          BadgerIcon(
              onPressed: () => AppNavigator.pushAndStackNamed(context,
                  name: AppRoutes.notificationSettingScreen),
              icon: const ImageView.svg(AppImages.icSettingOutlineDark)),
          const SizedBox(width: 10)
        ],
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final readNotificationsList =
                _notificationsCubit.viewModel.readNotifications;
            final unReadNotificationsList =
                _notificationsCubit.viewModel.unReadNotifications;

            return state is NotificationsLoading
                ? const LoadingPage(
                    length: 16,
                  )
                : ListView(
                    padding: const EdgeInsets.all(15.0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      NotificationsWidget(
                          caption: 'New',
                          notifications: unReadNotificationsList),
                      const SizedBox(height: 35),
                      NotificationsWidget(
                        caption: 'Earlier',
                        notifications: readNotificationsList,
                      )
                    ],
                  );
          }),
    );
  }
}
