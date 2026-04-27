part of 'imports_illustrations.dart';

class IllustrationNoConnectionScreen extends StatelessWidget {
  final VoidCallback? onRedirect;

  const IllustrationNoConnectionScreen({
    Key? key,
    this.onRedirect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IllustrationPageBuilder(
      title: "illustration_no_connection",
      body: "illustration_no_connection_details",
      imageUrl: AppImages.noImage,
      showRedirectIcon: false,
      onRedirect: onRedirect ??
          () {
            context.back();
          },
    );
  }
}
