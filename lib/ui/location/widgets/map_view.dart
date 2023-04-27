import 'dart:async';

import 'package:chow/handlers/location_handler.dart';
import 'package:chow/model/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../blocs/location/location.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _mapController = Completer();

  late CameraPosition _userPosition;

  late LocationCubit _locationCubit;

  late UserViewModel _userViewModel;

  final double zoom = 14.4746; //19.151926040649414;

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  @override
  void initState() {
    // TODO: implement initState
    _locationCubit = context.read<LocationCubit>();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    _initPosition();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _initPosition() {
    final longitude = _userViewModel.longitude;
    final latitude = _userViewModel.latitude;

    _userPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: zoom);
    _locationCubit.addressFromLocation(latitude, longitude);
  }

  _afterLayout(_) async {
    final currentPosition = await LocationHandler.determinePosition();
    _resetPosition(currentPosition.latitude, currentPosition.longitude);
  }

  void _resetPosition(double latitude, double longitude,
      {bool notify = true}) async {
    final GoogleMapController controller = await _mapController.future;
    _userPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: zoom);
    controller.animateCamera(CameraUpdate.newCameraPosition(_userPosition));
    if (notify) _locationCubit.addressFromLocation(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationStates>(
      builder: (context, state) {
        return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _userPosition,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false);
      },
      listener: (context, state) {
        if (state is SearchLocationSelected) {
          debugPrint('Latitiude ${state.location.latitude},'
              ' Longitude ${state.location.longitude}');
          _resetPosition(state.location.latitude, state.location.longitude,
              notify: false);
        }
      },
    );
  }
}
