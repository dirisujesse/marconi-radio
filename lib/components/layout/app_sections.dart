import 'package:flutter/material.dart';
import 'package:marconi_radio/models/categories.dart';
import 'package:marconi_radio/components/layout/category_section.dart';

class AppSections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppSection(
              name: "Genres",
              data: genres,
            ),
            SizedBox(
              height: 30,
            ),
            AppSection(
              name: "Decades",
              data: decades,
            ),
            SizedBox(
              height: 30,
            ),
            AppSection(
              name: "Countries",
              data: countries,
            ),
          ],
        ),
      ),
    );
  }
}
