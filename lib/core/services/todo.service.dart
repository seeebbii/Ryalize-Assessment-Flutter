import 'dart:developer';

import 'package:ryalize_assessment/core/api/api_paths.dart';
import 'package:ryalize_assessment/core/api/api_service.dart';
import 'package:ryalize_assessment/core/models/todo/todo.model.dart';
import 'package:ryalize_assessment/core/models/todo/todo_data.model.dart';

class TodoService {

  /// Fetch all todos from the API
  /// @return TodoModel
  static Future<TodoModel> fetchTodos() async {
    TodoModel todos = TodoModel();

    var response = await ApiService.request(
      ApiPaths.fetchAllTodos,
      method: RequestMethod.GET,
    );
    if (response != null) {
      todos = TodoModel.fromJson(response);
    }
    return todos;
  }

  /// Create a todo from the API
  /// @param title
  /// @param completed
  /// @return TodoData
  static Future<TodoData?> createTodo({required String title,
    bool completed = false}) async{

    TodoData? todo;

    var data = {
      'title': title,
      "completed" : completed
    };
    var response = await ApiService.request(
        ApiPaths.createTodo,
        method: RequestMethod.POST,
        data: data
    );

    if (response != null) {
      if(response['status'] == 200){
        todo = TodoData.fromJson(response['data']);
      }
    }
    return todo;
  }

  /// Update a todo from the API
  /// @param title
  /// @param completed
  /// @param id
  /// @param index
  /// @return TodoData
  static Future<TodoData?> updateTodo({required String title, required bool completed, required String id, required int index}) async {
    TodoData? todo;

    var data = {'title': title, "completed": completed};
    var response = await ApiService.request("${ApiPaths.updateTodo}$id", method: RequestMethod.POST, data: data);
    log("$response");
    if (response != null) {
      if (response['status'] == 200) {
        todo = TodoData.fromJson(response['data']);
      }
    }

    return todo;
  }

  /// Delete a todo from the API
  /// @param id
  /// @return bool [as a status if the todo is deleted]
  static Future<bool> deleteTodo({required String id}) async {
    var response = await ApiService.request("${ApiPaths.deleteTodo}$id", method: RequestMethod.POST,);

    if (response != null) {
      if (response['status'] == 200) {
        return true;
      }
    }
    return false;
  }

}