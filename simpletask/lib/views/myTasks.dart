import 'package:flutter/material.dart';
import 'package:simpletask/models/taskModel.dart';
import 'package:simpletask/repository/api.dart';
import 'package:simpletask/views/addTask.dart';
import 'package:simpletask/views/dialogs/deleteAllTaskDialog.dart';
import 'package:simpletask/views/drawer.dart';
import 'package:simpletask/views/updateTask.dart';

import 'dialogs/deleteParticularTaskDialog.dart';

class MyTasks extends StatefulWidget {
  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  API api = new API();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Future<List<Task>> fetchTask = api.fetchAllTask();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: appBar(fetchTask, theme),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Today's task",
                    style:
                        TextStyle(color: theme.iconTheme.color, fontSize: 40),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTask(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: theme.iconTheme.color,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: FutureBuilder(
              future: fetchTask,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return buildCircularProgressIndicator();
                } else if (snapshot.data.length == 0) {
                  return buildNoTasks(theme);
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index) {
                      var data = snapshot.data[index];
                      return Card(
                        color: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child: ListTile(
                          title: Text(data.name, style: theme.textTheme.body1),
                          subtitle:
                              Text(data.task, style: theme.textTheme.body2),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: theme.iconTheme.color,
                              size: 30,
                            ),
                            onPressed: () async {
                              Task task = new Task(
                                id: data.id,
                                name: data.name,
                                task: data.task,
                              );
                              final action =
                                  await DeleteParticularTaskDialog.deleteTask(
                                context,
                                "Delete ${data.name} ?",
                                "This action will permanently delete the task ${data.name}",
                              );
                              if (action ==
                                  DeleteParticularTaskDialogAction.confirm) {
                                await api.deleteTask(task);
                                setState(() {
                                  fetchTask = api.fetchAllTask();
                                });
                              }
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateTask(data),
                              ),
                            );
                          },
                          //to pass the data to other class send it through constructor AddTask(snapshot.data[index])
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Center buildCircularProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
      ),
    );
  }

  Center buildNoTasks(ThemeData theme) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.sentiment_dissatisfied,
                  size: 100,
                  color: Colors.redAccent,
                ),
                Card(
                  color: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "No Tasks",
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar(fetchTask, theme) {
    return AppBar(
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            icon: Icon(Icons.delete_forever),
            color: Theme.of(context).iconTheme.color,
            iconSize: 30,
            onPressed: () async {
              final action = await DeleteAllTaskDialog.deleteAllTaskDialog(
                context,
                "Delete All Task",
                "This action cannot be recovered",
              );
              if (action == DeleteAllTaskDialogAction.confirm) {
                await api.deleteAllTask();
                setState(() {
                  fetchTask = api.fetchAllTask();
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
