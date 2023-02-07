
import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChangeToNext(BuildContext context, FocusNode current, FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)
        )
    );
  }


}
