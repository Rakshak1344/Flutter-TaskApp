import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletask/models/taskModel.dart';
import 'package:simpletask/provider/ApiProvider.dart';
import 'package:simpletask/views/addTask.dart';
import 'package:simpletask/views/dialogs/deleteAllTaskDialog.dart';
import 'package:simpletask/views/drawer.dart';
import 'package:simpletask/views/mixins/inputDecorationMixin.dart';
import 'package:simpletask/views/updateTask.dart';
import 'dialogs/deleteParticularTaskDialog.dart';

class MyTasks extends StatefulWidget {
  @override
  _MyTasksState createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> with DecorationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // final ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    // apiProvider.fetchAllTask();
    // print("${apiProvider.listOfTasks[0].name}");
    Provider.of<ApiProvider>(context).fetchAllTask();
    return Consumer<ApiProvider>(
      builder: (context, provider, child) => Scaffold(
       
        key: _scaffoldKey,
        drawer: CustomDrawer(),
        appBar: appBar(provider, theme),
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
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FloatingActionButton(
                        elevation: 10,
                        tooltip: "Add Task",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => AddTask(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: theme.iconTheme.color,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: provider.listOfTasks == null
                  ? buildDatabaseNotConnected(theme)
                  : provider.listOfTasks.length == 0
                      ? buildNoTasks(theme)
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: provider.listOfTasks.length,
                          itemBuilder: (context, int index) {
                            var data = provider.listOfTasks[index];
                            // print("All task ${provider.listOfTasks}");
                            return Card(
                              color: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 10,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: ListTile(
                                title: Text(data.name,
                                    style: theme.textTheme.body1),
                                subtitle: Text(data.task,
                                    style: theme.textTheme.body2),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: theme.iconTheme.color,
                                    size: 30,
                                  ),
                                  tooltip: "Delete this task",
                                  onPressed: () async {
                                    Task task = Task(
                                      id: data.id,
                                      name: data.name,
                                      task: data.task,
                                    );
                                    final action = await DeleteParticularTaskDialog
                                        .deleteTask(
                                            context,
                                            "Delete ${data.name} ?",
                                            "This action will permanently delete the task ${data.name}");
                                    if (action ==
                                        DeleteParticularTaskDialogAction
                                            .confirm) {
                                      Scaffold.of(context).showSnackBar(
                                        buildSnackBar(
                                          icon: Icons.sentiment_dissatisfied,
                                          action: " Deleting.. ",
                                          task: "${data.name}",
                                        ),
                                      );
                                      Future.delayed(Duration(seconds: 4))
                                          .then((_) async {
                                        await provider.deleteTask(task);
                                      });

                                      // setState(() {
                                      //   fetchTask = api.fetchAllTask();
                                      // });
                                    }
                                  },
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChangeNotifierProvider(
                                        child: UpdateTask(data),
                                        create: (context) => ApiProvider(),
                                      ),
                                    ),
                                  );
                                },
                                //to pass the data to other class send it through constructor AddTask(snapshot.data[index])
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDatabaseNotConnected(ThemeData theme) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  color: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Database not connected",
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

  Widget appBar(provider, theme) {
    return AppBar(
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.delete_forever,
            size: 35,
          ),
          color: theme.iconTheme.color,
          iconSize: 30,
          tooltip: "Delete All Task",
          onPressed: () async {
            final action = await DeleteAllTaskDialog.deleteAllTaskDialog(
              context,
              "Delete All Task",
              "This action cannot be recovered",
            );
            if (action == DeleteAllTaskDialogAction.confirm) {
              _scaffoldKey.currentState.showSnackBar(
                buildSnackBar(
                  icon: Icons.sentiment_very_dissatisfied,
                  task: "All Tasks",
                  action: " Deleting... ",
                ),
              );
              Future.delayed(Duration(seconds: 4)).then((_) async {
                await provider.deleteAllTask();
                // await provider.fetchAllTask();
              });
            }
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 5, right: 10),
          child: IconButton(
            icon: Icon(
              Icons.refresh,
              size: 35,
            ),
            tooltip: "Refresh Task",
            onPressed: () => provider.fetchAllTask(),
          ),
        ),
      ],
    );
  }
}
