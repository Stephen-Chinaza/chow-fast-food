
import 'dart:io';

import 'package:chow/ui/settings/kyc_verification/widget/document_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/account/account.dart';
import '../../../../res/app_images.dart';
import '../../../../utils/validator.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/dropdown_view.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/text_edit_view.dart';
import 'profile_input.dart';

class PhotoId extends StatefulWidget {
  final void Function() onCompleted;
  const PhotoId({required this.onCompleted,
    Key? key}) : super(key: key);

  @override
  State<PhotoId> createState() => _PhotoIdState();
}

class _PhotoIdState extends State<PhotoId> {

  final _formKey = GlobalKey<FormState>();

  final _idNumberController = TextEditingController();

  String? _idTypeDropdownValue;
  final List<String> _idTypeSpinnerItems = [
    'National ID',
    'Voter\'s Card',
    'Driver\'s License',
    'International Passport'
  ];

  File? _idFront;

  File? _idBack;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {},
        builder: (context, state)=>ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Card(
                elevation: 5,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Photo ID',
                            style: TextStyle(fontWeight: FontWeight.w700,
                                fontSize: 18)),
                        const SizedBox(height: 10),
                        const Text('Take a clear photo of your government ID (must be '
                            'one of Int. Pass, Driver License, etc).Make sure lighting is '
                            'good and any lettering is clear before uploading.'
                            ' For best results, please use a mobile device.',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                fontSize: 14)),
                        const SizedBox(height: 25),
                        ProfileInputField(label: 'Choose ID type',
                            child: DropdownView.form(
                                isDense: true,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
                                  child: ImageView.svg(AppImages.icIdentityCard),
                                ),
                                value: _idTypeDropdownValue,
                                items: _idTypeSpinnerItems
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                validator: Validator.validate,
                                hintText: 'Choose ID type',
                                onChanged: (String? value) =>
                                    setState(() => _idTypeDropdownValue = value!))),
                        const SizedBox(height: 15),
                        ProfileInputField(label: 'ID Number',
                            child: TextEditView(
                                controller: _idNumberController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                validator: Validator.validate,
                                labelText: 'Enter ID Number here',
                                prefixIcon:  const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
                                  child: ImageView.svg(AppImages.icIdentityNumber),
                                )
                            ))
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DocumentUpload(onSelected: (file)=>setState(()=>_idFront=file),
                      description: 'Please upload the front side of your ID Card',
                      icon: AppImages.imgCardFront),
                  const SizedBox(height: 15),
                  DocumentUpload(onSelected: (file)=>setState(()=>_idBack=file),
                      description: 'Please upload the back side of your ID Card',
                      icon: AppImages.imgCardBack),
                  const SizedBox(height: 50),
                  ButtonView(
                      onPressed: _submit,
                      borderRadius: 6,
                      disabled: (_idFront==null || _idBack==null),
                      child: const Text('Continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ],
              ),
            ),
            const SizedBox(height: 35),
          ],
        )
    );
  }

  _submit()async{
    if (_formKey.currentState!.validate()) {
      await context.read<AccountCubit>().setKYCValue(
          idType: _idTypeDropdownValue,
          idNumber: _idNumberController.text,
          idFront: _idFront,
          idBack: _idBack
      );
      widget.onCompleted();
      FocusScope.of(context).unfocus();
    }
  }

}
