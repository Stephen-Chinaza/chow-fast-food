
import 'package:country_code_picker/country_code_picker.dart';
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
import '../widgets/text_edit_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();

  final _firstnameController = TextEditingController();

  final _lastnameController = TextEditingController();


  String? _nationality = 'Nigeria';

  String? _countryCode = '+234';

  @override
  Widget build(BuildContext context) {
    final size=AppUtils.deviceScreenSize(context);
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.signUpBg),
                fit: BoxFit.fill,
                alignment: Alignment.center
            ),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: BlocProvider<AccountCubit>(
                lazy: false,
                create: (_) => AccountCubit(
                    accountRepository: AccountRepositoryImpl(),
                    viewModel: Provider.of<UserViewModel>(context, listen: false)
                ),
                child: BlocConsumer<AccountCubit, AccountStates>(
                    listener: (context, state) {
                      if(state is AccountUpdated){
                        AppNavigator.pushAndReplaceName(context,
                            name: AppRoutes.otpScreen);
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
                    builder: (context, state) =>SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.width*0.28),
                          Text.rich(TextSpan(
                              text: 'Join Us\n',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5
                              ),
                              children: const [
                                TextSpan(
                                    text: 'Get all your orders delivered ASAP!',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600
                                    ))
                              ]
                          ),textAlign: TextAlign.start),
                          SizedBox(height: size.width*0.18),
                          Text('Please provide your details to register',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 25.0),
                          Form(
                            key: _formKey,
                            child: AutofillGroup(child:
                            Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextEditView(
                                        controller: _firstnameController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        autofillHints: const [AutofillHints.givenName],
                                        validator: Validator.validate,
                                        labelText: 'First name',
                                        borderColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                        textColor: Theme.of(context).primaryColor,
                                        prefixIcon:  Icon(Icons.person,
                                            color: Theme.of(context).primaryColor)
                                    )
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: TextEditView(
                                        controller: _lastnameController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        autofillHints: const [AutofillHints.familyName],
                                        validator: Validator.validate,
                                        labelText: 'Surname',
                                        borderColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                        textColor: Theme.of(context).primaryColor,
                                        prefixIcon:  Icon(Icons.person,
                                            color: Theme.of(context).primaryColor)
                                    )
                                  )
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              TextEditView(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.telephoneNumber],
                                  validator: (value)=>Validator
                                      .validatePhone(value, _countryCode),
                                  labelText: 'Mobile Number',
                                  borderColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                  textColor: Theme.of(context).primaryColor,
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
                              ),
                              const SizedBox(height: 15.0),
                              TextEditView(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.go,
                                  autofillHints: const [AutofillHints.email],
                                  validator: Validator.validateEmail,
                                  labelText: 'Email',
                                  borderColor: Theme.of(context).primaryColor.withOpacity(0.7),
                                  textColor: Theme.of(context).primaryColor,
                                  prefixIcon:  Icon(Icons.email,
                                      color: Theme.of(context).primaryColor),
                                  onFieldSubmitted: (_) => _submit(context))
                            ])),
                          ),
                          const SizedBox(height: 35.0),
                          ButtonView(onPressed: ()=>_submit(context),
                              color: Theme.of(context).primaryColor,
                              borderColor: Theme.of(context).primaryColor,
                              borderRadius: 8.0,
                              processing: state is AccountProcessing,
                              child: Text('Register',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary,
                                      fontSize: 18, fontWeight: FontWeight.w700))),
                          const SizedBox(height: 65.0),
                          Center(
                            child: Text('Already have an account?',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(height: 15.0),
                          Center(
                            child: InkWell(
                              onTap: ()=>AppNavigator
                                  .pushAndReplaceName(context,
                                  name: AppRoutes.signInScreen),
                              child: Text('Login here',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          SizedBox(height: size.width*0.28),
                        ],
                      ),
                    )
                )
            )
          ),
        )
    );
  }

  _submit(BuildContext ctx){
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().registerUser(
          firstName: _firstnameController.text,
          lastName: _lastnameController.text,
          phoneNumber: _phoneController.text,
          countryCode: _countryCode!,
          email: _emailController.text);
      FocusScope.of(context).unfocus();
    }
  }

}