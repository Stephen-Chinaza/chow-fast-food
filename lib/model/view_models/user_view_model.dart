import 'package:chow/handlers/secure_handler.dart';
import 'package:chow/model/data_models/user/user_data.dart';
import 'package:chow/res/enum.dart';
import 'package:flutter/material.dart';

import '../../handlers/location_handler.dart';
import '../data_models/user/user.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  UserViewModel() {
    _intData();
  }

  UserData? _userData;

  User? _user;

  late String _address = '';

  late double _latitude = 6.424676142638944;

  late double _longitude = 7.496529864154287;

  double _walletBalance =0;

  Future<void> _intData() async {
    /// Get user cached data
    _userData = await StorageHandler.getUserDetails();
    debugPrint(await StorageHandler.getAccessToken());

    /// Get current location
    final position = await LocationHandler.determinePosition();
    await setLongLat(
        latitude: position.latitude, longitude: position.longitude);
  }

  Future<void> setAddress(String address) async {
    _address = address;
    setViewState(ViewState.success);
  }

  String get address => _address;

  Future<void> setLongLat(
      {required double latitude, required double longitude}) async {
    _longitude = longitude;
    _latitude = latitude;
    debugPrint('Longitude: $longitude  Latitude: $latitude');
    setViewState(ViewState.success);
  }

  double get longitude => _longitude;

  double get latitude => _latitude;

  Future<void> setUser(UserData userData) async {
    _userData = userData;
    await StorageHandler.saveUserDetails(_userData);
    setViewState(ViewState.success);
  }

  Future<void> updateUser(User user) async {
    _user = user;
    if (_userData != null) {
      _userData = _userData!.copyWith(user: user);
      await StorageHandler.saveUserDetails(_userData);
    }
    setViewState(ViewState.success);
  }

  Future<void> deleteUser() async {
    _userData = null;
    //await StorageHandler.clearUserDetails();
    await StorageHandler.clearCache();
    setViewState(ViewState.success);
  }

  Future<void> setWalletBalance(double balance) async {
   _walletBalance =balance;
    setViewState(ViewState.success);
  }

  UserData? get userData => _userData;

  User? get user => _userData?.user ?? _user;

  double get walletBalance => _walletBalance;

}
