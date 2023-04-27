
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
import '../widgets/image_view.dart';
import '../widgets/pin_code_view.dart';
import '../widgets/progress_indicator.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();

  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size=AppUtils.deviceScreenSize(context);
    return BlocProvider<AccountCubit>(
        lazy: false,
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)
        ),
        child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
              if(state is AccountUpdated){
                AppNavigator
                    .pushAndStackNamed(context,
                    name: AppRoutes.successScreen).then((value){
                  if(value!=null && value){
                    AppNavigator.pushAndReplaceName(context,
                        name: AppRoutes.createPinScreen);
                  }
                });
              }else if(state is OTPResent){
                Modals.showToast(state.message,
                    messageType: MessageType.success);
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
              final user=context.watch<AccountCubit>().viewModel.user!;
              return Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ImageView.svg(AppImages.icOTP),
                            const SizedBox(height: 10),
                            const Text('OTP Verification',
                                style: TextStyle(fontSize: 24,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: size.width*0.15),
                            Align(alignment: Alignment.centerLeft,
                              child: Text.rich(TextSpan(
                                  text: 'Please enter the 4 digit code sent to\n',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      height: 2
                                  ),
                                  children: [
                                    TextSpan(
                                        text: user.phone,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600
                                        ))
                                  ]
                              ),textAlign: TextAlign.start),
                            ),
                            const SizedBox(height: 25),
                            Form(key: _formKey,
                              child: PinCodeView(
                                  controller: _pinController,
                                  onChanged: (_){},
                                  onCompleted: (_)=>_submit(context),
                                  validator: Validator.validate),
                            ),
                            if(state is AccountProcessing)...[
                              Center(
                                child: ProgressIndicators
                                    .circularProgressBar(context),
                              )
                            ]else...[
                              Align(alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: ()=>context.read<AccountCubit>().resentOTP(user.phoneNumber),
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
                                  ),textAlign: TextAlign.start),
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                    ),
                  )
              );
            }
        )
    );
  }

  _submit(BuildContext ctx){
    if(_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().verifyOTP(_pinController.text);
      FocusScope.of(context).unfocus();
    }
  }

}
