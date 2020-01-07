import 'package:flutter/material.dart';
import 'package:marconi_radio/components/state/app_spinner.dart';
import 'package:marconi_radio/components/typography/app_txt.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:provider/provider.dart';

class MarconiPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerState>(
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
                    'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png',
                width: 50,
                height: 100,
                alignment: Alignment.center,
              ),
              title: BodyText(
                data.selectedStation.name.toUpperCase(),
                maxLines: 1,
              ),
              subtitle: Text(data.selectedStation.genre),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      size: 40,
                      color: appBlack,
                    ),
                    onPressed: () => data.playPrev(val: data.selectedStation),
                  ),
                  data.isLoading
                      ? const AppSpinner()
                      : IconButton(
                          icon: Icon(
                            data.isPlaying
                                ? Icons.pause_circle_outline
                                : Icons.play_circle_outline,
                            size: 40,
                            color: appBlack,
                          ),
                          onPressed: () => data.isPlaying
                              ? data.pause()
                              : data.play(val: data.selectedStation),
                        ),
                  IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      size: 40,
                      color: appBlack,
                    ),
                    onPressed: () => data.playNext(val: data.selectedStation),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
