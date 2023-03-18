import 'package:ryalize_assessment/core/notifiers/connection.notifier.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/meta/utils/app_theme.dart';
import 'package:ryalize_assessment/meta/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/providers/multi_providers.dart';
import 'core/controller/navigation_controller.dart';
import 'meta/utils/hive_database.dart';

void main() async {
  /// Ensures that the framework is fully initialized and ready to run.
  WidgetsFlutterBinding.ensureInitialized();
  /// Dependency injection for GetX navigation Controller
  Get.put(NavigationController());
  /// Shared preference Singleton Class
  await SharedPref.init();
  /// Hive Database Singleton Class
  await HiveDatabase.init();
  /// Run the app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // Removing the token from Hive Database if the user is not logged in
    if(HiveDatabase.getValue(HiveDatabase.loginCheck) != true){
      HiveDatabase.storeValue(HiveDatabase.authToken, "null");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: ScreenUtilInit(
          builder: (_, w) => MultiProviders(
            GetMaterialApp(
              onGenerateRoute: RouteGenerator.onGeneratedRoutes,
              title: "Ryalize Assessment",
              debugShowCheckedModeBanner: false,
              initialRoute: RouteGenerator.splashScreen,
              theme: AppTheme.lightTheme,
              builder: EasyLoading.init(),
            ),
          )
      ),
    );
  }
}


