import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// navigation controller for navigation between screens
class NavigationController extends GetxController {
  static NavigationController instance = Get.find();

  /// navigate to named route
  /// [routeName] is the name of the route
  Future<dynamic>? navigateToNamed(String routeName) {
    return Get.toNamed(routeName);
  }

  /// navigate to named route with arguments
  /// [routeName] is the name of the route
  /// [arg] is the arguments to pass to the route
  Future<dynamic>? navigateToNamedWithArg(String routeName, dynamic arg) {
    return Get.toNamed(routeName, arguments: arg);
  }

  /// navigate to named route and remove all previous routes
  /// [routeName] is the name of the route
  Future<dynamic>? getOffAll(String routeName) {
    return Get.offAllNamed(routeName);
  }

  /// navigate to named route with arguments and remove all previous routes
  /// [routeName] is the name of the route
  /// [arg] is the arguments to pass to the route
  Future<dynamic>? getOffAllWithArguments(String routeName, dynamic arg) {
    return Get.offAllNamed(routeName, arguments: arg);
  }

  /// navigate to named route and remove previous route
  /// [routeName] is the name of the route
  Future<dynamic>? getOff(String routeName) {
    return Get.offNamed(routeName);
  }

  /// navigate to named route with arguments and remove previous route
  /// [routeName] is the name of the route
  /// [arg] is the arguments to pass to the route
  Future<dynamic>? getOffWithArguments(String routeName, dynamic arg) {
    return Get.offNamed(routeName, arguments: arg);
  }

  goBack() => Get.back();
}
