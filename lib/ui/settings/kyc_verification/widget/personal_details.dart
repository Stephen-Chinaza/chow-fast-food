import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../blocs/account/account.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../res/app_images.dart';
import '../../../../utils/validator.dart';
import '../../../widgets/button_view.dart';
import '../../../widgets/country_code_view.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/text_edit_view.dart';
import 'profile_input.dart';

class PersonalDetails extends StatefulWidget {
  final void Function() onCompleted;
  const PersonalDetails({required this.onCompleted, Key? key})
      : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();

  final _surnameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _nationalityController = TextEditingController();

  //String? _countryCode = '+234';

  DateTime dob = DateTime.now();

  @override
  void initState() {
    final user = Provider.of<UserViewModel>(context, listen: false).user!;
    _firstnameController.text = user.firstName ?? '';
    _surnameController.text = user.lastName ?? '';
    _phoneController.text = user.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, state) {},
        builder: (context, state) => Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15.0),
              children: [
                const Text('Personal Details',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                const SizedBox(height: 5),
                const Text('Fill in your personal Details',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: AutofillGroup(
                      child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                            child: ProfileInputField(
                          label: 'Firstname',
                          child: TextEditView(
                              controller: _firstnameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.givenName],
                              validator: Validator.validate,
                              hintText: 'Enter firstname',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 5.0),
                                child: ImageView.svg(AppImages.icPerson),
                              )),
                        )),
                        const SizedBox(width: 15),
                        Expanded(
                            child: ProfileInputField(
                                label: 'Surname',
                                child: TextEditView(
                                    controller: _surnameController,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [
                                      AutofillHints.familyName
                                    ],
                                    validator: Validator.validate,
                                    hintText: 'Enter surname',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 5.0),
                                      child: ImageView.svg(AppImages.icPerson),
                                    ))))
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    ProfileInputField(
                        label: 'Date of birth',
                        child: CustomDatePicker(
                            hintText: 'Enter your date of birth',
                            validator: Validator.validate,
                            isDense: false,
                            borderWidth: 1.5,
                            autofillHints: const [AutofillHints.birthday],
                            onSelected: (DateTime date) =>
                                setState(() => dob = date))),
                    const SizedBox(height: 15.0),
                    ProfileInputField(
                        label: 'Nationality',
                        child: TextEditView(
                            controller: _nationalityController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            readOnly: true,
                            autofillHints: const [AutofillHints.countryName],
                            validator: Validator.validate,
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 8),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 5.0),
                                  child: ImageView.svg(AppImages.icFlag),
                                ),
                                Expanded(
                                  child: CountryCodeView(
                                      initialSelection: 'Nigeria',
                                      showCountryOnly: true,
                                      showOnlyCountryWhenClosed: true,
                                      showFlagMain: false,
                                      alignLeft: true,
                                      onChanged: (CountryCode countryCode) {
                                        setState(() {
                                          //_countryCode = countryCode.dialCode;
                                          _nationalityController.text =
                                              countryCode.name!;
                                        });
                                      }),
                                )
                              ],
                            ))),
                    const SizedBox(height: 15.0),
                    ProfileInputField(
                        label: 'Phone number',
                        child: TextEditView(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.go,
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            validator: Validator.validate,
                            labelText: 'Enter phone number',
                            readOnly: true,
                            onFieldSubmitted: (_) => _submit(),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5.0),
                              child: ImageView.svg(AppImages.icPhone),
                            )))
                  ])),
                ),
                const SizedBox(height: 35),
                ButtonView(
                    onPressed: _submit,
                    borderRadius: 6,
                    child: const Text('Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700))),
                const SizedBox(height: 35),
              ],
            )));
  }

  _submit() async {
    if (_formKey.currentState!.validate()) {
      await context.read<AccountCubit>().setKYCValue(
          firstName: _firstnameController.text,
          lastName: _surnameController.text,
          dob: DateFormat('yyyy-MM-dd').format(dob),
          nationality: _nationalityController.text,
          phoneNumber: _phoneController.text);
      widget.onCompleted();
      FocusScope.of(context).unfocus();
    }
  }
}
