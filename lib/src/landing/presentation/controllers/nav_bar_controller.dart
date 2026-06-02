import 'dart:developer';

import 'package:coursaty/src/landing/core/scrolling/landing_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  static const double _scrollThreshold = 24.0;

  final RxBool isDrawerOpen = false.obs;
  final RxBool scrolledPastThreshold = false.obs;

  late final ScrollController _scrollController;

  @override
  void onInit() {
    super.onInit();
    _scrollController = Get.find<LandingScrollController>().scrollController;
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final past = _scrollController.hasClients &&
        _scrollController.offset > _scrollThreshold;
    if (past != scrolledPastThreshold.value) {
      scrolledPastThreshold.value = past;
    }
  }

  void openDrawer() {
    log('NavBarController: drawer opened', name: 'NavBar');
    isDrawerOpen.value = true;
  }

  void closeDrawer() {
    log('NavBarController: drawer closed', name: 'NavBar');
    isDrawerOpen.value = false;
  }

  void navigateTo(String sectionId) {
    closeDrawer();
    Get.find<LandingScrollController>().scrollTo(sectionId);
  }

  @override
  void onClose() {
    _scrollController.removeListener(_onScroll);
    super.onClose();
  }
}
