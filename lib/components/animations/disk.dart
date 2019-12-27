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
    return RotationTransition(
      turns: widget.ctrl,
      child: Container(
        width: 200,
        height: 200,
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
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_jOaO2EBV-jBMOEdkGp8NtQIY8UakejJhbGnZH7_MHy49XFgXhQ&s'),
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
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_jOaO2EBV-jBMOEdkGp8NtQIY8UakejJhbGnZH7_MHy49XFgXhQ&s'),
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
