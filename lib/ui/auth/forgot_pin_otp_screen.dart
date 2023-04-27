
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/account/account.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../res/enum.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/image_view.dart';
import '../widgets/pin_code_view.dart';

class ForgotPinOtpScreen extends StatefulWidget {
  const ForgotPinOtpScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPinOtpScreen> createState() => _ForgotPinOtpScreenState();
}

class _ForgotPinOtpScreenState extends State<ForgotPinOtpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size=AppUtils.deviceScreenSize(context);
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final verifier = args['verifier'];
    //final phone = args['phone'];

    return BlocProvider<AccountCubit>(
        lazy: false,
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)
        ),
        child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
              if(state is PinResetOTPSent){
                Modals.showToast(state.message,
                    messageType: MessageType.success);
              }else if(state is PinResetOTPVerified){
                AppNavigator.pushAndStackNamed(context,
                    name: AppRoutes.resetPinScreen,
                    arguments: _pinController.text);
              }else if(state is AccountApiErr){
                if(state.message!=null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }else if(state is AccountNetworkErr){
                if(state.message!=null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }
            },
            builder: (context, state){
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Enter Code',
                        style: TextStyle(fontSize: 24,
                            fontWeight: FontWeight.w600)),
                    backgroundColor: Theme.of(context).backgroundColor,
                  ),
                  body: SafeArea(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            SizedBox(height: size.height*0.05),
                            const ImageView.asset(
                                AppImages.enterCode,
                                scale: 2),
                            SizedBox(height: size.height*0.05),
                            Text.rich(TextSpan(
                                text: 'Please enter the 4 digit code sent to\n',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 2
                                ),
                                children: [
                                  TextSpan(
                                      text: verifier,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                      ))
                                ]
                            ),textAlign: TextAlign.center),
                            SizedBox(height: size.height*0.05),
                            Form(key: _formKey,
                              child: PinCodeView(
                                  controller: _pinController,
                                  onChanged: (_){},
                                  //onCompleted: (_)=>_submit(context),
                                  validator: Validator.validate),
                            ),
                            if(state is! AccountProcessing)...[
                              InkWell(
                                onTap: ()=>context.read<AccountCubit>().requestPinReset(verifier),
                                child: Text.rich(TextSpan(
                                    text: 'Didn\'t receive OTP? ',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 2
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'RESEND OTP',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).colorScheme.secondary
                                          ))
                                    ]
                                ),textAlign: TextAlign.center),
                              )
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ButtonView(onPressed: ()=>_submit(context),
                        processing: state is AccountProcessing,
                        child: const Text('Verify',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700))),
                  )
              );
            }
        )
    );
  }

  _submit(BuildContext ctx){
    if(_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().verifyPinRecoveryOTP(_pinController.text);
      FocusScope.of(context).unfocus();
    }
  }

}
