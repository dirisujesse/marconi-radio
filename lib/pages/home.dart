import 'package:flutter/material.dart';

import 'package:marconi_radio/components/layout/app_scaffold.dart';
import 'package:marconi_radio/components/layout/app_sections.dart';
import 'package:marconi_radio/components/layout/player.dart';
import 'package:marconi_radio/components/layout/preferences.dart';
import 'package:marconi_radio/components/typography/app_header.dart';
import 'package:marconi_radio/delegates/search.dart';
import 'package:marconi_radio/services/hive.dart';

import 'package:marconi_radio/styles/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _ctrl;
  String lastTerm;
  @override
  void initState() {
    lastTerm = "";
    super.initState();
    _ctrl = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_ctrl.index != 0) {
          _ctrl.animateTo(_ctrl.index - 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
          return false;
        } else {
          return popHandler(context);
        }
      },
      child: AppScaffold(
        bottomNavigationBar: MarconiPlayer(context),
        appBar: AppBar(
          bottom: TabBar(
            controller: _ctrl,
            tabs: <Widget>[
              Tab(
                text: "HOME",
              ),
              Tab(
                text: "FAVOURITES",
              ),
              Tab(
                text: "RECENT",
              ),
            ],
          ),
          backgroundColor: appBlack,
          centerTitle: true,
          title: HeaderText(
            "Marconi Radio",
            color: appWhite,
            alignment: TextAlign.center,
          ),
          elevation: 1,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final result = await showSearch(
                  context: context,
                  query: lastTerm,
                  delegate: MarconiSearchDelegate(),
                );
                lastTerm = result;
              },
            )
          ],
        ),
        body: TabBarView(
          controller: _ctrl,
          children: <Widget>[
            AppSections(),
            Preferences(true),
            Preferences(false)
          ],
        ),
      ),
    );
  }
}
