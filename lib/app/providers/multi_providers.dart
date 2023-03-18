import 'package:ryalize_assessment/core/notifiers/authentication.notifier.dart';
import 'package:ryalize_assessment/core/notifiers/connection.notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryalize_assessment/core/notifiers/todo.notifier.dart';
import 'package:ryalize_assessment/core/view_models/authentication_VM.dart';
import 'package:ryalize_assessment/core/view_models/todo_VM.dart';

/// This class is used to provide all the notifiers to the app
class MultiProviders extends StatelessWidget {
  const MultiProviders(this.child, {Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<ConnectionNotifier>(
          create: (BuildContext context) => ConnectionNotifier(),
        ),

        ChangeNotifierProvider<AuthenticationScreenVM>(
          create: (BuildContext context) => AuthenticationScreenVM(),
        ),

        ChangeNotifierProvider<AuthenticationNotifier>(
          create: (BuildContext context) => AuthenticationNotifier(),
        ),

        ChangeNotifierProvider<TodoNotifier>(
          create: (BuildContext context) => TodoNotifier(),
        ),

        ChangeNotifierProvider<TodoVM>(
          create: (BuildContext context) => TodoVM(),
        ),

      ],
      child: child,
    );
  }
}
