part of 'imports_data_builder.dart';

class BottomRequestStatusBuilder extends StatelessWidget {
  final DataState status;
  final Widget bottomWidget;

  const BottomRequestStatusBuilder({
    super.key,
    required this.status,
    required this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    Widget? widget;
    if (status is DataInitial) {
      widget = bottomWidget;
    } else if (status is DataLoading) {
      widget = const AppLoader();
    } else if (status is DataFailed) {
      printDM("status.error!.errorType is ${status.error!.type}");
      if (status.error!.type == ErrorType.networkConnection) {
        widget = bottomWidget;
        AppSnacks().showSnack(state: UtilState.warning);
      } else if (status.error!.type == ErrorType.dirtyData) {
        widget = bottomWidget;
        AppSnacks().showSnack(
          title: status.error!.title,
          state: UtilState.error,
        );
      } else {
        widget = bottomWidget;
      }
    } else {
      widget = bottomWidget;
    }
    return widget;
  }
}
