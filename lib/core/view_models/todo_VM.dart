import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ryalize_assessment/core/models/todo/todo_data.model.dart';

/// Handle the ui logic of the todo screen
class TodoVM extends ChangeNotifier {

  /// VM Variables
  final TextEditingController _titleController = TextEditingController();
  final _todoFormKey = GlobalKey<FormState>();
  bool _status = false;
  bool _isTapped = false;

  /// VM Getters
  TextEditingController get titleController => _titleController;
  GlobalKey<FormState> get todoFormKey => _todoFormKey;
  bool get status => _status;
  bool get isTapped => _isTapped;

  /// Set the todo data to the form
  /// @param todoData
  void setTodo({required TodoData todoData, }) {
    _status = todoData.completed ?? false;
    _titleController.text = todoData.title ?? "";
  }

  /// Update the status of the todo
  /// @param val
  void updateStatus(bool? val) {
    _status = val ?? false;
    notifyListeners();
  }

  /// Clear the form
  void clear() {
    _titleController.clear();
    _status = false;
    notifyListeners();
  }

  /// Set the tapped state
  /// Checks if the button is tapped so we can handle miss taps
  void setTapped(bool val) {
    _isTapped = val;
    notifyListeners();
  }

}