import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marconi_radio/components/layout/app_scaffold.dart';
import 'package:marconi_radio/components/layout/player.dart';
import 'package:marconi_radio/components/layout/station_list.dart';
import 'package:marconi_radio/components/state/app_error.dart';
import 'package:marconi_radio/components/state/app_spinner.dart';
import 'package:marconi_radio/components/typography/app_header.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/state/preferences.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:marconi_radio/models/categories.dart';
import 'package:marconi_radio/services/http.dart';

class ListPage extends StatefulWidget {
  final String title;
  final AppCategory category;

  ListPage({@required this.title, @required this.category});

  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _playState = PlayerState.getInstance();
    return AppScaffold(
      bottomNavigationBar: MarconiPlayer(context),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              backgroundColor: appBlack,
              flexibleSpace: FlexibleSpaceBar(
                title: HeaderText(
                  widget.category.name,
                  color: appWhite,
                ),
                background: Hero(
                  tag: widget.title,
                  child: Image.network(
                    widget.category.image,
                    fit: BoxFit.cover,
                    color: appBlack.withOpacity(0.6),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
            )
          ];
        },
        body: FutureBuilder(
          future: Future.wait([
            HttpService.searchStations(widget.title, context),
            PrefsState.getInstance().favourites
          ]),
          builder: (context, AsyncSnapshot<dynamic> res) {
            if (res.hasData) {
              List<dynamic> data;
              List<dynamic> favs = res.data[1];
              if (res.data[0]["station"] is Map) {
                data = [res.data[0]["station"]];
                _playState.stations = data;
              } else {
                data = res.data[0]["station"];
                _playState.stations = data;
              }
              return StationList(
                data: data,
                favs: favs,
                ctx: context,
              );
            } else if (res.hasError) {
              return const AppError();
            } else {
              return const AppSpinner();
            }
          },
        ),
      ),
    );
  }
}
