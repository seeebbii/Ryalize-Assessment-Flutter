import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ryalize_assessment/app/constants/assets.constant.dart';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/core/extensions/context_extension.dart';
import 'package:ryalize_assessment/core/notifiers/authentication.notifier.dart';
import 'package:ryalize_assessment/core/notifiers/connection.notifier.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/meta/utils/hive_database.dart';

import '../../../core/models/authentication/auth_data.model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    super.initState();
    AuthenticationNotifier authNotifier = context.read<AuthenticationNotifier>();
    Provider.of<ConnectionNotifier>(context, listen: false).initConnectivity();

    Future.delayed(const Duration(seconds: 3), () async {
      // LOGGED IN ? HOME PAGE : AUTH SCREEN
      if (HiveDatabase.getValue(HiveDatabase.loginCheck) == true) {
        /// Fetching user's profile if the user is already logged in
        await authNotifier.fetchProfile();
        navigationController.getOffAll(RouteGenerator.rootTodoScreen);
      } else {
        navigationController.getOffAll(RouteGenerator.loginScreen);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Todo App", style: context.displayLarge)),
    );
  }
}
