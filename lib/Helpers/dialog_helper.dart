import 'package:flutter/material.dart';

enum CustomAlertDialogType {
  YesNo,
  YesNoCancel,
  OKCancel,
  OK,
}

enum CustomAlertDialogResult {
  Yes,
  No,
  Cancel,
  OK,
}

class DialogHelper {

  // Show simple snackbar without actions, asks for context and a message string
  static void ShowSnack(BuildContext context, String message) {
    final snack = SnackBar(
      content: Text(message),
      elevation: 10,
    );

    Scaffold.of(context).showSnackBar(snack);
  }


  // Confirm alert to return yes/no (true/false)
  static Future<bool> Confirm(
      {BuildContext context, String title = 'App Name', String message}) {
    var dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );

    return showDialog<bool>(context: context, builder: (_) => dialog);
  }

  // Alert with more default actions
  static Future<CustomAlertDialogResult> CustomAlertDialog(
      {BuildContext context,
      String title = 'App Name',
      @required String message,
      CustomAlertDialogType customAlertDialogType = CustomAlertDialogType.OK,
      bool dismissible = true}) {

    var dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: _getCustomDialogActions(context, customAlertDialogType),
    );

    return showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (_) => dialog);
  }

  static List<FlatButton> _getCustomDialogActions(BuildContext context, CustomAlertDialogType customDialogType){

    var result = List<FlatButton>();

    if (customDialogType.toString().contains('OK'))
      result.add(FlatButton(
        child: Text('OK'),
        onPressed: () => Navigator.of(context).pop(CustomAlertDialogResult.OK),
      ));

    if (customDialogType.toString().contains('Cancel'))
      result.add(FlatButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(CustomAlertDialogResult.Cancel),
      ));

    if (customDialogType.toString().contains('Yes'))
      result.add(FlatButton(
        child: Text('Yes'),
        onPressed: () => Navigator.of(context).pop(CustomAlertDialogResult.Yes),
      ));

    if (customDialogType.toString().contains('No'))
      result.add(FlatButton(
        child: Text('No'),
        onPressed: () => Navigator.of(context).pop(CustomAlertDialogResult.No),
      ));

    return result;
  }
}
