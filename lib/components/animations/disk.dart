import 'package:flutter/material.dart';
import 'package:marconi_radio/models/station.dart';
import 'package:marconi_radio/state/player.dart';
import 'package:marconi_radio/styles/colors.dart';
import 'package:provider/provider.dart';

class AppDisk extends StatefulWidget {
  final Station track;
  final double maxWidth;

  AppDisk(this.track, {this.maxWidth});

  @override
  State<StatefulWidget> createState() {
    return _AppDiskState(maxWidth: maxWidth);
  }
}

class _AppDiskState extends State<AppDisk> with SingleTickerProviderStateMixin {
  AnimationController _ctrl;
  double maxWidth;
  double subConWidth;
  double subSubConWidth;

  _AppDiskState({this.maxWidth});

  @override
  void initState() {
    super.initState();
    if (widget.maxWidth != null) {
      subConWidth = widget.maxWidth * 0.4;
      subSubConWidth = subConWidth * 0.8;
    }
    _ctrl = AnimationController(
      duration: Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maxWidth == null) {
      final x = MediaQuery.of(context).size.width;
      maxWidth = x <= 100
          ? 50
          : x <= 200
              ? 100
              : x <= 300 ? 150 : x <= 400 ? 200.0 : x <= 600 ? 300.0 : 400.0;
      subConWidth = 50;
      subSubConWidth = 30;
    }

    return Consumer<PlayerState>(
      builder: (context, state, _) {
        if (!state.isPlaying) {
          _ctrl.stop();
        } else {
          _ctrl.repeat();
        }
        return RotationTransition(
          turns: _ctrl,
          child: Container(
            alignment: Alignment.center,
            width: maxWidth,
            height: maxWidth,
            constraints: BoxConstraints(
              minHeight: maxWidth,
              maxWidth: maxWidth,
              maxHeight: maxWidth,
              minWidth: maxWidth,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  widget?.track?.logo ??
                      'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png',
                ),
                alignment: AlignmentDirectional.center,
                fit: BoxFit.cover,
              ),
              color: appBlack
            ),
            child: Center(
              child: Container(
                height: subConWidth,
                width: subConWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appBlack,
                ),
                child: Center(
                  child: Container(
                    height: subSubConWidth,
                    width: subSubConWidth,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget?.track?.logo ??
                              'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png',
                        ),
                        alignment: AlignmentDirectional.center,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
