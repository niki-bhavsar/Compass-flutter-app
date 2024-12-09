import 'package:flutter/material.dart';

class KeyboardUtil {
  static hideKeyboard(BuildContext context) {
    var scopeNode = FocusScope.of(context);
    if (scopeNode.isFirstFocus) {
      scopeNode.requestFocus(FocusNode());
    }
  }
}
