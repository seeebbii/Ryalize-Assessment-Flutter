import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ryalize_assessment/components/widgets/app_appbar.dart';
import 'package:ryalize_assessment/components/widgets/app_elevated_button.dart';
import 'package:ryalize_assessment/components/widgets/app_simple_text_field.dart';
import 'package:ryalize_assessment/core/extensions/context_extension.dart';
import 'package:ryalize_assessment/core/models/todo/todo_data.model.dart';
import 'package:ryalize_assessment/core/notifiers/todo.notifier.dart';
import 'package:ryalize_assessment/core/view_models/todo_VM.dart';
import 'package:ryalize_assessment/meta/utils/app_theme.dart';

class CreateTodoScreen extends StatefulWidget {
  TodoData? todo;
  int? index;
  final bool newTodo;

  CreateTodoScreen({Key? key, this.todo, this.index, required this.newTodo})
      : super(key: key);

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  void _trySubmit() async {
    TodoNotifier todoNotifier = context.read<TodoNotifier>();
    TodoVM todoVM = context.read<TodoVM>();

    todoVM.setTapped(true);

    final isValid = todoVM.todoFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      todoVM.todoFormKey.currentState!.save();
      // Call Api accordingly

      if (widget.newTodo) {
        // Call create api
        EasyLoading.show();
        await todoNotifier.createTodo(
            title: todoVM.titleController.text.trim(),
            completed: todoVM.status);
        EasyLoading.dismiss();
      } else {
        // Call update api
        EasyLoading.show();
        await todoNotifier.updateTodo(
            title: todoVM.titleController.text.trim(),
            completed: todoVM.status,
            id: '${widget.todo!.sId}',
            index: widget.index!);
        EasyLoading.dismiss();
      }

      // Clearing the form
      todoVM.clear();
      todoVM.setTapped(false);
    }
  }

  @override
  void initState() {
    if(!widget.newTodo){
      context.read<TodoVM>().setTodo(todoData: widget.todo!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TodoVM todoVM = context.watch<TodoVM>();
    return Scaffold(
      appBar: AppAppbar(
        title: widget.newTodo ? "Create Todo" : "Update Todo",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
        child: Form(
          key: todoVM.todoFormKey,
          child: Column(
            children: [
              SizedBox(
                height: 0.015.sh,
              ),
              AppSimpleTextField(
                controller: todoVM.titleController,
                onChange: (str) {},
                hintText: "Todo title",
                validationMsg: "Todo title is required",
                keyboard: TextInputType.text,
              ),
              SizedBox(
                height: 0.015.sh,
              ),
              CheckboxListTile(
                  title: Text(
                    "Todo Status",
                    style: context.bodyLarge,
                  ),
                  value: todoVM.status,
                  onChanged: todoVM.updateStatus),
              SizedBox(
                height: 0.015.sh,
              ),
              AppElevatedButton(
                  onPressed: todoVM.isTapped ? null : _trySubmit,
                  buttonText: widget.newTodo ? "Create" : "Update",
                  textColor: AppTheme.whiteColor,
                  buttonColor: AppTheme.primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
