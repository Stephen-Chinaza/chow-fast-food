
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/account/account.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../../../res/app_images.dart';
import '../../../../res/enum.dart';
import '../../../../utils/validator.dart';
import '../../../modals.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/text_edit_view.dart';


class EditPasswordDialog extends StatefulWidget {
  const EditPasswordDialog({Key? key}) : super(key: key);

  @override
  State<EditPasswordDialog> createState() => _EditPasswordDialogState();
}

class _EditPasswordDialogState extends State<EditPasswordDialog> {

  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();

  final _newPasswordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)
        ),
        child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
              if(state is AccountApiErr){
                if(state.message!=null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }else if(state is AccountNetworkErr){
                if(state.message!=null) {
                  Modals.showToast(state.message!,
                      messageType: MessageType.error);
                }
              }else if(state is AccountPinChanged){
                Modals.showToast(state.message,
                    messageType: MessageType.success);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text('Edit Password',
                            style: TextStyle(fontSize: 24,
                                fontWeight: FontWeight.w600))),
                        const SizedBox(width: 5),
                        Align(alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const ImageView.svg(
                              AppImages.dropDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Form(
                      key: _formKey,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextEditView(
                                controller: _oldPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                validator: Validator.validate,
                                hintText: 'Enter Old password',
                                maxLength: 4,
                                obscureText: true
                            ),
                            const SizedBox(height: 15),
                            TextEditView(
                                controller: _newPasswordController,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                validator: Validator.validate,
                                hintText: 'Enter new password',
                                maxLength: 4,
                                obscureText: true
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
                                hintText: 'Repeat new password',
                                maxLength: 4,
                                onFieldSubmitted: (_)=>_submit(context)
                            )
                          ]),
                    ),
                    const SizedBox(height: 25),
                    ButtonView(
                        onPressed: ()=>_submit(context),
                        borderRadius: 6,
                        processing: state is AccountProcessing,
                        child: const Text('Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700)))
                  ],
                ),
              );
            }
        )
    );
  }

  _submit(BuildContext ctx){
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().changePin(
        newPin: _newPasswordController.text,
        oldPin: _oldPasswordController.text
      );
      FocusScope.of(context).unfocus();
    }
  }

}
