import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {

  final Function onPressedExecution;
  final String textLabel;

  const CustomRaisedButton({Key key, this.onPressedExecution, this.textLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(textLabel),
      onPressed: onPressedExecution,
      color: Colors.lightBlueAccent,
    );
  }
}
