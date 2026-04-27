import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/services/storage/src/storage_constants.dart';
import '../../../core/services/storage/storage_service.dart';
import '../../super/controllers/resources/get/get_controller_interface.dart';
import '../caches/user_cache.dart';
import '../models/user_model.dart';

class UserController extends GetControllerInterface {
  static UserController get get => Get.put(UserController());

  final StorageService<UserModel> _storage = StorageService<UserModel>();

  UserModel? _user;

  UserModel? get user => _user;

  @override
  void onInit() {
    if (UserCache().data == null) {
    } else {
      _user = UserCache().data;
      _storage.listenKey(stgUserModel, (value) {
        _user = UserModel.fromJson(value);
        update();
      });
    }

    super.onInit();
  }

  Future<void> updateUser(UserModel? user) async {
    _user = user;
    if (user != null) {
      await UserCache().saveUser(user);
    }
    update();
    _updateUserInSentry(user);
  }

  void _updateUserInSentry(UserModel? user) {
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
