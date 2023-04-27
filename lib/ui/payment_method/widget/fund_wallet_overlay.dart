import 'package:chow/blocs/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/wallet_repository/wallet_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../res/app_routes.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../../utils/validator.dart';
import '../../modals.dart';
import '../../settings/kyc_verification/widget/profile_input.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';
import '../../widgets/text_edit_view.dart';
import '../payment_success_screen.dart';
import 'transfer_success_content.dart';

class FundWalletOverlay extends StatefulWidget {
  final String title;
  final String subTitle;
  final String btnText;
  const FundWalletOverlay(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.btnText})
      : super(key: key);

  @override
  State<FundWalletOverlay> createState() => _FundWalletOverlayState();
}

class _FundWalletOverlayState extends State<FundWalletOverlay> {

  final _focus = FocusNode();

  bool _isShowTextField = false;

  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();

  _showTextField() {
    setState(() {
      _isShowTextField = !_isShowTextField;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletCubit>(
        lazy: false,
        create: (_) => WalletCubit(
            walletRepository: WalletRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)),
        child: BlocConsumer<WalletCubit, WalletStates>(
            listener: (context, state) {
              if (state is PaymentDetailsLoaded) {
                AppNavigator.pushAndStackNamed(context,
                    name: AppRoutes.webViewScreen,
                    arguments: state.info.paymentUrl)
                    .then((successful) {
                  if (successful != null) {
                    if (successful) {
                      AppNavigator.pushAndStackPage(context,
                          page: PaymentSuccessScreen(
                            child: TransferSuccess(
                              amount: _amountController.text,
                              description1: 'Your wallet has been top-up with ',
                              title: 'Success!',
                              description2: '',
                              phone: '',
                            ),
                          )).whenComplete(() => Navigator.popUntil(
                          context,
                              (route) =>
                          route.settings.name == AppRoutes.dashboard));
                    } else {
                      Modals.showToast('Transaction failed',
                          messageType: MessageType.error);
                    }
                  }
                });
              } else if (state is WalletApiErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              } else if (state is WalletNetworkErr) {
                if (state.message != null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }
            },
            builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Form(key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 34),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: widget.title,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            size: 24,
                            weight: FontWeight.w700,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const ImageView.svg(
                              AppImages.dropDown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Expanded(
                        flex: 8,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Center(
                              child: CustomText(
                                text: widget.subTitle,
                                maxLines: 2,
                                color: Theme.of(context).textTheme.caption!.color,
                                size: 18,
                                weight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: CustomText(
                                text: 'Enter amount',
                                color: Theme.of(context).textTheme.bodyText1!.color,
                                size: 18,
                                weight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Visibility(
                              visible: !_isShowTextField,
                              child: GestureDetector(
                                onTap: () => _showTextField(),
                                child: Center(
                                  child: Text.rich(TextSpan(children: [
                                    WidgetSpan(
                                      child: Text('0.00',
                                          style: TextStyle(
                                              color: Theme.of(context).colorScheme.secondary,
                                              fontWeight: FontWeight.w100,
                                              fontSize: 48)),
                                    ),
                                    TextSpan(
                                        text: ' NGN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                            Theme.of(context).textTheme.bodyText1!.color,
                                            fontSize: 24)),
                                  ])),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _isShowTextField,
                              child: BorderlessField(
                                controller: _amountController,
                                focusNode: _focus,
                                autofocus: true,
                                hintText: '',
                                validator: Validator.validate,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(height: 35.0),
                            if(widget.title == 'Transfer Voucher')...[
                              ProfileInputField(
                                  label: 'Enter recipeint’s phone number',
                                  child: TextEditView(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      textInputAction:
                                      TextInputAction.go,
                                      autofillHints: const [
                                        AutofillHints.telephoneNumber
                                      ],
                                      validator: Validator.validate,
                                      labelText: 'Enter phone number',
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                            horizontal: 5.0),
                                        child: ImageView.svg(
                                            AppImages.icPhone),
                                      )))
                            ],
                            const SizedBox(
                              height: 50,
                            ),
                            ButtonView(
                                onPressed: (){
                                  if(!_formKey.currentState!.validate()){
                                    return;
                                  }
                                  switch(widget.title){
                                    case 'Top up':{
                                      _walletTopUp(context);
                                      break;
                                    }
                                    case 'Transfer':{
                                      _transferFromWalletToUser(context);
                                      break;
                                    }
                                    case 'Transfer Voucher':{
                                      _transferFromVoucherToWallet(context);
                                      break;
                                    }
                                  }
                                },
                                borderRadius: 16.0,
                                disabled: !_isShowTextField,
                                processing: state is WalletProcessing
                                    || state is WalletLoading,
                                child: Text(widget.btnText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 18))),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            )));
  }

  void _walletTopUp(BuildContext ctx){
    final walletCubit = ctx.read<WalletCubit>();
    walletCubit.fundWallet(double.parse(_amountController.text));
/*    AppNavigator.pushAndStackNamed(context,
        name: AppRoutes.topUpScreen,
        arguments: _amountController.text).then((method){
          switch(method){
            case PaymentMethod.card :{
              walletCubit.fundWallet(double.parse(_amountController.text));
              break;
            }
            case PaymentMethod.wallet :{
              break;
            }
            case PaymentMethod.bank :{
              break;
            }
          }
    });*/
  }

  void _transferFromWalletToUser(BuildContext ctx){
    //final walletCubit = ctx.read<WalletCubit>();
  }

  void _transferFromVoucherToWallet(BuildContext ctx){
    //final walletCubit = ctx.read<WalletCubit>();
    AppNavigator.pushAndStackPage(context,
        page: const PaymentSuccessScreen(
          child: TransferSuccess(
            amount: '2700',
            description1:
            'You just transfered',
            title: 'Success!',
            description2:
            'Receipient’s phone number',
            phone: '0906654446',
          ),
        ));
  }

}
