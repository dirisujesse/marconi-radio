import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marconi_radio/components/state/app_error.dart';
import 'package:marconi_radio/components/state/app_spinner.dart';
import 'package:marconi_radio/components/typography/app_header.dart';
import 'package:marconi_radio/components/typography/app_txt.dart';
import 'package:marconi_radio/models/station.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:marconi_radio/models/categories.dart';
import 'package:marconi_radio/services/http.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      bottomNavigationBar: Consumer<PlayerState>(
        builder: (context, PlayerState data, _) {
          if (data.selectedStation != null) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: appWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: appGrey,
                    blurRadius: 1.5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ListTile(
                onTap: () => Navigator.of(context).pushNamed('/detail'),
                leading: Image.network(
                  data?.selectedStation?.logo ??
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_jOaO2EBV-jBMOEdkGp8NtQIY8UakejJhbGnZH7_MHy49XFgXhQ&s',
                  width: 50,
                  height: 100,
                  alignment: Alignment.center,
                ),
                title: BodyText(
                  data.selectedStation.name.toUpperCase(),
                  maxLines: 1,
                ),
                subtitle: Text(data.selectedStation.genre),
                trailing: IconButton(
                  icon: Icon(
                    data.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    size: 40,
                    color: appBlack,
                  ),
                  onPressed: () => data.isPlaying
                      ? data.pause()
                      : data.play(val: data.selectedStation),
                ),
              ),
            );
          }
          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appBlack,
        child: Icon(Icons.playlist_play),
        onPressed: () => PlayerState.getInstance()
            .play(val: Station.fromJson(PlayerState.getInstance().stations[0])),
      ),
      backgroundColor: appWhite,
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
                // centerTitle: true,
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
          future: HttpService.searchStations(widget.title, context),
          builder: (context, AsyncSnapshot<dynamic> res) {
            if (res.hasData) {
              List<dynamic> data;
              if (res.data["station"] is Map) {
                PlayerState.getInstance().stations = [res.data["station"]];
                data = [res.data["station"]];
              } else {
                PlayerState.getInstance().stations = res.data["station"];
                data = res.data["station"];
              }
              return ListView.separated(
                padding: EdgeInsets.only(bottom: 100),
                separatorBuilder: (context, idx) {
                  if (idx != data.length - 1) {
                    return Container(
                      height: 0.8,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: appGrey,
                    );
                  } else {
                    return SizedBox();
                  }
                },
                itemCount: data.length,
                itemBuilder: (context, idx) {
                  Station station = Station.fromJson(data[idx]);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                        station?.logo ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_jOaO2EBV-jBMOEdkGp8NtQIY8UakejJhbGnZH7_MHy49XFgXhQ&s',
                      ),
                    ),
                    title: BodyText(
                      station.name.toUpperCase(),
                      maxLines: 1,
                    ),
                    subtitle: Text(station.genre),
                    trailing: Consumer<PlayerState>(
                      builder: (context, PlayerState val, _) {
                        return IconButton(
                          icon: Icon(
                            (val.isPlaying &&
                                    station.id == val.selectedStation.id)
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            size: 40,
                            color: appBlack,
                          ),
                          onPressed: () => (val.isPlaying &&
                                  station.id == val.selectedStation.id)
                              ? val.pause()
                              : val.play(val: station),
                        );
                      },
                    ),
                  );
                },
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
