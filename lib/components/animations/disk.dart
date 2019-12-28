import 'package:flutter/material.dart';
import 'package:marconi_radio/models/station.dart';
import 'package:marconi_radio/styles/colors.dart';

class AppDisk extends StatefulWidget {
  final Station track;
  final AnimationController ctrl;

  AppDisk(this.track, this.ctrl);

  @override
  State<StatefulWidget> createState() {
    return _AppDiskState();
  }
}

class _AppDiskState extends State<AppDisk> with SingleTickerProviderStateMixin {
  // @override
  // void dispose() {
  //   super.dispose();
  //   widget.ctrl.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.width;
    final w = x <= 100 ? 50 : x <= 200 ? 100 : x <= 300 ? 150 : x <= 400 ? 200.0 : x <= 600 ? 300.0 : 400.0; 
    return RotationTransition(
      turns: widget.ctrl,
      child: Container(
        alignment: Alignment.center,
        width: w,
        height: w,
        constraints: BoxConstraints(minHeight: w, maxWidth: w, maxHeight: w, minWidth: w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              appBlack,
              appAsh,
            ],
          ),
          image: DecorationImage(
            image: NetworkImage(widget.track.logo ??
                'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png',),
            alignment: AlignmentDirectional.center,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appBlack,
            ),
            child: Center(
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.track.logo ??
                        'https://res.cloudinary.com/jesse-dirisu/image/upload/v1577453507/marconixl.png',),
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
  }
}
