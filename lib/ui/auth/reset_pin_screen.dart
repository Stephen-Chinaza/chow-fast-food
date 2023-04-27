import 'package:chow/ui/success_screen.dart';
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
import '../widgets/text_edit_view.dart';

class ResetPinScreen extends StatefulWidget {
  const ResetPinScreen({Key? key}) : super(key: key);

  @override
  State<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends State<ResetPinScreen> {
  final _formKey = GlobalKey<FormState>();

  final _newPasswordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

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
              if(state is PinResetCompleted){
                AppNavigator
                    .pushAndStackPage(context,
                    page: SuccessScreen(
                      title: 'Done',
                      message: state.message,
                      bntText: 'Sign in',
                    )).then((value){
                  if(value!=null && value){
                    Navigator.popUntil(context, (route)
                    => route.settings.name == AppRoutes.signInScreen);
                  }
                });
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
                    title: const Text('Create New Pin',
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
                            const Text('New Pin Must Be Different From Previously Used Pin',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: size.height*0.05),
                            Form(key: _formKey,
                              child: Column(
                                children: [
                                  TextEditView(
                                      controller: _newPasswordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.next,
                                      validator: Validator.validate,
                                      hintText: 'Enter Pin',
                                      maxLength: 4,
                                      obscureText: true,
                                      prefixIcon: const Icon(Icons.lock)
                                  ),
                                  const SizedBox(height: 15),
                                  TextEditView(
                                      controller: _confirmPasswordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.go,
                                      validator: (String? value) {
                                        if(value==null || value.isEmpty){
                                          return 'Required.';
                                        } else if(value!=_newPasswordController.text){
                                          return 'Password mismatch';
                                        } else{
                                          return null;
                                        }
                                      },
                                      hintText: 'Confirm Pin',
                                      maxLength: 4,
                                      onFieldSubmitted: (_)=>_submit(context),
                                      prefixIcon: const Icon(Icons.lock)
                                  )
                                ],
                              ),
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
                        child: const Text('Save',
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
      final otp = ModalRoute.of(context)?.settings.arguments as String;
      ctx.read<AccountCubit>().resetPin(newPin: _newPasswordController.text, otp: otp);
      FocusScope.of(context).unfocus();
    }
  }

}
