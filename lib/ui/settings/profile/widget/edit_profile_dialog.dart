import 'package:chow/model/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/account/account.dart';
import '../../../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../../../res/app_images.dart';
import '../../../../res/enum.dart';
import '../../../../utils/validator.dart';
import '../../../modals.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/text_edit_view.dart';

class EditProfileDialog extends StatefulWidget {
  final String title;
  const EditProfileDialog({required this.title, Key? key}) : super(key: key);

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();

  final _surnameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _emailController = TextEditingController();

  @override
  void initState() {
    final user = Provider.of<UserViewModel>(context, listen: false).user!;
    _firstnameController.text = user.firstName ?? '';
    _surnameController.text = user.lastName ?? '';
    _phoneController.text = user.phoneNumber;
    _emailController.text = user.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)),
        child: BlocConsumer<AccountCubit, AccountStates>(
            listener: (context, state) {
          if (state is AccountApiErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          } else if (state is AccountNetworkErr) {
            if (state.message != null) {
              Modals.showToast(state.message!, messageType: MessageType.error);
            }
          } else if (state is AccountUpdated) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(widget.title,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600))),
                    const SizedBox(width: 5),
                    Align(
                      alignment: Alignment.topRight,
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
                  child: AutofillGroup(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    if (widget.title.contains('First name')) ...[
                      TextEditView(
                          controller: _firstnameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.go,
                          autofillHints: const [AutofillHints.givenName],
                          validator: Validator.validate,
                          hintText: 'Enter firstname',
                          onFieldSubmitted: (_) => _submit(context))
                    ],
                    if (widget.title.contains('Surname')) ...[
                      TextEditView(
                          controller: _surnameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.go,
                          autofillHints: const [AutofillHints.familyName],
                          validator: Validator.validate,
                          hintText: 'Enter surname',
                          onFieldSubmitted: (_) => _submit(context))
                    ],
                    if (widget.title.contains('Phone Number')) ...[
                      TextEditView(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.go,
                          autofillHints: const [AutofillHints.telephoneNumber],
                          validator: Validator.validate,
                          labelText: 'Enter phone number',
                          onFieldSubmitted: (_) => _submit(context))
                    ],
                    if (widget.title.contains('Email')) ...[
                      TextEditView(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.go,
                          autofillHints: const [AutofillHints.email],
                          validator: Validator.validateEmail,
                          labelText: 'Enter email',
                          onFieldSubmitted: (_) => _submit(context))
                    ]
                  ])),
                ),
                const SizedBox(height: 25),
                ButtonView(
                    onPressed: () => _submit(context),
                    borderRadius: 6,
                    processing: state is AccountProcessing,
                    child: const Text('Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)))
              ],
            ),
          );
        }));
  }

  _submit(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AccountCubit>().updateUser(
          firstName: _firstnameController.text,
          lastName: _surnameController.text,
          email: _emailController.text);
      FocusScope.of(context).unfocus();
    }
  }
}
