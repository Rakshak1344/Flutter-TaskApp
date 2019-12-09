import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpletask/provider/appState.dart';

class CustomDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        elevation: 10,
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.primaryVariant,
            child: ListTile(
              leading: Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.body1,
              ),
              trailing: Switch(
                activeColor: Colors.redAccent,
                value: Provider.of<AppState>(context).isDarkModeOn,
                onChanged: (booleanValue) {
                  Provider.of<AppState>(context).updateTheme(booleanValue);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
