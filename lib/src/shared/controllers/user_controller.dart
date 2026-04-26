import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../core/services/storage/src/storage_constants.dart';
import '../../core/services/storage/storage_service.dart';
import '../../features/auth/data/models/user.dart';
import '../../super/controllers/resources/get/get_controller_interface.dart';
import '../caches/user_cache.dart';

class UserController extends GetControllerInterface {
  static UserController get get => Get.put(UserController());

  final StorageService<User> _storage = StorageService<User>();

  User? _user;

  User? get user => _user;

  @override
  void onInit() {
    if (UserCache().data == null) {
    } else {
      _user = UserCache().data;
      _storage.listenKey(stgUserModel, (value) {
        _user = User.fromJson(value);
        update();
      });
    }

    super.onInit();
  }

  Future<void> updateUser(User? user) async {
    _user = user;
    if (user != null) {
      await UserCache().saveUser(user);
    }
    update();
    _updateUserInSentry(user);
  }

  void _updateUserInSentry(User? user) {
    if (user == null) return;
    Sentry.configureScope((scope) {
      scope.setUser(
        SentryUser(
          id: user.id?.toString(),
          email: user.email,
          username: user.name,
          data: {
            'phone': user.phone,
            'image': user.image,
            'isVerified': user.isVerified,
            'categoryId': user.categoryId,
            'categoryTitle': user.categoryTitle,
            'isInfoComplete': user.isInfoComplete,
            'type': user.type,
            'isBlocked': user.isBlocked,
            'countryCode': user.countryCode,
            'address': user.address,
            'isDeviceEmulator': user.isDeviceEmulator,
            'isVisitor': user.isVisitor,
            "parentName": user.parentName,
            "parentPhone": user.parentPhone,
            "apiToken": user.apiToken,
            "verificationCode": user.verificationCode,
            "approvalStatus": user.approvalStatus?.name,
          },
        ),
      );
    });
  }
}
