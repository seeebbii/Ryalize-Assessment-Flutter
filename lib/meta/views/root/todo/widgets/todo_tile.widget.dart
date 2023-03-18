import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/core/extensions/context_extension.dart';
import 'package:ryalize_assessment/core/models/todo/todo_data.model.dart';
import 'package:ryalize_assessment/core/notifiers/todo.notifier.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/meta/utils/app_theme.dart';

class TodoTileWidget extends StatelessWidget {
  final TodoData todo;
  final int index;

  const TodoTileWidget({Key? key, required this.todo, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoNotifier todoNotifier = context.watch<TodoNotifier>();
    return ListTile(
      onTap: () {
        log("${todo.sId}");
        // navigate to create todo screen
        navigationController.navigateToNamedWithArg(
            RouteGenerator.createTodoScreen,
            {'newTodo': false, 'todo': todo, 'index': index});
      },
      minLeadingWidth: 0,
      leading: Checkbox(
        value: todo.completed,
        onChanged: (val){}
      ),
      title: Text(
        "${todo.title}",
        style: context.displaySmall,
      ),
      trailing: IconButton(
        onPressed: () async {
          EasyLoading.show();
          await todoNotifier.deleteTodo(id: todo.sId!, index: index);
          EasyLoading.dismiss();
        },
        icon: const Icon(
          CupertinoIcons.delete,
          color: AppTheme.red,
        ),
        splashRadius: 12,
      ),
    );
  }
}
