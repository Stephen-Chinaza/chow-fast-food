
import 'package:chow/blocs/plans/plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/meal_plan_view_model.dart';
import '../../widgets/custom_toggle.dart';

class DailyStepper extends StatefulWidget {
  final List<Widget> contents;
  final Widget? header;
  final void Function()? onCompleted;
  const DailyStepper({required this.contents,
    this.header,
    this.onCompleted,
    Key? key}) : super(key: key);

  @override
  State<DailyStepper> createState() => _DailyStepperState();
}

class _DailyStepperState extends State<DailyStepper> {

  int _selectedPage=0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MealPlanViewModel>(
        builder: (BuildContext context, MealPlanViewModel viewModel, Widget? child)
        =>BlocConsumer<PlansCubit, PlansStates>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Card(
                    elevation:5,
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(widget.header!=null)...[
                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: widget.header!,
                          )
                        ],
                        SizedBox(
                          height: 100,
                          child: CustomToggle(
                            title: viewModel.dayCount,
                            subtitle: viewModel.dayOfWeek,
                            scrollable: true,
                            height: 50,
                            selectedIndex: _selectedPage,
                            contentPadding: const EdgeInsets
                                .symmetric(horizontal: 15.0, vertical: 5.0),
                            contentMargin: const EdgeInsets.all(15.0),
                            onSelected: (index)=>setState(()=>_selectedPage=index),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 15),
                widget.contents[_selectedPage]
              ],
            );
          },
          listener: (_, state) {
            if(state is DailyPlanSet){
              if(state.day<viewModel.newPlans.length){
                _selectedPage=state.day;
                return;
              }
              if(widget.onCompleted!=null) widget.onCompleted!();
            }
          },
        )
    );
  }
}
