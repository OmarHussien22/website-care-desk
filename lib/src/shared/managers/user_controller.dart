import 'package:get/get.dart';
import '../../../packages_index.dart';
import '../../core/services/storage/storage_service.dart';
import '../../core/services/storage/src/storage_constants.dart';
import '../../core/utils/general_utils.dart';
import '../caches/user_cache.dart';
import '../../super/controllers/resources/get/get_controller_interface.dart';
import '../data/models/user_model.dart';
import '../domain/entities/user_entity.dart';

class UserController extends GetControllerInterface {
  static UserController get get => Get.put(UserController());

  final StorageService<UserEntity> _storage = StorageService<UserEntity>();

  UserEntity? _user;

  UserEntity? get user => _user;

  @override
  void onInit() {
    _user = (UserCache().data as UserEntity?) ?? _guest;
    _storage.listenKey(stgUserModel, (value) {
      if (value != null) {
        _user = UserModel.fromJson(value);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          update();
        });
      }
    });
    super.onInit();
  }

  Future<void> updateUser(UserEntity? user) async {

    if (user != null) {
      _user = user;
      await UserCache().saveUser(user);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  deleteUser() {
    _user = null;
    update();
  }

  UserEntity get _guest {
    return UserEntity(
      name: "guest".tr,
      image: "https://static.thenounproject.com/png/65476-200.png",
    );
  }
}
