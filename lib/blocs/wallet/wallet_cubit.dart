import 'package:chow/blocs/wallet/wallet.dart';
import 'package:chow/requests/repositories/wallet_repository/wallet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/user_view_model.dart';
import '../../utils/exceptions.dart';

class WalletCubit extends Cubit<WalletStates> {
  WalletCubit({required this.walletRepository, required this.viewModel})
      : super(const InitialState());
  final WalletRepository walletRepository;
  final UserViewModel viewModel;

  Future<void> fundWallet(double amount) async {
    try {
      emit(WalletProcessing());

      final paymentDetails = await walletRepository.fundWallet(amount);

      emit(PaymentDetailsLoaded(paymentDetails));
      getWalletBalance();
    } on ApiException catch (e) {
      emit(WalletApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(WalletNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getWalletBalance() async {
    try {
      emit(WalletLoading());

      final balance = await walletRepository.getWalletBalance();

      await viewModel.setWalletBalance(balance);
      emit(WalletLoaded(balance));
    } on ApiException catch (e) {
      emit(WalletApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(WalletNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

}
