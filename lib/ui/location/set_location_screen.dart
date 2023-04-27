
import 'package:chow/ui/location/widgets/location_search.dart';
import 'package:chow/ui/location/widgets/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/account/account_cubit.dart';
import '../../blocs/location/location.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/account_repository/account_repository_impl.dart';
import '../../requests/repositories/location_repository/location_repository_impl.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({Key? key})
      : scale=false, super(key: key);

  const SetLocationScreen.scale({Key? key})
      : scale=true, super(key: key);

  final bool scale;

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountCubit>(
          lazy: false,
          create: (_) => AccountCubit(
              accountRepository: AccountRepositoryImpl(),
              viewModel: Provider.of<UserViewModel>(context, listen: false)
          ),
        ),
        BlocProvider<LocationCubit>(
          lazy: false,
            create: (_) => LocationCubit(
                locationRepository: LocationRepositoryImpl(),
                userViewModel: Provider.of<UserViewModel>(context, listen: false)),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Set Location',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24)),
          centerTitle: false,
        ),
        body: const MapView(),
        bottomNavigationBar: Builder(
            builder: (_) {
              if(!widget.scale){
                return const LocationSearch();
              }
              return const SizedBox.shrink();
            }
        ),
        bottomSheet: Builder(
            builder: (_) {
              if(widget.scale){
                return const LocationSearch();
              }
              return const SizedBox.shrink();
            }
        ),
      )
    );
  }

}
