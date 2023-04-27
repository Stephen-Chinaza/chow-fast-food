
import 'package:chow/ui/plans/widget/active_plans.dart';
import 'package:chow/ui/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/plans/plans.dart';
import '../widgets/cart_icon.dart';
import '../widgets/custom_toggle.dart';
import '../widgets/loading_page.dart';
import 'widget/completed_plans.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  late PageController _controller;
  int initCount = 0;

  late PlansCubit _plansCubit;
  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: 0,
    );
  }

  @override
  void didChangeDependencies() {
    _plansCubit=context.read<PlansCubit>();
    _plansCubit.getActiveMealPlans();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      initCount = index;
    });
  }

  void onFilterSelected(int index) {
    setState(() {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plans',
            style: TextStyle(fontWeight: FontWeight.w600,
                fontSize: 24)),
        centerTitle: true,
        actions: const [
          CartIcon(),
          SizedBox(width: 10)
        ],
      ),
      body: Column(
        children: [
          CustomToggle(
            title: const ['Active Plans',
              'Completed Plans'],
            onSelected: onFilterSelected,
          ),
          BlocConsumer<PlansCubit, PlansStates>(
              builder: (context, state) {
                if (state is MealPlansLoading) {
                  return const LoadingPage(length: 8);
                } else if (state is MealPlansNetworkErr) {
                  return EmptyWidget(
                    title: 'Network error',
                    description: state.message,
                    onRefresh: ()=>_plansCubit.getActiveMealPlans(),
                  );
                }
                final active = _plansCubit.viewModel.inProgressMealPlans;
                final completed = _plansCubit.viewModel.completedMealPlans;
                return Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      onPageChanged: _onPageChanged,
                      children: [
                        ActivePlans(active),
                        CompletedPlans(completed)
                      ],
                    )
                );
              },
              listener: (_, state) {}
          )
        ],
      ),
    );
  }
}
