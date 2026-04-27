import '../../../../../../packages_index.dart';
import '../../../../../core/utils/extensions/screen_spaces_extension.dart';
import '../../general_widgets/image/generic_image/src/generic_image_lib.dart';
import '../../general_widgets/image/generic_image/src/options/image_options.dart';
import '../../general_widgets/text/custom_text_lib.dart';

class CustomBottomNavItem extends StatelessWidget {

  final String  image;
  final String  label;
  final double size;
  final Color color;


  const CustomBottomNavItem({super.key, required this.image, required this.size, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ImageGeneric.svg(
        url: image,
        options: ImageOptions(
          color:color ,
          height:size,
          width: size,
        ),
      ),
      3.ESH(),
      CustomText(
         label,
        fontSize: 10,
        color: color,
      )
      ],
    ) ;
  }
}
