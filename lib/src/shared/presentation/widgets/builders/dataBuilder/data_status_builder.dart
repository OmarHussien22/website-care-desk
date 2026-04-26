part of 'imports_data_builder.dart';

class DataStatusBuilder extends StatelessWidget {
  final DataState status;
  final Widget? initialBuild;
  final Widget onDoneBuild;
  final Widget? onConnectionErrorBuild;
  final Widget? onErrorBuild;
  final Widget? onLoadingBuild;
  final VoidCallback? onRedirect;
  final bool isOnRefreshed;
  final bool useSkeletonLoader;
  final double? heightRatio;
  final bool? isFullScreen;
  const DataStatusBuilder({
    super.key,
    required this.status,
    required this.onDoneBuild,
    this.onConnectionErrorBuild,
    this.initialBuild,
    this.onErrorBuild,
    this.onLoadingBuild,
    this.onRedirect,
    this.isOnRefreshed = false,
    this.useSkeletonLoader = false,
    this.heightRatio,
    this.isFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    Widget? widget = const SizedBox.shrink();
    if (status is DataInitial) {
      widget = initialBuild ?? const SizedBox.shrink();
    } else if (status is DataLoading) {
      if (useSkeletonLoader) {
        widget = isOnRefreshed
            ? const SizedBox.shrink()
            : Skeletonizer(
                enabled: true,
                child: onDoneBuild,
              );
      } else {
        widget = onLoadingBuild ??
            (isOnRefreshed
                ? const SizedBox.shrink()
                : AppLoader(
                    heightRatio: heightRatio,
                    isFullScreen: isFullScreen,
                  ));
      }
    } else if (status is DataSuccess) {
      widget = onDoneBuild;
    } else if (status is DataFailed) {
      widget = onErrorBuild ??
          _DataFailedBuilder(
            error: status.error,
            onRedirect: onRedirect,
          );
    } else {
      widget = onLoadingBuild ??
          (isOnRefreshed ? const SizedBox.shrink() : const AppLoader());
    }
    return widget;
  }
}
