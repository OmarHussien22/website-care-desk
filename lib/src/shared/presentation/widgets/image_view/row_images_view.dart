part of 'import_image_view.dart';

class RowImagesView extends StatelessWidget {
  final Function(int) onTap;
  final List<ImageEntity> images;

  const RowImagesView({super.key, required this.images, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.toH(),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var options = ImageOptions(
                fit: BoxFit.cover,
                height: 75,
                width: 75,
                borderRadius: BorderRadius.circular(10.toRad()));
            Widget image = 0.ESW();

            if (images[index].type == ImageType.network) {
              image = ImageGeneric.network(
                url: images[index].image,
                options: options,
              );
            }
            if (images[index].type == ImageType.file) {
              image = ImageGeneric.file(
                fileImage: images[index].image,
                options: options,
              );
            }
            return InkWell(
                onTap: () {
                  onTap(index);
                },
                child: image);
          },
          separatorBuilder: (context, index) => 10.ESW(),
          itemCount: images.length),
    );
  }
}
