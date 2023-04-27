import 'package:chow/blocs/account/account.dart';
import 'package:chow/ui/settings/kyc_verification/widget/personal_details.dart';
import 'package:chow/ui/settings/kyc_verification/widget/photo_id.dart';
import 'package:chow/ui/settings/kyc_verification/widget/take_a_selfie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../../res/enum.dart';
import '../../widgets/stepper/custom_step.dart';
import '../../widgets/stepper/custom_stepper.dart';

class KYCVerificationScreen extends StatefulWidget {
  const KYCVerificationScreen({Key? key}) : super(key: key);

  @override
  State<KYCVerificationScreen> createState() => _KYCVerificationScreenState();
}

class _KYCVerificationScreenState extends State<KYCVerificationScreen> {

  int _currentStep=0;

  final _steps=<String>['User Details', 'Photo ID', 'Selfie'];

  @override
  Widget build(BuildContext context) {

    final _contents=<Widget>[
      PersonalDetails(onCompleted: ()=>_nextPage(1)),
      PhotoId(onCompleted: ()=>_nextPage(2)),
      const TakeASelfie(),
    ];

    return BlocProvider<AccountCubit>(
        create: (_) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)
        ),
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text('KYC Verification',
                    style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.w600)),
                actions: [
                  IconButton(onPressed: (){},
                      icon: const Icon(Icons.more_vert)),
                  const SizedBox(width: 10)
                ]
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text('Complete your KYC Verification to enable us serve you better',
                      style: TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: CustomStepper(
                      currentStep: _currentStep,
                      steps: List.generate(
                          _steps.length, (index) => CustomStep(
                          title: _steps[index],
                          content: _contents[index],
                          state: _currentStep > index ? CustomStepState.completed :
                          _currentStep == index ? CustomStepState.current:
                          CustomStepState.idle
                      ))),
                )
              ],
            )
        )
    );
  }

  void _nextPage(int index){
    setState(()=>_currentStep=index);
  }

}
