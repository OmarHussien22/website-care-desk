part of 'imports_customizable.dart';

/// Confirmed

class ButtonBack extends StatelessWidget {
  final Color? color;

  const ButtonBack({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: AppSizes.iconRad.toRad(),
      onPressed: () {
        context.back();
      },
      icon: Container(
        margin: EdgeInsets.all(2.toW()),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(12.toW()),
          color: AppColors.get.white,
          shape: BoxShape.circle,
          border: Border.all(

            color: AppColors.get.black,
          ),
        ),
        child: Icon(
          Icons.arrow_back,
          color: color,
          size: AppSizes.iconRad.toRad(),
        ),
      ),
    );
  }
}
