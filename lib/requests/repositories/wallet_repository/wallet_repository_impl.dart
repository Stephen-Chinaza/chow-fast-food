import '../../../model/data_models/payment_info.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository{
  @override
  Future<PaymentInfo> fundWallet(double amount) async{
    final map= await Requests().post(AppStrings.fundWalletUrl,
        body: {"amount" : amount});
    return PaymentInfo.fromMap(map);
  }

  @override
  Future<double> getWalletBalance() async{
    final rtn = await Requests().get(AppStrings.getWalletBalanceUrl);
    return rtn['amount'] is int ? rtn['amount'].toDouble() : rtn['amount'];
  }
}