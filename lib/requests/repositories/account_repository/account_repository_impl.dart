

import 'dart:io';

import '../../../model/data_models/image.dart';
import '../../../model/data_models/user/user.dart';
import '../../../model/data_models/user/user_data.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository{
  @override
  Future<UserData> createPin({required String pin, required String userId}) async{
    final map=await Requests().get(AppStrings.createPinUrl(userId: userId, pin: pin));
    return UserData.fromMap(map);
  }

  @override
  Future<UserData> loginUser({required String pin, required String phoneNumber}) async{
    final map= await Requests().post(AppStrings.loginUrl,
        body: {
          "phone_number": phoneNumber,
          "pin": pin
        });
    return UserData.fromMap(map);
  }

  @override
  Future<User> registerUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
    required String email}) async{
    final map= await Requests().post(AppStrings.registerUrl,
        body: {
          "first_name": firstName,
          "last_name": lastName,
          "phone_number": phoneNumber,
          "country_code": countryCode,
          "email": email
        });
    return User.fromMap(map);
  }

  @override
  Future<User> updateUser({String? firstName,
    String? lastName, String? timezone,
    String? location, String? latitude,
    String? longitude, String? email}) async{
    final map= await Requests().put(AppStrings.updateUserUrl,
        body: {
          if(firstName!=null)"first_name": firstName,
          if(lastName!=null)"last_name": lastName,
          if(timezone!=null)"timezone": timezone,
          if(location!=null)"location": location,
          if(latitude!=null)"latitude": latitude,
          if(longitude!=null)"longitude": longitude,
          if(email!=null)"email": email,
        });
    return User.fromMap(map);
  }

  @override
  Future<User> fetchUser() async{
    final map=await Requests().get(AppStrings.fetchUserUrl);
    return User.fromMap(map);
  }

  @override
  Future<String> changeAccountPin({required String oldPin, required String newPin}) async{
    final map= await Requests().put(AppStrings.changePinUrl,
        body: {
          "old_pin": oldPin,
          "new_pin": newPin
        });
    return map['message'];
  }

  @override
  Future<Image> uploadAccountImage(File image) async{
    final map=await Requests().post(AppStrings.uploadAccountImageUrl,
        files: {"picture": image});
    return Image.fromMap(map);
  }

  @override
  Future<User> verifyOTP(String otp) async{
    final map= await Requests().post(AppStrings.verifyOTPUrl,
        body: {
          "otp": otp
        });
    return User.fromMap(map);
  }

  @override
  Future<String> resendOTP(String phone) async{
    final map= await Requests().get(AppStrings.resendOTPUrl(phone));
    return map['message'];
  }

  @override
  Future<User> submitKYC({required String firstName,
    required String lastName, required String dob,
    required String phoneNumber, required String nationality,
    required String idType, required String idNumber,
    required File idFront, required File idBack,
    required File selfie}) async{
    final map=await Requests().post(AppStrings.submitKYCUrl,
        body: {
          "first_name": firstName,
          "last_name": lastName,
          "date_of_birth": dob,
          "phone_number": phoneNumber,
          "nationality": nationality,
          "id_type": idType,
          "id_number": idNumber
        },
        files: {
          "id_front": idFront,
          "id_back": idBack,
          "selfie": selfie
        }
    );
    return User.fromMap(map);
  }

  @override
  Future<String> requestPinReset(String phone) async{
    final map= await Requests().post(AppStrings.requestPinResetUrl,
        body: {
          "phone_number": phone
        });
    return map['message'];
  }

  @override
  Future<String> verifyPinRecoveryOTP(String otp) async{
    return 'Success';
  }

  @override
  Future<String> resetPin({
    required String otp,
    required String newPin}) async {
    final map= await Requests().post(AppStrings.confirmPinResetUrl,
        body: {
          "new_pin": newPin,
          "otp": otp
        });
    return map['message'];
  }

}