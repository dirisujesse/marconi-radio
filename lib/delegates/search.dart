import 'package:flutter/material.dart';
import 'package:marconi_radio/components/layout/app_scaffold.dart';
import 'package:marconi_radio/components/layout/player.dart';
import 'package:marconi_radio/components/layout/station_list.dart';
import 'package:marconi_radio/components/state/app_error.dart';
import 'package:marconi_radio/components/state/app_spinner.dart';
import 'package:marconi_radio/services/http.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/state/preferences.dart';
import 'package:marconi_radio/styles/colors.dart';

class MarconiSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = super.appBarTheme(context);
    return theme.copyWith(
      primaryColor: appBlack,
      brightness: Brightness.dark,
      textTheme: Theme.of(context).textTheme.apply(bodyColor: appWhite),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        hintStyle: TextStyle(
          color: appGrey,
          fontFamily: "OpenSans",
          fontSize: 15
        ),
      ),
    );
  }

  @override
  String get searchFieldLabel => "search artistes, genres, anything";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: appWhite,
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: appWhite,
      icon: BackButtonIcon(),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final _playState = PlayerState.getInstance();
    return AppScaffold(
      body: Builder(
        builder: (context) {
          if (query.length > 0) {
            return FutureBuilder(
              future: Future.wait([
                HttpService.searchStationsOnline(query),
                PrefsState.getInstance().favourites
              ]),
              builder: (context, AsyncSnapshot<dynamic> data) {
                if (data.hasData) {
                  List<dynamic> stations;
                  List<dynamic> favs = data.data[1];
                  if (data.data[0]["station"] != null) {
                    if (data.data[0]["station"] is Map) {
                      stations = [data.data[0]["station"]];
                      _playState.stations = stations;
                    } else {
                      stations = data.data[0]["station"];
                      _playState.stations = stations;
                    }
                  } else {
                    stations = [];
                  }
                  if (stations.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.hourglass_empty, size: 60),
                          SizedBox(
                            height: 20,
                          ),
                          Text("No results were found for your query")
                        ],
                      ),
                    );
                  }
                  return StationList(
                    data: stations,
                    favs: favs,
                    ctx: context,
                    isSearch: true,
                  );
                } else if (data.hasError) {
                  return const AppError();
                } else {
                  return const AppSpinner();
                }
              },
            );
          } else {
            return Center(child: Text("Enter query to search"));
          }
        },
      ),
      bottomNavigationBar: MarconiPlayer(context),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search for radio stations currently playing"),
    );
  }
}
