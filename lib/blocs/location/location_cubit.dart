import 'package:chow/handlers/location_handler.dart';
import 'package:chow/model/view_models/user_view_model.dart';
import 'package:chow/requests/repositories/location_repository/location_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/data_models/location/location_prediction.dart';
import '../../utils/exceptions.dart';
import 'location_states.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit({required this.locationRepository,
    required this.userViewModel})
      : super(const InitialState());

  final LocationRepository? locationRepository;
  final UserViewModel userViewModel;

  List<LocationPrediction> locations = [];

  Future<void> fetchSuggestions(String query) async {

    try{
      emit(LoadingLocation());

      locations=await locationRepository!.fetchSuggestions(query);

      emit(LocationsLoaded(locations));

    } on ApiException catch(e) {
      emit(LocationApiErr(e.message));
    }
    catch(e){
      if(e is NetworkException
          || e is BadRequestException || e is UnauthorisedException
          || e is FileNotFoundException || e is AlreadyRegisteredException){
        emit(LocationNetworkErr(e.toString()));
      }else{
        rethrow;
      }
    }
  }

  Future<void> locationFromAddress(String address) async {
    final location =await LocationHandler.getUserLocationFromAddress(address);
    await userViewModel.setLongLat(latitude: location.latitude,
        longitude: location.latitude);
    await userViewModel.setAddress(address);
    emit(SearchLocationSelected(location));
  }

  Future<void> addressFromLocation(double latitude, double longitude) async {
    final address=await LocationHandler.getUserAddressFromLocation(
        latitude, longitude);
    await userViewModel.setLongLat(latitude: latitude,
        longitude: latitude);
    await userViewModel.setAddress(address);
    emit(LocationDetected(address));
  }

}
