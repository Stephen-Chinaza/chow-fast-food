
import 'dart:io';

import 'package:chow/ui/settings/kyc_verification/widget/document_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/account/account.dart';
import '../../../../res/app_images.dart';
import '../../../../res/enum.dart';
import '../../../modals.dart';
import '../../../widgets/button_view.dart';

class TakeASelfie extends StatefulWidget {
  const TakeASelfie({Key? key}) : super(key: key);

  @override
  State<TakeASelfie> createState() => _TakeASelfieState();
}

class _TakeASelfieState extends State<TakeASelfie> {

  File? _passport;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
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
          }
        },
        builder: (context, state)=>ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            if(state is AccountUpdated)...[
              Card(
                  elevation: 5,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Submitted!',
                            style: TextStyle(fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18)),
                        const SizedBox(height: 10),
                        const Text('Thank you for the information provided, '
                            'your information is being reviewed. '
                            'You will get feedback in the next 24 hours.',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                fontSize: 14))
                      ],
                    ),
                  )),
              const SizedBox(height: 250),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ButtonView(
                    onPressed: ()=>Navigator.pop(context),
                    borderRadius: 6,
                    child: const Text('Close',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700))),
              )
            ]else...[
              Card(
                  elevation: 5,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Take a Selfie',
                            style: TextStyle(fontWeight: FontWeight.w700,
                                fontSize: 18)),
                        SizedBox(height: 10),
                        Text('Take a clear selfie of yourself.'
                            'Make sure lighting is good and your face shows '
                            'clearly down to your shoulders.',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                fontSize: 14))
                      ],
                    ),
                  )),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DocumentUpload.selfie(onSelected: (file)=>setState(()=>_passport=file),
                        description: 'Take a selfie picture of you',
                        icon: AppImages.imgSelfie),
                    const SizedBox(height: 50),
                    ButtonView(
                        onPressed: _submit,
                        borderRadius: 6,
                        disabled: _passport==null,
                        processing: state is AccountProcessing,
                        child: const Text('Submit',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700))),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 35),
          ],
        )
    );
  }

  _submit(){
    context.read<AccountCubit>().submitKYC(_passport!);
    FocusScope.of(context).unfocus();
  }

}
