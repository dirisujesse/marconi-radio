import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppSpinner extends StatelessWidget {
  const AppSpinner();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator(),
    );
  }
}
