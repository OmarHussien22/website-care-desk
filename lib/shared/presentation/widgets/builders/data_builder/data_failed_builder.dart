part of 'imports_data_builder.dart';

class _DataFailedBuilder extends StatelessWidget {
  final ErrorModel? error;
  final VoidCallback? onRedirect;

  const _DataFailedBuilder({
    required this.error,
    this.onRedirect,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleErrorHandlerBuilder(error: error);
  }
}
