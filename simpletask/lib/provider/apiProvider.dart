import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:simpletask/models/taskModel.dart';
import 'package:http/http.dart' as http;

class ApiProvider extends ChangeNotifier {
  List _task;

  //get the value from task in UI
  List<Task> get listOfTasks => _task;

  //set the value to _task
  set listOfTasks(List<Task> value) {
    _task = value;
    notifyListeners();
  }

  String baseURL = "http://10.0.2.2:3000";
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  Future<List<Task>> fetchAllTask() async {
    var response = await http.get(
      '$baseURL/alltask',
      headers: headers,
    );

    List<Task> tasks = [];

    Iterable list = jsonDecode(response.body);
    tasks = list.map((model) => Task.fromJson(model)).toList();

    listOfTasks = tasks;
    print("All Tasks ${listOfTasks.length}");
    return listOfTasks;
  }

  Future<List<Task>> postTask(Task task) async {
    /*refer the below obj
     Task task = new Task(
       name: nameEditingController.text,
       task: taskEditingController.text,
     );
    */
    String newData = json.encode(task.toJson());
    // Map<String, dynamic> data = task.toJson();
    await http.post(
      "$baseURL/posttask",
      body: newData,
      headers: headers,
    );

    return listOfTasks;
  }

  deleteAllTask() async {
    await http.delete(
      "$baseURL/deleteAllTask",
      headers: headers,
    );
    listOfTasks = [];
  }

  deleteTask(Task task) async {
    await http.delete(
      "$baseURL/deletetaskbyid/${task.id}",
      headers: headers,
    );

  }

  Future<List<Task>> updateTask(Task task, String id) async {
    String body = json.encode(task.toJson());
    await http.patch(
      "$baseURL/updatetask/$id",
      body: body,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
    );
    return listOfTasks;
  }
}
