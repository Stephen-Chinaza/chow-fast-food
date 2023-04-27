
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/account/account.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../res/app_routes.dart';
import '../../res/enum.dart';
import '../../utils/app_utils.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/validator.dart';
import '../modals.dart';
import '../widgets/button_view.dart';
import '../widgets/pin_code_view.dart';


class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({Key? key}) : super(key: key);

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {

  final _formKey = GlobalKey<FormState>();

  final _pinController = TextEditingController();

  final _confirmPinController = TextEditingController();

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
              if(state is AccountLoaded){
                AppNavigator.pushAndReplaceName(context,
                    name: AppRoutes.setLocationScreen);
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
            builder: (context, state) =>Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  padding: MediaQuery.of(context).viewInsets,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      const Text('Create PIN',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600
                          )),
                      const SizedBox(height: 15.0),
                      const Text('Create a 4 digit PIN to secure your Chow account.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400
                          )),
                      SizedBox(height: size.width*0.15),
                      Form(key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PinCodeView(
                                controller: _pinController,
                                onChanged: (_){},
                                obscureText: true,
                                label: 'Enter PIN',
                                validator: Validator.validate),
                            SizedBox(height: size.width*0.15),
                            PinCodeView(
                                controller: _confirmPinController,
                                onChanged: (_){},
                                obscureText: true,
                                label: 'Confirm PIN',
                                validator: (String? value){
                                  if(value==null || value.isEmpty){
                                    return 'Required';
                                  }else if(value!=_pinController.text){
                                    return 'Pin Mismatch';
                                  }
                                  return null;
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ButtonView(onPressed: ()=>_submit(context),
                    processing: state is AccountProcessing,
                    child: const Text('Create PIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700))),
              ),
            )
        )
    );
  }

  _submit(BuildContext ctx){
    if (_formKey.currentState!.validate()) {
      final accountCubit=ctx.read<AccountCubit>();
      accountCubit.createPin(
          pin: _pinController.text,
          userId: accountCubit.viewModel.user!.id);
      FocusScope.of(context).unfocus();
    }
  }

}

