import 'dart:convert';
import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';

/// This class is used to store data in Hive Database
/// Singleton class
class HiveDatabase{

  /// Hive Database Keys
  static String loginCheck = 'loginCheck';
  static String authToken = 'authToken';
  static String userId = 'userId';
  static String loginPlatform = 'loginPlatform';
  static String feedBox = 'feedBox';
  static String appBox = 'app';
  static String currentLang = 'currentLang';

  HiveDatabase._();
  static final HiveDatabase _instance = HiveDatabase._();
  factory HiveDatabase() => _instance;

  /// Hive Database Boxes
  Box? _box;
  Box get box => _box!;

  /// This method is used to initialize the Hive Database
  static Future<void> init() async {
    await Hive.initFlutter();
    _instance._box = await Hive.openBox(appBox);
    log('AppBox Open: ${_instance._box?.isOpen}');
  }

  /// This method is used to store a value in the Hive Database
  static void storeValue(String key, dynamic value) async {
    _instance._box!.put(key, value);
  }

  /// This method is used to get a value from the Hive Database
  static dynamic getValue(String key){
    return _instance._box?.get(key);
  }


}