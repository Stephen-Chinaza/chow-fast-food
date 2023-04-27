import 'package:chow/model/data_models/notifications/get_notifications.dart';
import 'package:chow/model/data_models/notifications/get_settings.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class NotificationsViewModel extends BaseViewModel {
  List<GetNotifications> _getNotifications = [];
  GetSettings? _getSettings;

  Future<void> setNotifications(List<GetNotifications> getNotifications) async {
    _getNotifications = getNotifications;

    setViewState(ViewState.success);
  }

  Future<void> setSettings(GetSettings getSettings) async {
    _getSettings = getSettings;

    setViewState(ViewState.success);
  }

  GetSettings? get settings => _getSettings;
  bool get promoteSpecialOffer => _getSettings?.specialOffers ?? true;
  bool get orderStatus => _getSettings?.orderStatus ?? true;
  bool get announcements => _getSettings?.announcement ?? false;
  bool get promosAndDeals => _getSettings?.promosAndDeals ?? true;

  List<GetNotifications> get readNotifications =>
      _getNotifications.where((n) => (n.read == true)).toList();

  List<GetNotifications> get unReadNotifications =>
      _getNotifications.where((n) => (n.read == false)).toList();
}
