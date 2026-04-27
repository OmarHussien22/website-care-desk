import '../../../packages_index.dart';
import '../../core/styles/colors/app_colors.dart';
import '../../core/utils/extensions/color_extension.dart';
import 'widgets/app_bars/app_bars.dart';
import 'widgets/general_widgets/image/generic_image/generic_image.dart';

class ImagePage extends StatelessWidget {
  final String image;

  const ImagePage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.basic(),
      backgroundColor: AppColors.get.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5,
                    child: ImageGeneric.network(url: image))),
          ],
        ),
      ),
    );
  }
}
