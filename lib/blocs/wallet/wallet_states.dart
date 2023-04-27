import 'package:chow/model/data_models/payment_info.dart';
import 'package:equatable/equatable.dart';

abstract class WalletStates extends Equatable {
  const WalletStates();
}

class InitialState extends WalletStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class WalletLoading extends WalletStates {
  @override
  List<Object> get props => [];
}

class WalletProcessing extends WalletStates {
  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletStates {
  final double balance;
  const WalletLoaded(this.balance);
  @override
  List<Object> get props => [balance];
}

class PaymentDetailsLoaded extends WalletStates {
  final PaymentInfo info;
  const PaymentDetailsLoaded(this.info);
  @override
  List<Object> get props => [info];
}

class WalletNetworkErr extends WalletStates {
  final String? message;
  const WalletNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class WalletApiErr extends WalletStates {
  final String? message;
  const WalletApiErr(this.message);
  @override
  List<Object> get props => [message!];
}
