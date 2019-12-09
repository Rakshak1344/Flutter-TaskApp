import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DeleteParticularTaskDialogAction { confirm, cancel }

class DeleteParticularTaskDialog {
  static Future<DeleteParticularTaskDialogAction> deleteTask(
    BuildContext context,
    String taskName,
    String taskDesc,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          elevation: 10,
          child: Container(
              height: 250,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    child: Text(
                      taskName,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      taskDesc,
                      style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                                .pop(DeleteParticularTaskDialogAction.cancel);
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        // width: double.infinity,
                        child: FlatButton(
                          child: Text("Confirm",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 25)),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(DeleteParticularTaskDialogAction.confirm);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              )),
        );
      },
    );
    return action != null ? action : DeleteParticularTaskDialogAction.cancel;
  }
}
