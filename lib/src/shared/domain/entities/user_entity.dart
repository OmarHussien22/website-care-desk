import '../../../core/network_structure/entities/entity.dart';
import 'education_type_enum.dart';

class UserEntity extends Entity {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? apiToken;
  String? badge;
  String? image;
  bool? isVerify;
  String? code;
  String? userType;
  String? birthDay;
  String? gender;

  String? city;
  String? countryCode;
  bool? isBlocked;
  String? verificationCode;
  bool? isActive;
  String? address;
  String? deviceToken;
  String? deviceId;
  String? deviceType;
  String? version;
  bool? isApproved;
  bool? isExist;
  bool? allowNotification;
  bool? isCompleteData;
  AppEducationType? educationType;
  String? foundationName;
  bool? isVisitor;

  UserEntity({
    this.id,
    this.name,
    this.phone,
    this.apiToken,
    this.isVerify,
    this.image,
    this.code,
    this.email,
    this.userType,
    this.birthDay,
    this.badge,
    this.gender,
    this.city,
    this.countryCode,
    this.allowNotification,
    this.isBlocked,
    this.verificationCode,
    this.isActive,
    this.address,
    this.deviceToken,
    this.deviceId,
    this.deviceType,
    this.version,
    this.isApproved,
    this.isExist,
    this.educationType,
    this.isCompleteData,
    this.foundationName,
    this.isVisitor = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        phone,
        apiToken,
        isVerify,
        image,
        code,
        email,
        userType,
        birthDay,
        badge,
        gender,
        city,
        countryCode,
        allowNotification,
        isBlocked,
        verificationCode,
        isActive,
        address,
        deviceToken,
        deviceId,
        deviceType,
        version,
        isApproved,
        isExist,
        educationType,
        isCompleteData,
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'api_token': apiToken,
      'is_verified': isVerify,
      'image': image,
      'code': code,
      'email': email,
      'user_type': userType,
      'birth_day': birthDay,
      'verification_code': verificationCode,
      'is_blocked': isBlocked,
      'badge': badge,
      'city': city,
      'phone_code': countryCode,
      'gender': gender,
      'allow_notification': allowNotification,
      'is_active': isActive,
      'address': address,
      'device_token': deviceToken,
      'device_id': deviceId,
      'device_type': deviceType,
      'version': version,
      'is_approved': isApproved,
      'is_exist': isExist,
      'is_complete_data': isCompleteData,
      'is_phone_verify': isVerify,
      'education_type': EducationTypeFactory.toInt(educationType),
      "foundation_name": foundationName,
      "is_visitor": isVisitor,
    };
  }

  @override
  List<UserEntity> get example => [
        UserEntity(
          id: 1,
          name: "abdo",
          phone: "0102030405060",
          apiToken: "123456789",
          isVerify: false,
          badge: "https://cdn-icons-png.flaticon.com/512/1534/1534225.png",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTewPdubiwZ-wA40RGuCnUu-IBIkj3iSCGGd6s5Hf7Q&s",
          address: "Egypt",
          countryCode: "+20",
          deviceToken: "123456789",
          deviceId: "123456789",
          deviceType: "android",
          email: "abdo@gmail.com",
          birthDay: "2/2/2002",
          city: "cairo",
          code: "+20",
          gender: "mail",
          isActive: true,
          isApproved: true,
          isBlocked: false,
          userType: "1",
          version: "1.0.0",
          isExist: false,
          isCompleteData: false,
          educationType: AppEducationType.basic,
        )
      ];
}
