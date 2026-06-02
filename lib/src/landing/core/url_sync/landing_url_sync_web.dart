import 'dart:async';
import 'dart:developer';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'landing_url_sync.dart';

LandingUrlSync createLandingUrlSync() => _WebUrlSync();

class _WebUrlSync extends LandingUrlSync {
  Timer? _debounce;
  web.EventListener? _popStateListener;

  @override
  String? get currentHash {
    final hash = web.window.location.hash;
    if (hash.isEmpty || hash == '#') return null;
    return hash.startsWith('#') ? hash.substring(1) : hash;
  }

  @override
  void updateHash(String sectionId) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 120), () {
      web.window.history.replaceState(null, '', '#$sectionId');
    });
  }

  @override
  void listenPopState(void Function(String sectionId) callback) {
    _popStateListener = (web.Event event) {
      final hash = web.window.location.hash;
      if (hash.isEmpty || hash == '#') return;
      final id = hash.startsWith('#') ? hash.substring(1) : hash;
      if (id.isEmpty) return;
      log('popstate: navigating to #$id', name: 'LandingUrlSync');
      callback(id);
    }.toJS;
    web.window.addEventListener('popstate', _popStateListener);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (_popStateListener != null) {
      web.window.removeEventListener('popstate', _popStateListener);
      _popStateListener = null;
    }
  }
}
