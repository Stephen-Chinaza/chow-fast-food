
import 'dart:io';

import 'package:chow/model/data_models/user/user_data.dart';

import '../../../model/data_models/image.dart';
import '../../../model/data_models/user/user.dart';

abstract class AccountRepository {
  Future<User> registerUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
    required String email});
  Future<UserData> loginUser({
    required String pin,
    required String phoneNumber});
  Future<UserData> createPin({
    required String pin,
    required String userId});
  Future<User> updateUser({
    String? firstName,
    String? lastName,
    String? timezone,
    String? location,
    String? latitude,
    String? longitude,
    String? email});
  Future<User> fetchUser();
  Future<String> changeAccountPin({
    required String oldPin,
    required String newPin});
  Future<Image> uploadAccountImage(File image);
  Future<User> verifyOTP(String otp);
  Future<String> resendOTP(String phone);
  Future<User> submitKYC({
    required String firstName,
    required String lastName,
    required String dob,
    required String phoneNumber,
    required String nationality,
    required String idType,
    required String idNumber,
    required File idFront,
    required File idBack,
    required File selfie});
  Future<String> requestPinReset(String phone);
  Future<String> verifyPinRecoveryOTP(String otp);
  Future<String> resetPin({
    required String otp,
    required String newPin});
}