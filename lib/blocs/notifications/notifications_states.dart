import 'package:chow/model/data_models/notifications/get_notifications.dart';
import 'package:chow/model/data_models/notifications/get_settings.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationsStates extends Equatable {
  const NotificationsStates();
}

class InitialState extends NotificationsStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class NotificationsLoading extends NotificationsStates {
  @override
  List<Object> get props => [];
}

class ProductsLoadingMore extends NotificationsStates {
  @override
  List<Object> get props => [];
}

class NotificationsLoaded extends NotificationsStates {
  final List<GetNotifications> notificationsData;
  const NotificationsLoaded(this.notificationsData);
  @override
  List<Object> get props => [notificationsData];
}

class NotificationsNetworkErr extends NotificationsStates {
  final String? message;
  const NotificationsNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class NotificationsApiErr extends NotificationsStates {
  final String? message;
  const NotificationsApiErr(this.message);
  @override
  List<Object> get props => [message!];
}

class SettingsLoaded extends NotificationsStates {
  final GetSettings notificationsData;
  const SettingsLoaded(this.notificationsData);
  @override
  List<Object> get props => [notificationsData];
}

class SettingsNetworkErr extends NotificationsStates {
  final String? message;
  const SettingsNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class SettingsApiErr extends NotificationsStates {
  final String? message;
  const SettingsApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
