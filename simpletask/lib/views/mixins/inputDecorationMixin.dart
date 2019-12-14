import 'package:flutter/material.dart';

class DecorationMixin {
  InputDecoration buildInputDecoration(
      theme, String labelText, String hintText) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: theme.textTheme.body2,
      labelStyle: theme.textTheme.body1,
      enabledBorder: _buildUnderlineInputBorder(),
      focusedBorder: _buildUnderlineInputBorder(),
      errorBorder: _buildUnderlineInputBorder(),
      focusedErrorBorder: _buildUnderlineInputBorder(),
    );
  }

  UnderlineInputBorder _buildUnderlineInputBorder() {
    return UnderlineInputBorder(
        borderSide: BorderSide(
      color: Colors.redAccent,
    ));
  }

  SnackBar buildSnackBar({IconData icon, String task, String action}) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Icon(icon, size: 38, color: Colors.redAccent),
          CircleAvatar(
            child: Stack( children: <Widget>[
              
              CircularProgressIndicator(backgroundColor: Colors.black, strokeWidth: 5,),
               Padding(
                 padding: const EdgeInsets.only(top: 3,left: 3),
                 child: Icon(icon,size: 30, color: Colors.redAccent),
               ),
            ],),
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            action,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            task,
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic,color: Colors.black),
          ),
          
        ],
      ),
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.redAccent,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
    );
  }
}
