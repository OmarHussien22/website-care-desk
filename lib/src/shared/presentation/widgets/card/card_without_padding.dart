import 'package:flutter/material.dart';

class CardWithoutPadding extends StatelessWidget {
  final BuildContext buildContext;
  final Widget child;


  const CardWithoutPadding({super.key, required this.buildContext, required this.child});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(context: buildContext,


        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        removeTop: true,

        child: child);
  }
}
