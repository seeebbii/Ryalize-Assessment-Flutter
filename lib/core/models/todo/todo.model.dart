

import 'package:ryalize_assessment/core/models/todo/todo_data.model.dart';

class TodoModel {
  int? status;
  bool? success;
  List<TodoData>? todoData;
  dynamic currentPage;
  int? pages;
  int? numOfResults;

  TodoModel(
      {this.status,
        this.success,
        this.todoData,
        this.currentPage,
        this.pages,
        this.numOfResults});

  TodoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      todoData = <TodoData>[];
      json['data'].forEach((v) {
        todoData!.add( TodoData.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    pages = json['pages'];
    numOfResults = json['numOfResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['success'] = success;
    if (todoData != null) {
      data['data'] = todoData!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['pages'] = pages;
    data['numOfResults'] = numOfResults;
    return data;
  }
}

