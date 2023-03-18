import 'package:ryalize_assessment/meta/views/authentication/change_password.screen.dart';
import 'package:ryalize_assessment/meta/views/authentication/forgot_password.screen.dart';
import 'package:ryalize_assessment/meta/views/authentication/login.screen.dart';
import 'package:ryalize_assessment/meta/views/authentication/otp.screen.dart';
import 'package:ryalize_assessment/meta/views/authentication/signup.screen.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ryalize_assessment/meta/views/root/todo/create_todo.screen.dart';
import 'package:ryalize_assessment/meta/views/root/todo/root_todo.screen.dart';
import 'package:ryalize_assessment/meta/views/splash/splash_screen.dart';

/// ROUTE GENERATOR
/// THIS CLASS IS RESPONSIBLE FOR HANDLING ALL ROUTES
/// AND NAVIGATION
/// THIS CLASS IS USED IN THE [MaterialApp] AS THE [onGenerateRoute] PROPERTY
class RouteGenerator {
  // static String lastRoute = '';

  /// WELCOME ROUTE
  static const String splashScreen = '/splash-screen';

  /// AUTH ROUTE
  static const String loginScreen = '/login-screen';
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String otpScreen = '/otp-screen';
  static const String resetPasswordScreen = '/reset-password-screen';
  static const String changePassword = '/change-password-screen';
  static const String signupScreen = '/signup-screen';

  /// HOME ROUTES
  static const String rootTodoScreen = '/root-todo-screen';
  static const String createTodoScreen = '/create-todo-screen';

  /// FUNCTION THAT HANDLES ROUTING
  /// THIS FUNCTION IS CALLED WHEN [Navigator.pushNamed] IS CALLED
  /// AND THE [onGenerateRoute] PROPERTY IS SET TO THIS FUNCTION
  /// [settings] IS THE [RouteSettings] PASSED TO THE [Navigator.pushNamed] FUNCTION
  /// [settings] IS USED TO GET THE ROUTE NAME
  /// [settings] IS ALSO USED TO GET THE ARGUMENTS PASSED TO THE ROUTE
  /// [settings] IS PASSED TO THE [MaterialPageRoute] AS THE [settings] PROPERTY
  /// [MaterialPageRoute] IS THE DEFAULT ROUTE USED BY THE [Navigator]
  /// [MaterialPageRoute] IS USED TO NAVIGATE TO THE ROUTE
  static Route<dynamic>? onGeneratedRoutes(RouteSettings settings) {
    Map<String, dynamic> args = {};

    /// GETTING ARGUMENTS IF PASSED
    /// [settings.arguments] IS THE ARGUMENT PASSED TO THE ROUTE
    if (settings.arguments != null) {
      args = settings.arguments as Map<String, dynamic>;
      debugPrint("${settings.arguments}");
    }
    debugPrint(settings.name);

    /// SWITCH CASE TO HANDLE ROUTING
    /// [settings.name] IS THE ROUTE NAME
    switch (settings.name) {
      case splashScreen:
        return _getPageRoute(const SplashScreen());

      case loginScreen:
        return _getPageRoute(const LoginScreen());

      case signupScreen:
        return _getPageRoute(const SignupScreen());

      case forgotPasswordScreen:
        return _getPageRoute(const ForgotPasswordScreen());

      case otpScreen:
        return _getPageRoute(OtpScreen(
          isVerification: args['isVerification'],
        ));

      case changePassword:
        return _getPageRoute(const ChangePasswordScreen());

      case rootTodoScreen:
        return _getPageRoute(const RootTodoScreen());

      case createTodoScreen:
        return _getPageRoute(CreateTodoScreen(
          newTodo: args['newTodo'],
          todo: args['todo'],
          index: args['index'],
        ));

      default:
        return null;
    }
  }

  /// FUNCTION THAT HANDLES NAVIGATION
  /// THIS FUNCTION IS CALLED WHEN [Navigator.pushNamed] IS CALLED
  /// AND THE [onGenerateRoute] PROPERTY IS SET TO THIS FUNCTION
  static PageRoute _getPageRoute(
    Widget child,
  ) {
    // return MaterialPageRoute(builder: (ctx) => child);
    return PageTransition(child: child, type: PageTransitionType.fade);
  }

  // 404 PAGE
  static PageRoute _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('404'),
        ),
        body: const Center(
          child: Text('ERROR 404: Not Found'),
        ),
      );
    });
  }
}
