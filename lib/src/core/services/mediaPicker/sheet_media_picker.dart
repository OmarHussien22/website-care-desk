part of 'imports_media_picker.dart';

class SheetMediaPicker extends StatelessWidget {
  const SheetMediaPicker({
    super.key,
    required this.onCameraPicked,
    required this.onGalleryPicked,
    required this.type,
  });

  final VoidCallback onCameraPicked;
  final VoidCallback onGalleryPicked;
  final MediaPickedType type;

  @override
  Widget build(BuildContext context) {
    return _PickerSheet(
      title: type == MediaPickedType.multi
          ? 'pick_media'.toTr()
          : 'pick_image'.toTr(),
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined),
          title: Text('camera'.toTr()),
          onTap: onCameraPicked,
        ),
        ListTile(
          leading: const Icon(Icons.photo_library_outlined),
          title: Text('gallery'.toTr()),
          onTap: onGalleryPicked,
        ),
      ],
    );
  }
}

class _PickerSheet extends StatelessWidget {
  const _PickerSheet({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
