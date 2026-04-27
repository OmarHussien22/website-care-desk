part of 'imports_media_picker.dart';

class SheetMultiMediaPicker extends StatelessWidget {
  const SheetMultiMediaPicker({
    super.key,
    required this.onMultiSelect,
    required this.onSingleSelect,
  });

  final VoidCallback onMultiSelect;
  final VoidCallback onSingleSelect;

  @override
  Widget build(BuildContext context) {
    return _PickerSheet(
      title: 'pick_media'.toTr(),
      children: [
        ListTile(
          leading: const Icon(Icons.photo_outlined),
          title: Text('pick_single'.toTr()),
          onTap: onSingleSelect,
        ),
        ListTile(
          leading: const Icon(Icons.collections_outlined),
          title: Text('pick_multiple'.toTr()),
          onTap: onMultiSelect,
        ),
      ],
    );
  }
}
