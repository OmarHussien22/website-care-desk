// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../constants/strings/app_strings.dart';
// import '../../styles/colors/app_colors.dart';
// import '../utils/extensions/screen_spaces_extension.dart';

// class PinCodeService {
//   PinCodeService._();

//   static final PinCodeService instance = PinCodeService._();

//   Widget pinCodeWidget({
//     Function(String)? onChanged,
//     int fieldCounts = 6,
//     double fieldWidth = 50.0,
//     required BuildContext context,
//     required TextEditingController textEditingController,
//     required StreamController<ErrorAnimationType> errorController,
//   }) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 2.toH()),
//         child: PinCodeTextField(
//           enablePinAutofill: true,
//           keyboardType: TextInputType.number,
//           cursorColor: const Color(0xff4E70DB),
//           appContext: context,
//           length: fieldCounts,
//           obscureText: false,
//           pastedTextStyle: TextStyle(
//             color: AppColors.get.title,
//             fontSize: 15.sp,
//             fontFamily: AppStrings.fontFamily,
//           ),
//           animationType: AnimationType.fade,
//           pinTheme: PinTheme(
//             shape: PinCodeFieldShape.circle,
//             inactiveColor: Colors.transparent,
//             inactiveFillColor: const Color(0xffF3F4F6),
//             activeColor: AppColors.get.primary,
//             disabledColor: Colors.black,
//             selectedFillColor: const Color(0xffF3F4F6),
//             selectedColor: AppColors.get.primary,
//             fieldHeight: 60.toH(),
//             fieldWidth: fieldWidth.toW(),
//             activeFillColor: Colors.white,
//           ),
//           animationDuration: const Duration(milliseconds: 300),
//           backgroundColor: Colors.transparent,
//           enableActiveFill: true,
//           errorAnimationController: errorController,
//           controller: textEditingController,
//           onCompleted: (_) {},
//           onChanged: onChanged ?? (_) {},
//           beforeTextPaste: (_) => true,
//         ),
//       ),
//     );
//   }
// }
