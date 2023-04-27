import 'package:chow/model/data_models/notifications/get_notifications.dart';
import 'package:chow/model/data_models/notifications/get_settings.dart';

import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  @override
  Future<List<GetNotifications>> getNotifications() async {
    final map = await Requests().get(
      AppStrings.getNotificationsUrl,
    );

    return List<GetNotifications>.from(
        map.map((x) => GetNotifications.fromMap(x)));
  }

  @override
  Future<GetSettings> getSettings({
    bool? specialoffer,
    bool? orderStatus,
    bool? announcement,
    bool? promoDeals,
    bool update = false,
  }) async {
    final body = {
      "special_offers": specialoffer,
      "order_status": orderStatus,
      "announcement": announcement,
      "promos_and_deals": promoDeals
    };
    final map;
    if (update) {
      map = await Requests().put(AppStrings.updateSettingsUrl, body: body);
    } else {
      map = await Requests().get(
        AppStrings.getSettingssUrl,
      );
    }

    return GetSettings.fromMap(map);
  }
}
