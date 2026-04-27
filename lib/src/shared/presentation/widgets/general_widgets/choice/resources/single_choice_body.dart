import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../../../../domain/entities/title_interface.dart';
import '../components/choice_single_row.dart';

class SingleChoiceBody<T extends TitleInterface> extends StatelessWidget {
  final int selectedId;
  final Function(T) onSave;
  final List<T> items;
  final Widget Function(T item, [int? index])? builder;
  final bool isScrollable;
  const SingleChoiceBody({
    super.key,
    required this.selectedId,
    required this.onSave,
    required this.items,
    this.builder,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: !isScrollable,
      physics: isScrollable
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.toW()),
          child: ChoiceSingleRow<T>(
            builder: builder != null ? builder!(items[index],index) : null,
            active: selectedId == items[index].id,
            item: items[index],
            onTap: () {
              onSave(items[index]);
            },
          )),
      separatorBuilder: (context, index) => 2.ESH(),
      itemCount: items.length,
    );
  }
}
