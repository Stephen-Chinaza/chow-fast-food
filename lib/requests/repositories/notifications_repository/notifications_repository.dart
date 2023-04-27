import 'package:chow/model/data_models/notifications/get_notifications.dart';
import 'package:chow/model/data_models/notifications/get_settings.dart';

abstract class NotificationsRepository {
  Future<List<GetNotifications>> getNotifications();

  Future<GetSettings> getSettings({
    bool? specialoffer,
    bool? orderStatus,
    bool? announcement,
    bool? promoDeals,
    bool update,
  });
}
