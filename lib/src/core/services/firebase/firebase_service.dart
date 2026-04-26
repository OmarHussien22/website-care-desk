import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  Future<FirebaseApp?> initialize({FirebaseOptions? options}) async {
    if (Firebase.apps.isNotEmpty) {
      return Firebase.app();
    }

    try {
      return await Firebase.initializeApp(options: options);
    } catch (_) {
      return Firebase.apps.isNotEmpty ? Firebase.app() : null;
    }
  }
}
