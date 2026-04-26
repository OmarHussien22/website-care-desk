import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../utils/general_utils.dart';

class RemoteConfigService {
  RemoteConfigService._();

  static final RemoteConfigService instance = RemoteConfigService._();

  static const String _baseUrlKey = 'base_url';
  static final RemoteConfigSettings _settings = RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(minutes: 15),
  );

  FirebaseRemoteConfig get _remoteConfig => FirebaseRemoteConfig.instance;

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    await _remoteConfig.setConfigSettings(_settings);
    await _remoteConfig.setDefaults(const <String, dynamic>{
      _baseUrlKey: '',
    });
    await _remoteConfig.ensureInitialized();
    _initialized = true;
  }

  Future<bool> fetchAndActivate() async {
    await initialize();
    try {
      final bool activated = await _remoteConfig.fetchAndActivate();
      printDM('RemoteConfig fetchAndActivate: $activated');
      return activated;
    } catch (e) {
      printDM('RemoteConfig fetch failed: $e');
      return false;
    }
  }

  Future<String> getFallbackBaseUrl({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await fetchAndActivate();
    } else {
      await initialize();
    }

    return _normalizeBaseUrl(_remoteConfig.getString(_baseUrlKey));
  }

  String _normalizeBaseUrl(String value) {
    final String trimmed = value.trim();
    if (trimmed.isEmpty) return '';
    return trimmed.endsWith('/') ? trimmed : '$trimmed/';
  }
}

class FireRemoteConfigService {
  FireRemoteConfigService._();

  static final FireRemoteConfigService instance =
      FireRemoteConfigService._();

  Future<void> getRemoteData() async {
    await RemoteConfigService.instance.fetchAndActivate();
  }
}
