import 'package:coursaty/src/landing/core/url_sync/landing_url_sync_stub.dart'
    if (dart.library.js_interop) 'package:coursaty/src/landing/core/url_sync/landing_url_sync_web.dart';

/// Interface + factory for URL hash synchronisation.
/// On web: reads/writes window.location.hash, listens to popstate.
/// On native: all methods are no-ops.
abstract class LandingUrlSync {
  const LandingUrlSync();

  factory LandingUrlSync.create() => createLandingUrlSync();

  /// Returns the current hash fragment (without leading `#`), or null.
  String? get currentHash;

  /// Replaces the location hash with `#[id]` (debounced to 120ms internally).
  void updateHash(String sectionId);

  /// Registers a [callback] to be called when the browser navigates
  /// back/forward and the hash changes.
  void listenPopState(void Function(String sectionId) callback);

  /// Cleans up any listeners.
  void dispose();
}
