import 'package:chow/model/view_models/meal_plan_view_model.dart';
import 'package:chow/ui/widgets/custom_multi_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/app_images.dart';
import '../../widgets/button_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/image_view.dart';

class PlanOptionDialog extends StatefulWidget {
  const PlanOptionDialog({Key? key}) : super(key: key);

  @override
  State<PlanOptionDialog> createState() => _PlanOptionDialogState();
}

class _PlanOptionDialogState extends State<PlanOptionDialog> {

  late String _selectedPlan;
  final List<String> _plans = ['Daily', 'Weekly', 'Monthly', 'Custom'];

  List<int> _selectedDays=[];
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    _selectedPlan = _plans.first;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MealPlanViewModel>(
        builder: (BuildContext context, MealPlanViewModel viewModel, Widget? child)
        =>ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const ImageView.svg(
                    AppImages.dropDown,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'How would you like to plan your meal?',
                style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _plans.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 45,
              ),
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  value: _plans[index],
                  groupValue: _selectedPlan,
                  title: CustomText(
                    text: _plans[index],
                    size: 16,
                    color: (_selectedPlan == _plans[index])
                        ? Colors.black
                        : Colors.grey,
                    weight: FontWeight.bold,
                  ),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) => setState(() => _selectedPlan = _plans[index]),
                );
              },
            ),
            if(_selectedPlan==_plans.last)...[
              const SizedBox(height: 25),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text('Choose your day',
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).textTheme.caption!.color))
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomMultiToggle(
                    title: _days,
                    selectedIndex: _selectedDays,
                    onSelected: (value)=>setState(()=>_selectedDays=value)
                ),
              ),
            ]else...[
              const SizedBox(height: 180)
            ],
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ButtonView(
                  onPressed: ()=>{
                    viewModel.setPlan(_selectedPlan, _selectedDays),
                    Navigator.pop(context, _selectedPlan)
                  },
                  borderRadius: 6,
                  child: const Text('Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700))),
            )
          ],
        )
    );
  }
}
