import 'package:flutter/material.dart';

extension SliverExtension on Widget {
  SliverToBoxAdapter asSliver() {
    return SliverToBoxAdapter(
      child: this,
    );
  }


}