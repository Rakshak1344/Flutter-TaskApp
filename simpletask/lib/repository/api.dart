import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simpletask/models/taskModel.dart';

class API {
  String baseURL = "http://10.0.2.2:3000";
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  Future<List<Task>> fetchAllTask() async {
    List<Task> tasks = [];
    var response = await http.get(
      '$baseURL/alltask',
      headers: headers,
    );

    Iterable list = jsonDecode(response.body);
    tasks = list.map((model) => Task.fromJson(model)).toList();

    print(tasks.length);
    return tasks;
  }

  postTask(Task task) async {
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
   
  }

  deleteAllTask() async {
    await http.delete(
      "$baseURL/deleteAllTask",
      headers: headers,
    );
  }

  deleteTask(Task task) async {
    await http.delete(
      "$baseURL/deletetaskbyid/${task.id}",
      headers: headers,
    );
  }
  updateTask(Task task,String id) async {
    String body = json.encode(task.toJson());
    print(body);
    await http.patch(
      "$baseURL/updatetask/$id",
      body: body,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json"
      },
    );
  }
}
