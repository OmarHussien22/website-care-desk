// import 'package:flutter/material.dart';
// import 'package:coursaty/src/core/styles/colors/app_colors.dart';
// import 'package:coursaty/src/core/utils/general_utils.dart';
// import 'package:coursaty/src/core/utils/utils.dart';
// import 'package:coursaty/src/shared/presentation/widgets/animation/animated_wrapper.dart';
//  import 'package:coursaty/src/shared/presentation/widgets/general_widgets/spacespackage:coursaty/src/shared/presentation/widgets/general_widgets/spacespackage:coursaty/src/shared/presentation/widgets/general_widgets/spacespackage:coursaty/src/shared/presentation/widgets/general_widgets/spacespackage:coursaty/src/shared/presentation/widgets/general_widgets/spacespackage:coursaty/src/shared/presentation/widgets/general_widgets/spacespackage:coursaty/src/shared/presentation/widgets/general_widgets/spacespackage:coursaty/src/Shared/Presentation/Widgets/GeneralWidgets/spaces_dividers/spaces.dartdividers/spaces.dartdividers/spaces.dartdividers/spaces.dartdividers/spaces.dartdividers/spaces.dartdividers/spaces.dartdividers/spaces.dart';
// import 'package:coursaty/src/shared/presentation/widgets/general_widgets/text/custom_text_lib.dart';
// import 'package:get/get.dart';
// Offset position = const Offset(20.0, 20.0);
// class DraggableFloatingActionButton extends StatelessWidget {
//
//   const DraggableFloatingActionButton(
//       {
//         Key? key,
//       }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, setState) {
//       return Positioned(
//           left: position.dx,
//           top: position.dy,
//           child: Draggable(
//               child: Stack(
//                 children: [
//                   Visibility(
//                     visible: true,
//                     replacement: AnimatedWrapper(
//                       child: ListView.builder(
//                         itemCount:  1,
//                         itemBuilder: (context, index) {
//
//                            return Row(
//                             children: [
//                               Image.asset(
//                                 Assets.noNotifications,
//
//                                 scale: 4,
//                               ),
//                               XSpace.light,
//                               CustomText.subtitle(
//                                 "controller.markers[index].infoWindow.title!",
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     child: FloatingActionButton(
//                       backgroundColor: AppColors.get.primary,
//                       child: const ImageIcon(
//                         const AssetImage(Assets.audio),
//                       ),
//                       onPressed: () {
//                         Get.dialog(
//                           Align(
//                             alignment: Alignment.bottomLeft,
//                             child: Center(
//                               child: Dialog(
//                                 backgroundColor: Colors.transparent,
//                                 elevation: 0.0,
//                                 child: AnimatedWrapper(
//                                   child: ListView.builder(
//                                     itemCount: 12,
//                                     shrinkWrap: true,
//                                     itemBuilder: (context, index) {
//
//
//                                       return Row(
//                                         children: [
//                                           Image.asset(
//                                             Assets.search,
//                                             scale: 4,
//                                           ),
//                                           XSpace.light,
//                                           CustomText.subtitle(
//                                              "testtt"
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   CustomText.subtitle(
//                     "x  ",
//                     padding: EdgeInsets.all(5.0),
//                     color: AppColors.get.white,
//                   ),
//                 ],
//               ),
//               feedback: FloatingActionButton(
//                 backgroundColor: AppColors.get.primary.toOpacityColor(0.7),
//                 child:   ImageIcon(
//                   AssetImage(Assets.audio ),
//                 ),
//                 onPressed: () {},
//               ),
//               childWhenDragging: SizedBox.shrink(),
//               onDragEnd: (details) {
//                 setState(() {
//                   position = details.offset;
//                 });
//                 printDM("position=>$position");
//                 printDM("position=>${position.dx}");
//                 printDM("position=>${position.dy}");
//               }));
//     });
//   }
// }
