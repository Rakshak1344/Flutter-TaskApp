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
}
