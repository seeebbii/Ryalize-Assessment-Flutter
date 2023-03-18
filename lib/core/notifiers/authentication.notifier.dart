import 'dart:developer';
import 'dart:io';

import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/core/api/api_paths.dart';
import 'package:ryalize_assessment/core/api/api_service.dart';
import 'package:ryalize_assessment/core/models/authentication/auth_data.model.dart';
import 'package:ryalize_assessment/core/models/authentication/authentication.model.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/core/services/authentication.service.dart';
import 'package:ryalize_assessment/meta/utils/base_helper.dart';
import 'package:ryalize_assessment/meta/utils/hive_database.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticationNotifier extends ChangeNotifier {
  AuthenticationModel authModel = AuthenticationModel();

  Future<void> fetchProfile() async {
    authModel = await AuthenticationService.fetchProfile();
    notifyListeners();
  }

  Future<void> login(
      {required String phone,
      required String password,
      required bool rememberMe,
      required BuildContext context}) async {

    await AuthenticationService.login(
        phone: phone,
        password: password,
        rememberMe: rememberMe,
        context: context);
  }

  Future<void> register(
      {required String fullName,
      required String email,
      required String password,
      required String phone,
      required String countryCode,
      required bool adminRights}) async {

    await AuthenticationService.register(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
        countryCode: countryCode,);
  }

  Future<void> sendOtp(String phone) async {
    await AuthenticationService.sendOtp(phone);
  }

  Future<void> verifyOtp(
      String completePhone, String code, bool verification) async {
    await AuthenticationService.verifyOtp(completePhone, code, verification);
  }

  Future<void> changePassword(
      String phone, String password, bool forgot) async {
    await AuthenticationService.changePassword(phone, password, forgot);
  }

  Future<void> logout(BuildContext context) async {
    AuthenticationService.logout(context);
  }
}
