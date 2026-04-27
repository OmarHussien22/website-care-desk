import 'package:coursaty/src/core/utils/extensions/screen_spaces_extension.dart';
import 'package:coursaty/src/shared/presentation/widgets/builders/conditional_builder.dart';
import 'package:coursaty/src/shared/presentation/widgets/loading/loading.dart';
import 'package:flutter/material.dart';

class PaginationLoading extends StatelessWidget {
  final bool paginationLoading;
  final bool isDark;
  const PaginationLoading({
    required this.paginationLoading,
    this.isDark = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: paginationLoading,
      onBuild: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.toH()),
          child: Loading.pulse(),
        ),
      ),
      onFeedBack: const SizedBox(),
    );
  }
}
