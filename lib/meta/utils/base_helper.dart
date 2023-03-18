import 'dart:core';
import 'package:ryalize_assessment/app/constants/assets.constant.dart';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phone_number/phone_number.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_theme.dart';

/// Base Helper Class
/// Contains all the helper methods
/// that are used throughout the app
/// to avoid code duplication and to make the code more readable and maintainable
class BaseHelper {
  /// show snack-bar
  /// [message] is the message to be shown
  /// [isDismissible] is the boolean value to determine if the snackbar is dismissible or not
  /// [duration] is the duration for which the snackbar is shown
  /// [backgroundColor] is the background color of the snackbar
  /// [textColor] is the text color of the snackbar
  static void showSnackBar(String message) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          message: message,
          isDismissible: true,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  /// open dial pad
  /// [phoneNumber] is the phone number to be called
  static void openDialPad(String phoneNumber) async {
    if (!await launch("tel:$phoneNumber")) {
      throw 'Could not launch $phoneNumber';
    }
  }

  /// launch url
  /// [url] is the url to be launched
  static void launchUrl(String url) async {
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }

  // CACHE NETWORK WIDGET HERE
  /// [url] is the url of the image
  /// [fit] is the BoxFit of the image
  /// [height] is the height of the image
  /// returns a [CachedNetworkImage]
  static Widget loadNetworkImage(String url, BoxFit fit, {double? height}) {
    return CachedNetworkImage(
      imageUrl: url,
      fadeInCurve: Curves.easeIn,
      fit: fit,
      height: height,
      fadeInDuration: const Duration(milliseconds: 500),
      placeholder: (st_, str) {
        return Container(
          height: 0.5.sh,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.logo), fit: BoxFit.contain),
          ),
        );
      },
      errorWidget: (context, url, error) => const Center(
          child: Icon(
        Icons.error,
        color: Colors.black,
      )),
    );
  }

  /// [url] is the url of the image
  /// [fit] is the BoxFit of the image
  /// [height] is the height of the image
  /// [width] is the width of the image
  /// returns a [CachedNetworkImage]
  static Widget loadProfilePictureOnPost(String url,
      {double? height = 36.0, double? width = 36.0}) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      fadeInDuration: const Duration(milliseconds: 500),
      fadeInCurve: Curves.easeIn,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => const Center(
          child: Icon(
        Icons.error,
        color: Colors.black,
      )),
    );
  }

  /// [url] is the url of the image
  /// returns a [CachedNetworkImageProvider]
  static CachedNetworkImageProvider loadNetworkImageObject(
    String url,
  ) {
    return CachedNetworkImageProvider(url, errorListener: () {
      debugPrint("ERROR LOADING IMAGE");
    });
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat.yMd().format(dateTime);
  }

  static String formatDateWithMonth(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }

  static String appFormatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  /// time ago from now
  /// [date] is the date from which the time ago is to be calculated
  static String getTimeAgo(DateTime date) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);
    int days = difference.inDays;
    int hours = difference.inHours;
    int minutes = difference.inMinutes;
    int seconds = difference.inSeconds;
    if (days > 6) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (days > 0) {
      return '$days days ago';
    } else if (hours > 0) {
      return '$hours hours ago';
    } else if (minutes > 0) {
      return '$minutes minutes ago';
    } else if (seconds > 0) {
      return '$seconds seconds ago';
    } else {
      return 'Just now';
    }
  }

  /// validate phone number
  /// [number] is the phone number to be validated
  /// [code] is the country code of the phone number
  /// [name] is the name of the country
  /// [prefix] is the prefix of the country
  static Future<bool> isPhoneNoValid(
      String number, String code, String name, String prefix) async {
    PhoneNumberUtil plugin = PhoneNumberUtil();
    String springFieldUSASimpleNoRegion = number;
    RegionInfo region = RegionInfo(
        code: code, name: 'United States', prefix: int.parse(prefix));
    bool isValid =
        await plugin.validate(springFieldUSASimpleNoRegion, region.code);
    return isValid;
  }

  static RegExp numberFormatterRegEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  static String Function(Match) mathFunc = (Match match) => '${match[1]},';

  static String formatNumber({required String number}) {
    return number.replaceAllMapped(numberFormatterRegEx, mathFunc);
  }
}
