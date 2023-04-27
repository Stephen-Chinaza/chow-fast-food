import 'package:chow/blocs/account/account.dart';
import 'package:chow/blocs/wallet/wallet_cubit.dart';
import 'package:chow/requests/repositories/account_repository/account_repository_impl.dart';
import 'package:chow/requests/repositories/wallet_repository/wallet_repository_impl.dart';
import 'package:chow/ui/settings/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/plans/plans_cubit.dart';
import '../model/view_models/meal_plan_view_model.dart';
import '../model/view_models/products_view_model.dart';
import '../model/view_models/user_view_model.dart';
import '../requests/repositories/meal_plan_repository/meal_plan_repository_impl.dart';
import '../res/app_images.dart';
import 'bookings/bookings_screen.dart';
import 'home/home_screen.dart';
import 'plans/plans_screen.dart';
import 'widgets/custom_button_nav.dart';
import 'widgets/image_view.dart';
import '../../blocs/products/products.dart';
import 'package:chow/requests/repositories/products_repository/product_repository_impl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AccountCubit>(
        lazy: false,
        create: (BuildContext context) => AccountCubit(
            accountRepository: AccountRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)),
      ),
      BlocProvider<PlansCubit>(
          create: (_) => PlansCubit(
              viewModel: Provider.of<MealPlanViewModel>(context, listen: false),
              mealPlanRepository: MealPlanRepositoryImpl())),
      BlocProvider<ProductsCubit>(
        create: (BuildContext context) => ProductsCubit(
            productsRepository: ProductRepositoryImpl(),
            viewModel: Provider.of<ProductsViewModel>(context, listen: false)),
      ),
      BlocProvider<WalletCubit>(
        create: (BuildContext context) => WalletCubit(
            walletRepository: WalletRepositoryImpl(),
            viewModel: Provider.of<UserViewModel>(context, listen: false)),
      ),
    ], child: const DashboardContent());
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({Key? key}) : super(key: key);

  @override
  _DashboardContentState createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent>
    with WidgetsBindingObserver {
  late AccountCubit _accountCubit;
  late ProductsCubit _productsCubit;
  late WalletCubit _walletCubit;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _asyncInitMethod();
    super.initState();
  }

  void _asyncInitMethod() async {
    _accountCubit = context.read<AccountCubit>();
    _walletCubit = context.read<WalletCubit>();
    _productsCubit = context.read<ProductsCubit>();
    _accountCubit.fetchUser();
    _walletCubit.getWalletBalance();
    _productsCubit.getCartProduct();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: FloatingActionButton(
            heroTag: "Scan",
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
                side:
                    BorderSide(color: Theme.of(context).colorScheme.secondary)),
            splashColor: Theme.of(context).backgroundColor,
            child: ImageView.svg(AppImages.icScan,
                color: Theme.of(context).primaryColor),
            onPressed: () {},
          ),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 10,
                ),
              ],
            ),
            child: FABBottomAppBar(
              onTabSelected: _onItemTapped,
              color: Theme.of(context).textTheme.caption!.color!,
              selectedColor: Theme.of(context).colorScheme.secondary,
              backgroundColor: Theme.of(context).primaryColor,
              notchedShape: const CircularNotchedRectangle(),
              items: [
                FABBottomAppBarItem(
                    label: 'Home',
                    icon: AppImages.icHomeOutline,
                    selectedIcon: AppImages.icHome),
                FABBottomAppBarItem(
                    label: 'Bookings',
                    icon: AppImages.icBookingsOutline,
                    selectedIcon: AppImages.icBookings),
                FABBottomAppBarItem(
                    label: 'Plans',
                    icon: AppImages.icPlansOutline,
                    selectedIcon: AppImages.icPlans),
                FABBottomAppBarItem(
                    label: 'Profile',
                    icon: AppImages.icProfileOutline,
                    selectedIcon: AppImages.icProfile),
              ],
            )),
        body: _bottomNavOptions[_selectedIndex]);
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      /// app just resumed
    } else if (state == AppLifecycleState.inactive) {
      /// app is inactive
    } else if (state == AppLifecycleState.paused) {
      /// user is about quit our app temporally
    } else if (state == AppLifecycleState.detached) {
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  final List<Widget> _bottomNavOptions = <Widget>[
    const HomeScreen(),
    const Bookings(),
    const PlansScreen(),
    const ProfileScreen(),
  ];
}
