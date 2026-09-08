import 'landing_url_sync.dart';

/// Native no-op implementation of [LandingUrlSync].
LandingUrlSync createLandingUrlSync() => const _StubUrlSync();

class _StubUrlSync extends LandingUrlSync {
  const _StubUrlSync();

  @override
  String? get currentHash => null;

  @override
  void updateHash(String sectionId) {}

  @override
  void listenPopState(void Function(String sectionId) callback) {}

  @override
  void dispose() {}
}
