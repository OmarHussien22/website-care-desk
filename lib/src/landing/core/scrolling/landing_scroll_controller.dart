import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// GetX controller owning the scroll state for the landing page.
///
/// Sections call [registerSection] on mount to expose their [GlobalKey]
/// so the navbar can call [scrollTo] for anchor navigation.
class LandingScrollController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final _sectionKeys = <String, GlobalKey>{};

  final _currentSectionId = RxnString();

  String? get currentSectionId => _currentSectionId.value;

  /// Reactive stream of the currently visible section id.
  RxnString get currentSectionIdRx => _currentSectionId;

  /// Registers a [GlobalKey] for [sectionId]. Called by each section on mount.
  void registerSection(String sectionId, GlobalKey key) {
    _sectionKeys[sectionId] = key;
    log('Registered section: $sectionId', name: 'LandingScrollController');
  }

  /// Unregisters a section key. Called by sections on dispose.
  void unregisterSection(String sectionId) {
    _sectionKeys.remove(sectionId);
  }

  /// Smoothly scrolls to [sectionId] if its key is registered.
  Future<void> scrollTo(
    String sectionId, {
    Duration? duration,
    Curve? curve,
  }) async {
    final key = _sectionKeys[sectionId];
    if (key == null) {
      log('Section not found: $sectionId', name: 'LandingScrollController');
      return;
    }

    final context = key.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: duration ?? const Duration(milliseconds: 700),
      curve: curve ?? Curves.easeInOutCubic,
    );

    _currentSectionId.value = sectionId;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
