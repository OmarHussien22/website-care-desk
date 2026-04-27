part of 'imports_illustration_builder.dart';

class IllustrationPageBuilder extends StatelessWidget {
  final String? title;
  final String? body;
  final String? redirectLabel;
  final String imageUrl;
  final String redirectImageUrl;
  final VoidCallback? onRedirect;
  final Widget? customButton;
  final bool reverseRedirectChildrenOrder;
  final bool showRedirectIcon;
  final bool isImageSVG;
  final double? width;
  final double? height;
  final String? subtitle;
  final double? fontSizeTitle;
  final double? buttonHeight;
  final Color? subTitleColor;
  final FW? subTitleFW;
  const IllustrationPageBuilder({
    Key? key,
    this.title,
    this.body,
    this.redirectLabel,
    required this.imageUrl,
    this.redirectImageUrl = "",
    this.onRedirect,
    this.showRedirectIcon = true,
    this.customButton,
    this.reverseRedirectChildrenOrder = false,
    this.width,
    this.height,
    this.subtitle,
    this.fontSizeTitle,
    this.buttonHeight,
    this.isImageSVG = false,
    this.subTitleColor,
    this.subTitleFW,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     ///
        //     Image.asset(
        //       imageUrl,
        //       // height: 150.toH(),
        //       // width: 150.toW(),
        //       width: 84.toW(),
        //       height: 59.toH(),
        //       fit: BoxFit.cover,
        //     ),
        //     Image.asset(
        //       Assets.imageOuter,
        //       width: 170.toW(),
        //       fit: BoxFit.cover,
        //     ),
        //   ],
        // ),
        isImageSVG
            ? ImageGeneric.svg(
                url: imageUrl,
                options: ImageOptions(
                  width: (width ?? 84).toW(),
                  height: (height ?? 59).toH(),
                  fit: BoxFit.contain,
                ),
              )
            : ImageGeneric.asset(
                url: imageUrl,
                options: ImageOptions(
                  width: (width ?? 84).toW(),
                  height: (height ?? 59).toH(),
                  fit: BoxFit.contain,
                ),
              ),
        25.8.ESH(),
        if (title != null) ...[
          CustomText(
            "$title",
            fontSize: fontSizeTitle ?? 16,
            fontWeight: FW.bold,
            color: AppColors.get.black,
            textAlign: TextAlign.center,
          ),
          16.0.ESH(),
        ],
        CustomText(
          subtitle ?? '',
          fontSize: 14,
          fontWeight: subTitleFW ?? FW.regular,
          color: subTitleColor ?? AppColors.get.grey,
          textAlign: TextAlign.center,
        ),
        if (body != null)
          CustomText.subtitle(
            body ?? "",
            padding: EdgeInsets.symmetric(horizontal: 30.0.toW()),
            fontSize: 14,
            fontWeight: FW.regular,
            color: AppColors.get.grey,
            textAlign: TextAlign.center,
          ),
        // if (onRedirect != null) ...[
        //   16.0.ESH(),
        //   RedirectionButton(
        //     showIcon: showRedirectIcon,
        //     padding: const EdgeInsets.symmetric(horizontal: 90.0),
        //     label: redirectLabel ?? "retry".tr,
        //     imageUrl: redirectImageUrl,
        //     onPressed: onRedirect,
        //   ),
        // ],
        24.ESH(),
        if (customButton != null || onRedirect != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ConditionalBuilder(
              condition: customButton != null,
              onBuild: customButton ?? const SizedBox.shrink(),
              onFeedBack: onRedirect != null
                  ? Column(
                      children: [
                        16.0.ESH(),
                        ButtonRedirection(
                          height: buttonHeight ?? 40.toH(),
                          reverseOrder: reverseRedirectChildrenOrder,
                          showIcon: showRedirectIcon,
                          padding: EdgeInsets.symmetric(horizontal: 90.0.toW()),
                          label: redirectLabel ?? "retry".tr,
                          imageUrl: redirectImageUrl,
                          onPressed: onRedirect,
                        ),
                      ],
                    )
                  : null,
            ),
          ),
      ],
    );
  }
}
