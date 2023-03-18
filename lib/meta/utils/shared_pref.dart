import 'package:shared_preferences/shared_preferences.dart';

/// SharedPref is a singleton class that provides access to the SharedPreferences instance.
/// It is used to store and retrieve data in the device's local storage.
class SharedPref {

  SharedPref._();
  static final SharedPref _instance = SharedPref._();
  factory SharedPref() => _instance;
  SharedPreferences? _pref;
  SharedPreferences get pref => _pref!;

  static const String languageCode = 'languageCode';
  static const String countryCode = 'countryCode';

  /// init() must be called before using the SharedPref class.
  static Future<void> init() async {
    _instance._pref = await SharedPreferences.getInstance();
  }

}