import 'package:carbon_counter/base/base.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class FlareAnimation extends StatelessWidget {
  final double height;
  final CalculationAnimationType animationType;
  final bool animate;
  final FlareControls flareController;

  static const String path = 'assets/flares/';

  FlareAnimation({
    this.height,
    @required this.animationType,
    this.flareController,
    @required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    if (animationType == null) {
      return Container();
    }
    String name = enumToString(animationType);
    return Container(
      child: FlareActor(
        '$path$name.flr',
        fit: BoxFit.fitHeight,
        animation: name,
        controller: flareController,
        isPaused: !animate,
      ),
    );
  }
}
