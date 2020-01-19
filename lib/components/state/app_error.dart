import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppError extends StatelessWidget {
  const AppError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 60,
          ),
          SizedBox(
            height: 20,
          ),
          Text("An unexpected error occured and data could not be fetched")
        ],
      ),
    );
  }
}
