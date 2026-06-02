import 'dart:async';
import 'dart:developer';

import 'package:coursaty/src/landing/core/url_sync/landing_url_sync.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LandingScrollController extends GetxController {
  final ScrollController scrollController = ScrollController();

  final _sectionKeys = <String, GlobalKey>{};

  final _currentSectionId = RxnString();

  String? get currentSectionId => _currentSectionId.value;
  RxnString get currentSectionIdRx => _currentSectionId;

  late final LandingUrlSync _urlSync;

  // Hysteresis: only commit a new id if it holds for 150ms.
  Timer? _hysteresisTimer;
  String? _pendingSectionId;

  @override
  void onInit() {
    super.onInit();
    _urlSync = LandingUrlSync.create();

    scrollController.addListener(_onScroll);

    _urlSync.listenPopState((id) {
      if (_sectionKeys.containsKey(id)) {
        scrollTo(id, duration: Duration.zero);
      } else {
        log('unknown hash from popstate: $id', name: 'LandingScrollController');
      }
    });

    // Deep-link: wait for sections to register before jumping.
    Timer(const Duration(milliseconds: 500), () {
      final hash = _urlSync.currentHash;
      if (hash != null) {
        if (_sectionKeys.containsKey(hash)) {
          scrollTo(hash, duration: Duration.zero);
        } else {
          log('unknown hash: $hash', name: 'LandingUrlSync');
        }
      }
    });
  }

  void registerSection(String sectionId, GlobalKey key) {
    _sectionKeys[sectionId] = key;
    log('Registered section: $sectionId', name: 'LandingScrollController');
  }

  void unregisterSection(String sectionId) {
    _sectionKeys.remove(sectionId);
  }

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

    _commitSection(sectionId);
  }

  void _onScroll() {
    _detectActiveSection();
  }

  void _detectActiveSection() {
    if (!scrollController.hasClients) return;
    final viewportHeight = scrollController.position.viewportDimension;

    final centerTop = viewportHeight * 0.25;
    final centerBottom = viewportHeight * 0.75;

    String? bestId;
    double bestOverlap = 0;

    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject();
      if (box == null || box is! RenderBox || !box.attached) continue;

      final globalTop = box.localToGlobal(Offset.zero).dy;
      final globalBottom = globalTop + box.size.height;

      final overlapTop = globalTop.clamp(centerTop, centerBottom);
      final overlapBottom = globalBottom.clamp(centerTop, centerBottom);
      final overlap = overlapBottom - overlapTop;

      if (overlap > bestOverlap) {
        bestOverlap = overlap;
        bestId = entry.key;
      }
    }

    if (bestId == null || bestId == _currentSectionId.value) return;

    if (bestId == _pendingSectionId) return;

    _pendingSectionId = bestId;
    _hysteresisTimer?.cancel();
    _hysteresisTimer = Timer(const Duration(milliseconds: 150), () {
      if (_pendingSectionId == bestId) {
        _commitSection(bestId!);
        _pendingSectionId = null;
      }
    });
  }

  void _commitSection(String id) {
    _currentSectionId.value = id;
    _urlSync.updateHash(id);
    log('Active section: $id', name: 'LandingScrollController');
  }

  @override
  void onClose() {
    _hysteresisTimer?.cancel();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _urlSync.dispose();
    super.onClose();
  }
}
