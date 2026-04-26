import 'deviceInfo/device_info_service.dart';
import 'firebase/firebase_service.dart';
import 'fireRemoteConfig/fire_remote_config_service.dart';
import 'imageCropper/image_cropper.dart';
import 'lang/localization_services.dart';
import 'launcher/launcher_service.dart';
import 'mediaPicker/imports_media_picker.dart';
import 'networkConnection/network_service.dart';
import 'package_info/package_info.dart';
import 'screenshot/screenshot_service.dart';
import 'showcase/showcase_service.dart';
import 'storage/storage_service.dart';
import 'upgrade/pin_code_service.dart';
import 'wakelock_service.dart';

class Helper {
  Helper._();

  static final NetworkConnectionService connectivity =
      NetworkConnectionService.instance;

  static final FirebaseService firebase = FirebaseService.instance;

  static final RemoteConfigService remoteConfig = RemoteConfigService.instance;

  static final DeviceInfoService deviceInfo = DeviceInfoService.instance;

  static final LocalizationServices lang = LocalizationServices.instance;

  static final LauncherServices launcher = LauncherServices.instance;

  static final MediaPickerService media = MediaPickerService.instance;

  static final ImageCropperService imageCropper = ImageCropperService.instance;

  static final ScreenShotService screenShot = ScreenShotService.instance;

  static final ShowcaseService showcase = ShowcaseService.instance;

  static final PackageInfoService packageInfo = PackageInfoService.instance;

  static final PinCodeService pinCode = PinCodeService.instance;

  static final WakelockService wakelock = WakelockService.instance;

  static StorageService<T> storage<T>() => StorageService<T>();
}
