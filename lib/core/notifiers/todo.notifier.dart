import 'package:flutter/foundation.dart';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/core/api/api_paths.dart';
import 'package:ryalize_assessment/core/api/api_service.dart';
import 'package:ryalize_assessment/core/models/todo/todo.model.dart';
import 'package:ryalize_assessment/core/models/todo/todo_data.model.dart';
import 'package:ryalize_assessment/core/services/todo.service.dart';
import 'package:ryalize_assessment/meta/utils/base_helper.dart';

/// Todo Notifier
/// This class is responsible for handling the state of the Todo screen
/// It is used to fetch, create, update and delete todos
class TodoNotifier extends ChangeNotifier {

  /// Todo Model
  /// This is the model that is used to store the data of the todos
  TodoModel todoModel = TodoModel();

  /// Fetch Todos
  /// This method is used to fetch the todos from the API
  /// It returns a Future of type TodoModel
  /// It also notifies the listeners
  Future<TodoModel> fetchTodos() async {
    todoModel = TodoModel();
    todoModel = await TodoService.fetchTodos();
    notifyListeners();
    return todoModel;
  }

  /// Create Todo
  /// This method is used to create a todo after calling the api
  /// [title] is the title of the todo
  /// [completed] is the status of the todo
  Future<void> createTodo(
      {required String title, bool completed = false}) async {
    TodoData? todoData = await TodoService.createTodo(title: title, completed: completed);

    if (todoData != null) {
      todoModel.todoData?.add(todoData);
      notifyListeners();
      navigationController.goBack();
    } else {
      BaseHelper.showSnackBar('Error creating todo');
    }
  }

  /// Update Todo
  /// This method is used to update a todo after calling the api
  /// [title] is the title of the todo
  /// [completed] is the status of the todo
  /// [id] is the id of the todo
  /// [index] is the index of the todo in the list
  Future<void> updateTodo(
      {required String title,
      required bool completed,
      required String id,
      required int index}) async {

    TodoData? todoData = await TodoService.updateTodo(title: title, completed: completed, id: id, index: index);

    if (todoData != null) {
      todoModel.todoData?[index] = todoData;
      notifyListeners();
      navigationController.goBack();
    } else {
      BaseHelper.showSnackBar('Error updating todo');
    }
  }

  /// Delete Todo
  /// This method is used to delete a todo after calling the api
  /// [id] is the id of the todo
  /// [index] is the index of the todo in the list
  Future<void> deleteTodo({required String id, required int index}) async {
    bool isDeleted = await TodoService.deleteTodo(id: id);
    if(isDeleted) {
      todoModel.todoData?.removeAt(index);
      notifyListeners();
      navigationController.goBack();
    }else{
      BaseHelper.showSnackBar('Error deleting todo');
    }
  }
}
