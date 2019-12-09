import 'package:flutter/material.dart';
import 'package:simpletask/models/taskModel.dart';
import 'package:simpletask/repository/api.dart';
import 'package:simpletask/views/mixins/inputDecorationMixin.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> with DecorationMixin {
  var _formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController taskEditingController = new TextEditingController();
  String name = "", myTask = "";

  API api = new API();
  DecorationMixin decor = new DecorationMixin();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Add Task",
              style: TextStyle(color: theme.iconTheme.color, fontSize: 40),
            ),
          ),
          Card(
            color: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Container(
                    // decoration: BoxDecoration(),
                    child: TextFormField(
                      controller: nameEditingController,
                      validator: (String value) =>
                          value.isEmpty ? "Name required" : null,
                      onSaved: (value) => name = value,
                      decoration: buildInputDecoration(
                          theme, "Task Name", "Ex: get keys"),
                      maxLines: null,
                      autofocus: false,
                      cursorColor: Colors.redAccent,
                      cursorWidth: 6,
                      style: theme.textTheme.body1,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: taskEditingController,
                    validator: (String task) =>
                        task.isEmpty ? "Task required" : null,
                    onSaved: (value) => myTask = value,
                    decoration: buildInputDecoration(
                        theme, "Task to be done", "Ex: get keys from studio"),
                    maxLines: null,
                    cursorColor: Colors.redAccent,
                    cursorWidth: 6,
                    style: theme.textTheme.body1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: theme.iconTheme.color,
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Task task = new Task(
                        name: nameEditingController.text.trim(),
                        task: taskEditingController.text.trim(),
                      );
                      _formKey.currentState.save();
                      api.postTask(task);
                      Navigator.of(context).pop();
                      print('success');
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
