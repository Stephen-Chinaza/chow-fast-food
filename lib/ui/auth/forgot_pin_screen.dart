
import 'package:chow/res/app_colors.dart';
import 'package:country_code_picker/country_code.dart';
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
import '../widgets/country_code_view.dart';
import '../widgets/image_view.dart';
import '../widgets/text_edit_view.dart';

class ForgotPinScreen extends StatefulWidget {
  const ForgotPinScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();

  String? _nationality = 'Nigeria';

  String? _countryCode = '+234';

  bool _phone = true;

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
              if(state is PinResetOTPSent){
                AppNavigator.pushAndStackNamed(context,
                    name: AppRoutes.forgotPinOtpScreen,
                    arguments: {'verifier' : verifier,
                      'phone' : _phone});
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
                  title: const Text('Forgot Pin',
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
                                AppImages.forgotPassword,
                                scale: 2),
                            SizedBox(height: size.height*0.05),
                            Text(_phone
                                ? 'Please Enter Your Phone Number To Receive A Verification Code'
                                : 'Please Enter The Email Address You Used To Open '
                                'The Account To Receive A Verification Code',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: size.height*0.05),
                            Form(key: _formKey,
                              child: Column(
                                children: [
                                  if(_phone)...[
                                    TextEditView(
                                        controller: _phoneController,
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.go,
                                        autofillHints: const [AutofillHints.telephoneNumber],
                                        validator: (value)=>Validator
                                            .validatePhone(value, _countryCode),
                                        labelText: 'Mobile Number',
                                        borderColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                        textColor: Theme.of(context).primaryColor,
                                        fillColor: Theme.of(context).shadowColor.withOpacity(0.2),
                                        onFieldSubmitted: (_)=>_submit(context),
                                        prefixIcon:  Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(width: 8.0),
                                            Icon(Icons.phone,
                                                color: Theme.of(context).primaryColor),
                                            CountryCodeView(
                                                initialSelection: _nationality,
                                                textColor: Theme.of(context).primaryColor,
                                                onChanged: (CountryCode countryCode) {
                                                  setState((){
                                                    _countryCode = countryCode.dialCode;
                                                    _nationality= countryCode.name;
                                                  });
                                                }
                                            )
                                          ],
                                        )
                                    )
                                  ]else...[
                                    TextEditView(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.go,
                                      autofillHints: const [AutofillHints.email],
                                      validator: Validator.validate,
                                      labelText: 'Enter Email here',
                                      onFieldSubmitted: (_)=>_submit(context),
                                      borderColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                      textColor: Theme.of(context).primaryColor,
                                      fillColor: Theme.of(context).shadowColor.withOpacity(0.2),
                                    )
                                  ]
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            InkWell(onTap: () =>setState(()=>_phone=!_phone),
                              child: const Text('Try another Way',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14,
                                      color: AppColors.lightSecondaryAccent,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline)),
                            )
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
                      child: const Text('Send',
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

  String get verifier => _phone ? _phoneController.text : _emailController.text;

  _submit(BuildContext ctx){
    if(_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().requestPinReset(verifier);
      FocusScope.of(context).unfocus();
    }
  }

}
