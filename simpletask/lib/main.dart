import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletask/appTheme.dart';
import 'package:simpletask/views/myTasks.dart';
import './provider/appState.dart';

void main() => runApp(
      ChangeNotifierProvider<AppState>(
        child: MyApp(),
        create: (context)=> AppState(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Simple Task',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: MyTasks(),
        );
      },
    );
  }
}
