import 'package:flutter/material.dart';

/// Enum that indicates the actions (flat buttons) which should appear on the CustomAlertDialog
///
/// * `YesNo`: two buttons (yes and no)
/// * `YesNoCancel`: three buttons (yes, no and cancel)
/// * `OKCancel`: two buttons (OK and cancel)
/// * `OK`: one button
enum CustomAlertDialogType {
  YesNo,
  YesNoCancel,
  OKCancel,
  OK,
}

/// Enum that indicates the action (flat button pressed) from user after a call
/// to [CustomAlertDialog]
///
/// * `Yes`: user pressed Yes button
/// * `No`: user pressed No button
/// * `OK`: user pressed OK button
/// * `Cancel`: user pressed Cancel button
enum CustomAlertDialogResult {
  Yes,
  No,
  Cancel,
  OK,
}

class DialogHelper {

  /// Show simple snackbar without actions
  ///
  /// * `context`: the BuildContext object (required)
  /// * `message`: a message (string)
  ///
  /// It shows a default snackbar on bottom of the screen
  static void ShowSnack(BuildContext context, String message) {
    final snack = SnackBar(
      content: Text(message),
      elevation: 10,
    );

    Scaffold.of(context).showSnackBar(snack);
  }

  /// Confirm alert dialog, used to confirm an action before executing it
  ///
  /// * `context`: the BuildContext object (required)
  /// * `message`: a message (string). It shoud be a yes/no question since it's an
  /// action confirmation dialog.
  ///
  /// It returns a `future` of `bool` indicating whether the user selected yes (returns [true])
  /// or no (returns [false])
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

    return showDialog<bool>(
      context: context,
      builder: (_) => dialog,
      barrierDismissible: false,
    );
  }

  /// Alert with more default actions
  ///
  /// * `context`: the BuildContext object (required)
  /// * `title`: the title of the alert (defaults to the App Name)
  /// * `message`: the message to the user  (required)
  /// * `customAlertDialogType`: enum indicating the type of the alert and it actions
  /// or buttons (defaults to [CustomAlertDialogType.OK] which means a dialog with a
  /// single OK button)
  /// * `dismissible`: whether the dialog will force to choose an option or no (defaults
  /// to true, user can touch outside the alert to dismiss it, and not choosing an option,
  /// in this case, this function will return `null`)
  ///
  /// Returns a future of `CustomAlertDialogResult` indicating the chosen option from
  /// the user, or `null` if not (set `dismissable` to [false] to force user choose an option
  /// and avoid returning `null`)
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

  static List<FlatButton> _getCustomDialogActions(
      BuildContext context, CustomAlertDialogType customDialogType) {
    var result = List<FlatButton>();

    if (customDialogType.toString().contains('OK'))
      result.add(FlatButton(
        child: Text('OK'),
        onPressed: () => Navigator.of(context).pop(CustomAlertDialogResult.OK),
      ));

    if (customDialogType.toString().contains('Cancel'))
      result.add(FlatButton(
        child: Text('Cancel'),
        onPressed: () =>
            Navigator.of(context).pop(CustomAlertDialogResult.Cancel),
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
