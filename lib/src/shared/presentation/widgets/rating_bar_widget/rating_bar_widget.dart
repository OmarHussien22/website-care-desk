// import 'package:flutter/material.dart';

// import '../../../../core/styles/colors/app_colors.dart';
// import '../../../../core/utils/extensions/screen_spaces_extension.dart';

// /// Depends on flutter_rating_bar package

// class RatingBarWidget extends StatelessWidget {
//   final double initialRating; 
//   final double reviewsNumber;
//   final double iconSize;
//   final EdgeInsets? itemPadding;
//   final bool isDisabled;
//   final Color? labelColor;
//   final String? date;
//   final Function(double) onRatingUpdate;

//   const RatingBarWidget({
//     super.key,
//     required this.onRatingUpdate,
//     this.initialRating = 0,
//     this.itemPadding,
//     this.isDisabled = false,
//     this.reviewsNumber = 20,
//     this.labelColor,
//     this.date,
//     this.iconSize = 16,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AbsorbPointer(
//       absorbing: isDisabled,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.toH(), horizontal: 0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RatingBar.builder(
//               itemSize: iconSize,
//               initialRating: initialRating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               unratedColor: AppColors.get.third,
//               itemPadding:
//                   itemPadding ?? EdgeInsets.symmetric(horizontal: 3.0.toW()),
//               itemBuilder: (context, _) => Icon(
//                 Icons.star_purple500_outlined,
//                 color: AppColors.get.rateColor,
//                 size: iconSize,
//               ),
//               onRatingUpdate: onRatingUpdate,

//               // cubit.rateProduct(rating),
//             ),
//             //  4.ESW(),
//             //  // CustomText(
//             //  //   "${initialRating.roundToDouble()} ${"starts".tr} (${reviewsNumber.round()} ${"reviews".tr})",
//             //  //   color: labelColor,
//             //  //   fontSize: 11,
//             //  //   fontWeight: FW.regular,
//             //  // ),
//             //  ///
//             //  ConditionalBuilder(
//             //      condition: date==null,
//             //      onBuild:  CustomText(
//             //        '($initialRating)',
//             //        color: AppColor.get.subTitle,
//             //        fontSize: 11,
//             //        fontWeight: FW.regular,
//             //      ) ,
//             //    onFeedBack: CustomText(date!,color: AppColor.g, ),
//             //  )
//             // ,
//           ],
//         ),
//       ),
//     );
//   }
// }
