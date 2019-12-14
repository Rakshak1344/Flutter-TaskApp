import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletask/provider/ApiProvider.dart';
import 'package:simpletask/provider/appState.dart';
import 'package:simpletask/theme/appTheme.dart';
import 'package:simpletask/views/myTasks.dart';

void main() => runApp(
      ChangeNotifierProvider<AppState>(
        child: MyApp(),
        create: (context) => AppState(),
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
            home: ChangeNotifierProvider<ApiProvider>(
              child: MyTasks(),
              create: (context) => ApiProvider(),
            ));
      },
    );
  }
}
