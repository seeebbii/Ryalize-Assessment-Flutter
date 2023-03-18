import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/core/api/api_paths.dart';
import 'package:ryalize_assessment/core/api/api_service.dart';
import 'package:ryalize_assessment/core/models/authentication/authentication.model.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/meta/utils/base_helper.dart';
import 'package:ryalize_assessment/meta/utils/hive_database.dart';

/// This is the service class for authentication
/// It contains all the methods related to authentication
/// It is used by the authentication notifier
class AuthenticationService {

  /// This method is used to fetch the user profile
  /// It returns the user profile as an AuthenticationModel
  static Future<AuthenticationModel> fetchProfile() async {
    AuthenticationModel authModel = AuthenticationModel();

    var response = await ApiService.request(
      ApiPaths.profile,
      method: RequestMethod.GET,
    );
    // log("$response");
    if (response != null) {
      authModel = AuthenticationModel.fromJson(response);
      log("User Profile: ${authModel.toJson()}");
    }
    return authModel;
  }

  /// This method is used to login the user
  /// [phone] is the phone number of the user
  /// [password] is the password of the user
  /// [rememberMe] is a boolean value to remember the user
  /// [context] is the context of the current screen
  static Future<void> login(
      {required String phone,
        required String password,
        required bool rememberMe,
        required BuildContext context}) async {
    // String fcmToken = await firebaseToken();

    var data = {
      "phone": phone,
      "password": password,
    };

    var response = await ApiService.request(ApiPaths.login,
        method: RequestMethod.POST, data: data);

    log("Login api response: $response");
    if (response != null) {
      if (response['status'] == 200) {
        // Logged in
        HiveDatabase.storeValue(HiveDatabase.loginCheck, rememberMe);
        HiveDatabase.storeValue(
            HiveDatabase.authToken, "Bearer ${response['token']}");

        await fetchProfile();
        // Navigate to root screen
        navigationController.getOffAll(RouteGenerator.rootTodoScreen);
        BaseHelper.showSnackBar(response['message']);
      } else if (response['status'] == 400) {
        // Account Not Verified
        BaseHelper.showSnackBar(response['message']);
        navigationController.navigateToNamedWithArg(
            RouteGenerator.otpScreen, {'isVerification': true});
      } else {
        // Invalid credentials
        BaseHelper.showSnackBar(response['message']);
      }
    }
  }

  /// This method is used to register the user
  /// [fullName] is the full name of the user
  /// [email] is the email of the user
  /// [password] is the password of the user
  /// [phone] is the phone number of the user
  /// [countryCode] is the country code of the user
  /// [context] is the context of the current screen
  static Future<void> register(
      {required String fullName,
      required String email,
      required String password,
      required String phone,
      required String countryCode,}) async {
    var data = {
      "name": fullName,
      "email": email,
      "password": password,
      "country_code": countryCode,
      "phone": phone,
      "verified": false,
    };

    var response = await ApiService.request(ApiPaths.register,
        method: RequestMethod.POST, data: data);

    log('Register api response: $response');

    if (response != null) {
      if (response['status'] == 201) {
        // Registration successful
        BaseHelper.showSnackBar(response['message']);
        navigationController.navigateToNamedWithArg(
            RouteGenerator.otpScreen, {'isVerification': true});
      } else if (response['status'] == 401) {
        // Account not verified
        navigationController.navigateToNamedWithArg(
            RouteGenerator.otpScreen, {'isVerification': true});
        BaseHelper.showSnackBar(response['message']);
      } else {
        // Registration failed
        BaseHelper.showSnackBar(response['message']);
      }
    }
  }

  /// This method is used to send the otp to the user
  /// [phone] is the phone number of the user
  static Future<void> sendOtp(String phone) async {
    var data = {"complete_phone": phone};

    var response = await ApiService.request(ApiPaths.resendOtp,
        method: RequestMethod.POST, data: data);

    if (response != null) {
      navigationController.navigateToNamedWithArg(
          RouteGenerator.otpScreen, {'isVerification': false});
      BaseHelper.showSnackBar('${response['message']}');
    }
  }

  /// This method is used to verify the otp sent to the user
  /// [completePhone] is the complete phone number of the user
  /// [code] is the otp code sent to the user
  /// [verification] is a boolean value to check if the user is verifying the account or changing the password
  static Future<void> verifyOtp(
      String completePhone, String code, bool verification) async {
    var data = {
      "complete_phone": completePhone,
      "code": code,
    };

    var response = await ApiService.request(ApiPaths.verifyOtp,
        method: RequestMethod.POST, data: data);

    if (response != null) {
      if (response['success'] == true) {
        if (verification == false) {
          navigationController.getOff(RouteGenerator.changePassword);
          return;
        }
        navigationController.getOffAll(RouteGenerator.loginScreen);
        BaseHelper.showSnackBar(response['message']);
      } else {
        BaseHelper.showSnackBar(response['message']);
      }
    }
  }

  /// This method is used to change the password of the user
  /// [phone] is the phone number of the user
  /// [password] is the new password of the user
  /// [forgot] is a boolean value to check if the user is changing the password from the forgot password screen
  static Future<void> changePassword(
      String phone, String password, bool forgot) async {
    var data = {"complete_phone": phone, "password": password};

    var response = await ApiService.request(ApiPaths.changePassword,
        method: RequestMethod.POST, data: data);

    if (response != null) {
      if (response['success'] == true) {
        if (forgot) {
          navigationController.getOffAll(RouteGenerator.loginScreen);
        } else {
          navigationController.goBack();
        }
        BaseHelper.showSnackBar('${response['message']}');
      } else {
        BaseHelper.showSnackBar('${response['message']}');
      }
    }
  }

  /// This method is used to logout the user
  /// [context] is the context of the current screen
  static Future<void> logout(BuildContext context) async {
    HiveDatabase.storeValue(HiveDatabase.authToken, null);
    HiveDatabase.storeValue(HiveDatabase.loginCheck, false);
    navigationController.getOffAll(RouteGenerator.loginScreen);
  }
}
