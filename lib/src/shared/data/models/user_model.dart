import 'package:coursaty/src/core/utils/extensions/json_parsing_extension.dart';
import 'package:coursaty/src/core/utils/general_utils.dart';

import '../../../core/app/app_settings.dart';
import '../../domain/entities/education_type_enum.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.name,
    super.phone,
    super.apiToken,
    super.isVerify,
    super.image,
    super.code,
    super.email,
    super.userType,
    super.birthDay,
    super.gender,
    super.city,
    super.badge,
    super.countryCode,
    super.isBlocked,
    super.verificationCode,
    super.allowNotification,
    super.isActive,
    super.address,
    super.deviceToken,
    super.deviceId,
    super.deviceType,
    super.version,
    super.isApproved,
    super.isExist,
    super.educationType,
    super.isCompleteData,
    super.foundationName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    printDM("************UserModel.fromMap(map)************");
    id = json.parseInt('id');
    printDM("id => $id ");
    name = json.parseString('name');
    printDM("name => $name ");
    phone = json.parseString('phone');
    printDM("phone => $phone ");
    countryCode = json.parseString('phone_code');
    printDM("phone_code => $countryCode ");
    apiToken = json.parseString('api_token');
    printDM("api_token => $apiToken ");
    isVerify = json.parseBool('is_verified');
    printDM("is_verified => $isVerify ");
    image = json.parseString('image');
    printDM("image => $image");
    badge = json.parseString('badge');
    printDM("badge => $badge");
    code = json.parseString('code');
    printDM("code => $code");
    email = json.parseString('email');
    printDM("email => $email");
    isBlocked = json.parseBool('is_blocked');
    printDM("isBlocked => $isBlocked");
    isActive = json.parseBool('is_active');
    printDM("isActive => $isActive");
    address = json.parseString('address');
    printDM("address => $address");
    deviceToken = json.parseString('device_token');
    printDM("deviceToken => $deviceToken");
    deviceId = json.parseString('device_id');
    printDM("deviceId => $deviceId");
    deviceType = json.parseString('device_type');
    printDM("deviceType => $deviceType");
    version = json.parseString('version');
    printDM("version => $version");
    isApproved = json.parseBool('is_approved');
    printDM("isApproved => $isApproved");
    allowNotification = json.parseBool('allow_notification');
    printDM("allow_notification => $allowNotification");
    isExist = json.parseBool('is_exist');
    printDM("is_exist => $isExist");
    isCompleteData = json.parseBool('is_complete_data');

    if (AppSettings.appEducationType == AppEducationType.all) {
      educationType = EducationTypeFactory.toEnum(
        json.parseInt('education_type'),
      );
    } else {
      // educationType = AppSettings.appEducationType;
    }
    printDM("is_exist => $educationType");
    foundationName = json.parseString("foundation_name");
  }
}
