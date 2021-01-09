import 'package:flutter/material.dart';

class Loader {
  static Future<void> showLoadingDialog(
      BuildContext context, _loaderKey) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          key: _loaderKey,
          elevation: 0,
          contentPadding: EdgeInsets.all(1),
          backgroundColor: Colors.transparent,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 60,
              height: 60,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Colors.blueAccent,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlueAccent),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
