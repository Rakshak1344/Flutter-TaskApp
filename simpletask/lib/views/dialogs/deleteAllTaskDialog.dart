import 'package:flutter/material.dart';

enum DeleteAllTaskDialogAction { confirm, cancel }

class DeleteAllTaskDialog {
  static Future<DeleteAllTaskDialogAction> deleteAllTaskDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          child: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 60,
                    child: Text(title, style: TextStyle(fontSize: 30))),
                Container(
                    height: 50,
                    child: Text(body,
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40)),
                      child: FlatButton(
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 25)),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(DeleteAllTaskDialogAction.cancel);
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      child: FlatButton(
                        child: Text("Confirm",
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 25)),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(DeleteAllTaskDialogAction.confirm);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    return (action != null) ? action : DeleteAllTaskDialogAction.cancel;
  }
}
