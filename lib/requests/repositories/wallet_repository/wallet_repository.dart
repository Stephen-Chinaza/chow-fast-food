
import 'package:chow/model/data_models/plan/create_plan.dart';
import 'package:chow/model/data_models/plan/meal_plan.dart';

import '../../../model/data_models/payment_info.dart';

abstract class WalletRepository{
  Future<PaymentInfo> fundWallet(double amount);
  Future<double> getWalletBalance();
}