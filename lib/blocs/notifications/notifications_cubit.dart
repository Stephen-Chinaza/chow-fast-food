import 'package:chow/model/data_models/notifications/get_notifications.dart';
import 'package:chow/model/data_models/notifications/get_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/notifications_view_model.dart';
import '../../requests/repositories/notifications_repository/notifications_repository.dart';
import '../../utils/exceptions.dart';
import 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit(
      {required this.notificationsRepository, required this.viewModel})
      : super(const InitialState());
  final NotificationsRepository notificationsRepository;
  final NotificationsViewModel viewModel;

  Future<void> getAllNotifications() async {
    try {
      emit(NotificationsLoading());
      List<GetNotifications> getNotifications;

      getNotifications = await notificationsRepository.getNotifications();

      await viewModel.setNotifications(getNotifications);

      emit(NotificationsLoaded(getNotifications));
    } on ApiException catch (e) {
      emit(NotificationsApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(NotificationsNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getAllSettings({
    bool? specialoffer,
    bool? orderStatus,
    bool? announcement,
    bool? promoDeals,
    bool update = false,
  }) async {
    try {
      emit(NotificationsLoading());
      GetSettings getSettings;

      getSettings = await notificationsRepository.getSettings(
          specialoffer: specialoffer,
          orderStatus: orderStatus,
          announcement: announcement,
          promoDeals: promoDeals,
          update: update);

      await viewModel.setSettings(getSettings);

      emit(SettingsLoaded(getSettings));
    } on ApiException catch (e) {
      emit(SettingsApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(SettingsNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
}
