part of 'imports_parts.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final ImageOptions? options;
  final String? placeHolder;

  const ImageNetwork({
    super.key,
    required this.url,
    this.options,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty && placeHolder != null) {
      return ImageAsset(
        url: placeHolder!,
        options: options,
      );
    }
    return Transform.scale(
      scale: options?.scale ?? 1,
      child: Container(
        height: (options?.radius ?? options?.height)?.toH(),
        width: (options?.radius ?? options?.width)?.toW(),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: options?.borderRadius,
          shape: options?.radius != null ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: CachedNetworkImage(
          imageUrl: url,
          fadeInCurve: Curves.easeInBack,
          placeholder: (context, url) => SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
            width: MediaQuery.sizeOf(context).height * 0.1,
            child: const AppLoader(),
          ),
          fit: options?.fit,
          errorWidget: (context, url, error) {
            //  printDM(error.toString(), name: 'ImageNetwork');

            return Center(
              child: ImageAsset(
                url: placeHolder ??
                    options?.onNetworkErrorImage ??
                    AppBasicIcons.appIcon,
                options: ImageOptions(
                  height: options?.height,
                  width: options?.width,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
          // Center(child: const Icon(Icons.error, color: AppColors.errorColor)),
        ),
      ),
    );
  }
}
