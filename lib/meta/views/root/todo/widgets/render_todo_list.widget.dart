import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ryalize_assessment/core/models/todo/todo_data.model.dart';
import 'package:ryalize_assessment/core/notifiers/todo.notifier.dart';
import 'package:ryalize_assessment/meta/utils/app_theme.dart';
import 'package:ryalize_assessment/meta/views/root/todo/widgets/todo_tile.widget.dart';

class RenderTodoListWidget extends StatelessWidget {
  const RenderTodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoNotifier todoNotifier = context.watch<TodoNotifier>();
    return RefreshIndicator(
      color: AppTheme.primaryColor,
      onRefresh: () async {
        await todoNotifier.fetchTodos();
      },
      child: ListView.builder(
          itemCount: todoNotifier.todoModel.todoData?.length,
          itemBuilder: (_, index) {
            TodoData todo = todoNotifier.todoModel.todoData![index];
            return TodoTileWidget(todo: todo, index: index,);
          }),
    );
  }
}
