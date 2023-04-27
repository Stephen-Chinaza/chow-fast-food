import 'package:chow/blocs/plans/plans_cubit.dart';
import 'package:chow/ui/modals.dart';
import 'package:chow/ui/plans/widget/plan_option_dialog.dart';
import 'package:chow/ui/widgets/custom_date_picker.dart';
import 'package:chow/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/button_view.dart';
import '../../widgets/text_edit_view.dart';

class SetDuration extends StatefulWidget {
  final void Function() onCompleted;
  const SetDuration({required this.onCompleted,
    Key? key}) : super(key: key);

  @override
  State<SetDuration> createState() => _SetDurationState();
}

class _SetDurationState extends State<SetDuration> {

  final _formKey = GlobalKey<FormState>();

  final _planController=TextEditingController();

  DateTime? _startDate;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: const EdgeInsets.all(25.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(15.0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 25),
                const Text('Set Duration',
                    style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                const Text('How would you like to plan your meal?',
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 25),
                TextEditView(
                    controller: _planController,
                    keyboardType: TextInputType.none,
                    textInputAction: TextInputAction.none,
                    hintText: 'Plan',
                    borderWidth: 0,
                    isDense: true,
                    readOnly: true,
                    validator: Validator.validate,
                    onTap: ()=>Modals.showBottomSheetModal(context,
                        isScrollControlled: true,
                        heightFactor: 0.65,
                        page: const PlanOptionDialog()).then((value){
                          if(value!=null){
                            setState(()=> _planController.text=value);
                          }
                    }),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down)
                ),
                const SizedBox(height: 35),
                const Text('Start Date',
                    style: TextStyle(fontWeight: FontWeight.w600,
                        fontSize: 18)),
                const SizedBox(height: 10),
                CustomDatePicker(
                    hintText: 'Set start date',
                    validator: Validator.validate,
                    onSelected: (DateTime date)=>_startDate=date),
                const SizedBox(height: 35),
                ButtonView(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        context.read<PlansCubit>().viewModel.setPlanDate(_startDate!);
                        widget.onCompleted();
                      }},
                    borderRadius: 6,
                    child: const Text('Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700))),
                const SizedBox(height: 35),
              ],
            )));
  }
}
