import 'package:chow/res/app_strings.dart';
import 'package:chow/res/enum.dart';
import 'package:chow/ui/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/account/account_cubit.dart';
import '../../blocs/account/account_states.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../widgets/button_view.dart';
import '../widgets/text_edit_view.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = AppUtils.deviceScreenSize(context);
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.signInBg),
            fit: BoxFit.fill,
            alignment: Alignment.center),
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
                  viewModel:
                      Provider.of<UserViewModel>(context, listen: false)),
              child: BlocConsumer<AccountCubit, AccountStates>(
                  listener: (context, state) {
                    if (state is AccountLoaded) {
                      final user = state.userData.user;

                      /*if(!user.accountVerified){
                          AppNavigator.pushAndReplaceName(context,
                              name: AppRoutes.otpScreen);
                        }else*/
                      if (!user.pinCreated) {
                        AppNavigator.pushAndReplaceName(context,
                            name: AppRoutes.createPinScreen);
                      } else if (user.location == null) {
                        AppNavigator.pushAndReplaceName(context,
                            name: AppRoutes.setLocationScreen);
                      } else if (user.isBlocked) {
                        context.read<AccountCubit>().logoutUser();
                        Modals.showToast('Your account is blocked',
                            messageType: MessageType.error);
                      } else {
                        AppNavigator.pushAndReplaceName(context,
                            name: AppRoutes.dashboard);
                      }
                    } else if (state is AccountLoggedOut) {
                      AppNavigator.pushNamedAndRemoveUntil(context,
                          name: AppRoutes.welcomeScreen);
                    } else if (state is AccountApiErr) {
                      if (state.message != null) {
                        Modals.showToast(state.message!,
                            messageType: MessageType.error);
                      }
                    } else if (state is AccountNetworkErr) {
                      if (state.message != null) {
                        Modals.showToast(state.message!,
                            messageType: MessageType.error);
                      }
                    }
                  },
                  builder: (context, state) => SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 80),
                            Text.rich(
                                TextSpan(
                                    text: 'Welcome to\n',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5),
                                    children: const [
                                      TextSpan(
                                          text: '${AppStrings.appName}!',
                                          style: TextStyle(
                                              fontSize: 58,
                                              fontWeight: FontWeight.w800))
                                    ]),
                                textAlign: TextAlign.start),
                            SizedBox(height: size.width * 0.08),
                            Text('Get all your orders delivered ASAP!',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: size.width * 0.18),
                            Text(
                                'Login into your ${AppStrings.appName} Account',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 25.0),
                            Form(
                              key: _formKey,
                              child: AutofillGroup(
                                  child: Column(children: [
                                TextEditView(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [
                                      AutofillHints.telephoneNumber
                                    ],
                                    validator: Validator.validate,
                                    labelText: 'Mobile Number',
                                    borderColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7),
                                    textColor: Theme.of(context).primaryColor,
                                    prefixIcon: Icon(Icons.phone,
                                        color: Theme.of(context).primaryColor)),
                                const SizedBox(height: 15.0),
                                TextEditView(
                                    controller: _pinController,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.go,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                    validator: Validator.validate,
                                    onFieldSubmitted: (_) => _submit(context),
                                    obscureText: true,
                                    labelText: 'PIN',
                                    maxLength: 4,
                                    borderColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7),
                                    textColor: Theme.of(context).primaryColor,
                                    prefixIcon: Icon(Icons.lock,
                                        color: Theme.of(context).primaryColor))
                              ])),
                            ),
                            const SizedBox(height: 25.0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () => AppNavigator.pushAndStackNamed(
                                    context,
                                    name: AppRoutes.forgotPinScreen),
                                child: Text('Recover PIN',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            const SizedBox(height: 35.0),
                            ButtonView(
                                onPressed: () => _submit(context),
                                color: Theme.of(context).primaryColor,
                                borderColor: Theme.of(context).primaryColor,
                                borderRadius: 8.0,
                                processing: state is AccountProcessing,
                                child: Text('Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700))),
                            const SizedBox(height: 35.0),
                            Center(
                              child: Text('Don’t have an account?',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ),
                            const SizedBox(height: 15.0),
                            Center(
                              child: InkWell(
                                onTap: () => AppNavigator.pushAndReplaceName(
                                    context,
                                    name: AppRoutes.signUpScreen),
                                child: Text('Join Now',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            SizedBox(height: size.width * 0.28),
                          ],
                        ),
                      )))),
    ));
  }

  _submit(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().loginUser(
          pin: _pinController.text, phoneNumber: _phoneController.text);
      FocusScope.of(context).unfocus();
    }
  }
}
