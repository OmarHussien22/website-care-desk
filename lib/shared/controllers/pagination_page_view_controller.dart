import 'package:flutter/widgets.dart';

import '../../super/controllers/resources/get/get_controller_interface.dart';

abstract class PaginationPageViewController<T>
    extends GetControllerInterface<T> {
  bool paginationLoading = false;

  late PageController pageController;

  int get fetchCurrentPage {
    if (state.pagination != null) {
      return state.pagination!.current! + 1;
    } else {
      return 1;
    }
  }

  Future<void> fetchPlacementQuestions() async {}

  Future<void> setFetchPaginationFunction(
      {int? page, bool onRefresh = false}) async {}

  bool get canLoading {
    if (state.pagination != null) {
      return false;
    } else {
      return true;
    }
  }

  bool get canLoadMore {
    if (state.pagination != null) {
      return state.pagination!.last! > state.pagination!.current!;
    }
    return false;
  }

  // void pageListener() {
  //   pageController.addListener(() async {
  //     final page = pageController.page?.round() ?? 0;
  //     if (page >= 10 && canLoadMore && !paginationLoading) {
  //       paginationLoading = true;
  //       update();
  //       await setFetchPaginationFunction();
  //       paginationLoading = false;
  //
  //       update();
  //     }
  //   });
  // }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    // pageListener();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
