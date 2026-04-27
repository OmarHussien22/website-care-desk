part of 'import_image_view.dart';

class ImagesViewPage extends StatefulWidget {
  final List<ImageEntity> images;
  final int? index;

  const ImagesViewPage({super.key, required this.images, this.index});

  @override
  State<ImagesViewPage> createState() => _ImagesViewPageState();
}

class _ImagesViewPageState extends State<ImagesViewPage> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.index ?? 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.get.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: AppInsets.defaultScreenALL,
                padding: EdgeInsets.all(6.toRad()),
                height: 40.toRad(),
                width: 40.toRad(),
                decoration: BoxDecoration(
                  color: AppColors.get.black,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.get.white,
                  ),
                ),
                child: Icon(
                  Icons.close,
                  color: AppColors.get.white,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  Widget image = 0.ESW();

                  if (widget.images[index].type == ImageType.network) {
                    image = ImageGeneric.network(
                      url: widget.images[index].image,
                    );
                  }
                  if (widget.images[index].type == ImageType.file) {
                    image = ImageGeneric.file(
                      fileImage: widget.images[index].image,
                    );
                  }
                  return image;
                },
              ),
            ),
            RowImagesView(images: widget.images,onTap: (index) {
              _pageController.jumpToPage(index);
            },),
          ],
        ),
      ),
    );
  }
}
