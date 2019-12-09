import 'package:flutter/material.dart';
import 'package:simpletask/models/taskModel.dart';
import 'package:simpletask/repository/api.dart';
import 'package:simpletask/views/mixins/inputDecorationMixin.dart';

class UpdateTask extends StatefulWidget  {
  final Task updateTask;
  UpdateTask(this.updateTask);
  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> with DecorationMixin {

  var _formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController taskEditingController = new TextEditingController();
  String name, myTask;
  API api = new API();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text("Update Task", style: theme.textTheme.body1),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Update Task",
                  style: TextStyle(color: Colors.redAccent, fontSize: 40),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "${widget.updateTask.name}",
                  style: TextStyle(
                      color: theme.colorScheme.onPrimary, fontSize: 40),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
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
                    child: TextFormField(
                      controller: nameEditingController,
                      validator: (String value) =>
                          value.isEmpty ? "Name required" : null,
                      onSaved: (value) => name = value,
                      decoration: buildInputDecoration(
                        theme,
                        "Task Name",
                        "Ex: get keys",
                      ),
                      maxLines: null,
                      autofocus: false,
                      cursorColor: theme.iconTheme.color,
                      cursorWidth: 6,
                      style: theme.textTheme.body1,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: taskEditingController,
                    validator: (String task) =>
                        task.isEmpty ? "Task required" : null,
                    onSaved: (value) => myTask = value,
                    decoration: buildInputDecoration(
                        theme, "Task to be done", "Ex: get keys from studio"),
                    maxLines: null,
                    cursorColor: theme.iconTheme.color,
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
                    Icons.done,
                    color: theme.iconTheme.color,
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Task task = new Task(
                        id: widget.updateTask.id,
                        name: nameEditingController.text.trim(),
                        task: taskEditingController.text.trim(),
                      );
                      _formKey.currentState.save();
                      api.updateTask(task, task.id);
                      print('success');
                      Navigator.of(context).pop();
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
