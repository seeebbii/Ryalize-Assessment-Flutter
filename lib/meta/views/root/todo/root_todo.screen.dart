import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/components/widgets/app_appbar.dart';
import 'package:ryalize_assessment/components/widgets/app_circular_indicator_widget.dart';
import 'package:ryalize_assessment/core/extensions/context_extension.dart';
import 'package:ryalize_assessment/core/models/todo/todo.model.dart';
import 'package:ryalize_assessment/core/notifiers/authentication.notifier.dart';
import 'package:ryalize_assessment/core/notifiers/todo.notifier.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/core/view_models/todo_VM.dart';

import 'widgets/render_todo_list.widget.dart';

class RootTodoScreen extends StatefulWidget {
  const RootTodoScreen({Key? key}) : super(key: key);

  @override
  State<RootTodoScreen> createState() => _RootTodoScreenState();
}

class _RootTodoScreenState extends State<RootTodoScreen> {

  Future<TodoModel>? _fetchTodos;

  @override
  void initState() {
    _fetchTodos = context.read<TodoNotifier>().fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationNotifier authNotifier =
        context.watch<AuthenticationNotifier>();
    TodoNotifier todoNotifier = context.watch<TodoNotifier>();

    return Scaffold(
      appBar: AppAppbar(
        title: "Welcome, ${authNotifier.authModel.user?.name ?? ""}",
      ),
      body: FutureBuilder<TodoModel>(
          future: _fetchTodos,
          builder: (_, AsyncSnapshot<TodoModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: AppCircularIndicatorWidget(),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError) {
              return Center(
                child: Text(
                  "Error occurred while fetching",
                  style: context.displaySmall,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                todoNotifier.todoModel.todoData == null &&
                todoNotifier.todoModel.todoData!.isEmpty) {
              return Center(
                child: Text(
                  "No new Todo",
                  style: context.displaySmall,
                ),
              );
            } else {
              return const RenderTodoListWidget();
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<TodoVM>().clear();
            navigationController.navigateToNamedWithArg(RouteGenerator.createTodoScreen, {
              'newTodo': true,
            });
          },
          child: const Icon(CupertinoIcons.add)),
    );
  }
}
