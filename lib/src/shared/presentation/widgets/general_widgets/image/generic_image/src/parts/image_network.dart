part of 'imports_parts.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final ImageOptions? options;

  const ImageNetwork({
    Key? key,
    required this.url,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: options?.scale ?? 1,
      child: Container(
        height: (options?.radius ?? options?.height)?.toH(),
        width: (options?.radius ?? options?.width)?.toW(),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: options?.backgroundColor ,
          borderRadius: options?.borderRadius,
          shape: options?.radius != null ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: CachedNetworkImage(
          imageUrl: url,
          width: (options?.radius ?? options?.width)?.toW(),
          height: (options?.radius ?? options?.height)?.toH(),

          fadeInCurve: Curves.easeInBack,
          placeholder: (context, url) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.1,
            child: const AppLoader(),
          ),

          fit: options?.fit,
          errorWidget: (context, url, error) {
            printDM(error.toString(), name: 'ImageNetwork');

            return Center(
              child: Image.asset(
                options?.onNetworkErrorImage ??AppBasicIcons.logo,
                fit: BoxFit.cover,
                height: options?.height?.toH(),
                width: options?.width?.toW(),
              ),
            );
          },
          // Center(child: const Icon(Icons.error, color: AppColors.errorColor)),
        ),
      ),
    );
  }
}
