import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/account/account.dart';
import '../../../blocs/location/location.dart';
import '../../../model/data_models/location/location_prediction.dart';
import '../../../res/app_routes.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../modals.dart';
import '../../widgets/button_view.dart';
import '../../widgets/text_edit_view.dart';

class LocationSearch extends StatefulWidget {
  final void Function()? onPressed;

  const LocationSearch({Key? key, this.onPressed}) : super(key: key);

  @override
  State<LocationSearch> createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  late LocationCubit _locationCubit;

  @override
  void initState() {
    _locationCubit = context.read<LocationCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountStates>(
        listener: (context, accountState) {
          if(accountState is AccountUpdated){
            AppNavigator.pushNamedAndRemoveUntil(context,
                name: AppRoutes.dashboard);
          }else if(accountState is AccountApiErr){
            if(accountState.message!=null) {
              Modals.showToast(accountState.message!,
                  messageType: MessageType.error);
            }
          }else if(accountState is AccountNetworkErr){
            if(accountState.message!=null) {
              Modals.showToast(accountState.message!,
                  messageType: MessageType.error);
            }
          }
        },
        builder: (context, accountState)
        => BlocConsumer<LocationCubit, LocationStates>(
            listener: (_, locationState) {},
          builder: (context, locationState) {
            return Container(
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RawAutocomplete(
                    displayStringForOption: (LocationPrediction option) =>
                    option.description,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<LocationPrediction>.empty();
                      } else if (locationState is LocationsLoaded) {
                        return locationState.locations;
                      } else {
                        return _locationCubit.locations;
                      }
                    },
                    onSelected: (LocationPrediction option)
                    => _locationCubit.locationFromAddress(option.description),
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextEditView(
                        controller: textEditingController,
                        focusNode: focusNode,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        hintText: 'Search for a different location',
                        borderWidth: 0,
                        prefixIcon: const Icon(Icons.search, size: 32),
                        onChanged: (value) => {
                          if (value.isNotEmpty)
                            {_locationCubit.fetchSuggestions(value)}
                        },
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        void Function(LocationPrediction) onSelected,
                        Iterable<LocationPrediction> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                            elevation: 4.0,
                            child: SizedBox(
                              height: 200,
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8.0),
                                itemCount: options.length,
                                separatorBuilder: (context, i) {
                                  return const Divider();
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  final option = options.elementAt(index);
                                  return InkWell(
                                      onTap: () => onSelected(option),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined),
                                            const SizedBox(width: 5.0),
                                            Expanded(
                                                child: Text(option.description)),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            )),
                      );
                    },
                  ),
                  const SizedBox(height: 18.0),
                  const Text('Current Location',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.my_location_rounded),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(_locationCubit.userViewModel.address,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25.0),
                  ButtonView(
                      onPressed: () =>
                      widget.onPressed
                          ?? context.read<AccountCubit>().updateUser(
                        location: _locationCubit.userViewModel.address,
                        latitude: '${_locationCubit.userViewModel.latitude}',
                        longitude: '${_locationCubit.userViewModel.longitude}'
                      ),
                      processing: accountState is AccountProcessing,
                      child: const Text('Confirm Location',
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)))
                ],
              ),
            );
          }
        )
    );
  }
}
