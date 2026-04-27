// ignore_for_file: must_be_immutable

import '../../core/services/utils/extensions/parser_extension.dart';
import 'package:equatable/equatable.dart';

import '../../features/auth/core/enum/gender_enum.dart';
import '../managers/approval_status_enum.dart';
import 'user_info_model.dart';

class UserModel with EquatableMixin {
  int? id;
  String? message;
  String? name;
  String? level;
  String? phone;
  String? image;
  String? parentName;
  String? parentPhone;
  String? apiToken;
  String? verificationCode;
  int? isVerified;
  int? categoryId;
  String? categoryTitle;
  int? isInfoComplete;
  UserInfoModel? userInfo;
  int? type;
  bool? isBlocked;
  String? countryCode;
  String? email;
  String? address;
  int? isDeviceEmulator;
  int? isVisitor;
  ApprovalStatusEnum? approvalStatus;
  GenderEnum? gender;
  UserModel({
    this.id,
    this.name,
    this.level,
    this.message,
    this.phone,
    this.image,
    this.parentName,
    this.parentPhone,
    this.apiToken,
    this.verificationCode,
    this.isVerified,
    this.categoryId,
    this.categoryTitle,
    this.isInfoComplete,
    this.userInfo,
    this.type,
    this.isBlocked,
    this.isDeviceEmulator,
    this.countryCode,
    this.email,
    this.address,
    this.isVisitor,
    this.approvalStatus,
    this.gender,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json.parse<int>('id');
    message = json.parse<String>('message');
    name = json.parse<String>('name');
    level = json.parse<String>('level');
    phone = json.parse<String>('phone');
    image = json.parse<String>('image');
    parentName = json.parse<String>('parent_name');
    parentPhone = json.parse<String>('parent_phone');
    apiToken = json.parse<String>('api_token');
    verificationCode = json.parse<String>('verification_code');
    isVerified = json.parse<int>('is_verified');
    categoryId = json.parse<int>('category_id');
    categoryTitle = json.parse<String>('category_title');
    countryCode = json.parse<String>('country_code');
    email = json.parse<String>('email');
    address = json.parse<String>('address');
    isInfoComplete = json.parse<int>('is_info_complete');
    userInfo = json['user_info'] != null
        ? UserInfoModel.fromJson(json['user_info'])
        : null;
    type = json.parse<int>('type');
    isBlocked = json.parse<bool>('is_blocked', defaultValue: false);
    isDeviceEmulator = json.parse<int>('is_device_emulator', defaultValue: 0);
    isVisitor = json.parse<int>('is_visitor', defaultValue: 0);
    approvalStatus = ApprovalStatusEnum.fromId(json.parse<int>('is_approved'));
    gender = GenderEnum.fromId(json.parse<int>('gender'));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'name': name,
      'level': level,
      'phone': phone,
      'image': image,
      'parent_name': parentName,
      'parent_phone': parentPhone,
      'api_token': apiToken,
      'verification_code': verificationCode,
      'is_verified': isVerified,
      'category_id': categoryId,
      'category_title': categoryTitle,
      'is_info_complete': isInfoComplete,
      'user_info': userInfo?.toJson(),
      'type': type,
      'is_blocked': isBlocked,
      'is_device_emulator': isDeviceEmulator,
      'country_code': countryCode,
      'email': email,
      'address': address,
      'is_visitor': isVisitor,
      'is_approved': approvalStatus?.id ?? ApprovalStatusEnum.pending.id,
      'gender': gender?.id ?? GenderEnum.male.id,
    };
  }

  @override
  List<Object?> get props => [
    id,
    message,
    name,
    level,
    phone,
    image,
    parentName,
    parentPhone,
    apiToken,
    verificationCode,
    isVerified,
    categoryId,
    categoryTitle,
    isInfoComplete,
    userInfo,
    type,
    isDeviceEmulator,
    countryCode,
    email,
    address,
    isVisitor,
  ];

  static UserModel example = UserModel(
    id: 1,
    name: 'test',
    level: 'test',
    phone: '01009060299',
    image: 'https://www.w3schools.com/howto/img_avatar.png',
    parentName: 'عبدالله محمد',
    apiToken: '123456789',
    categoryId: 1,
    categoryTitle: 'طالب',
    isVerified: 0,
    isVisitor: 0,
    parentPhone: '01000000000',
    verificationCode: '123456',
    isInfoComplete: 1,
    type: 1,
    approvalStatus: ApprovalStatusEnum.approved,
    userInfo: UserInfoModel(
      id: 1,
      basicEducationTypeId: 1,
      stageId: 1,
      yearId: 1,
      universityEducationTypeId: 1,
      universityId: 1,
      collegeId: 1,
      departmentId: 1,
      divisionId: 1,
      basicEducationTypeTitle: 'متوسط',
      stageTitle: 'الصف الثالث الاعدادي',
      yearTitle: 'الفصل الدراسي الاول',
      universityEducationTypeTitle: 'جامعة حكومية',
      universityTitle: 'جامعة القاهرة',
      collegeTitle: 'كلية الحاسبات والمعلومات',
      departmentTitle: 'علوم حاسب',
      divisionTitle: 'الفرقة الثالثة',
    ),
    gender: GenderEnum.male,
  );
}

//
//
// class User extends Equatable {
//   final int id;
//   final String name;
//   final String phone;
//   final String parentName;
//   final String parentPhone;
//   final String profileImage;
//   final String apiToken;
//   final bool requirePhoneVerification;
//   final bool isPhoneVerified;
// //<editor-fold desc="Data Methods">
//
//   const User({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.parentName,
//     required this.parentPhone,
//     required this.apiToken,
//     required this.requirePhoneVerification,
//     required this.isPhoneVerified,
//      required this.profileImage,
//   });
//
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'parent_name': parentName,
//       'parent_phone': parentPhone,
//       'profile_image': profileImage,
//       'api_token': apiToken,
//       'require_phone_verification': requirePhoneVerification,
//       'is_phone_verified': isPhoneVerified,
//
//     };
//   }
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json.parse<int>('id'),
//       name: json.parse<String>('name'),
//       phone: json.parse<String>('phone'),
//       profileImage: json.parse<String>('profile_image'),
//       parentName: json.parse<String>('parent_name'),
//       parentPhone: json.parse<String>('parent_phone'),
//       apiToken: json.parse<String>('api_token'),
//       requirePhoneVerification: json.parse<bool>('require_phone_verification'),
//       isPhoneVerified: json.parse<bool>('is_phone_verified'),
//     );
//   }
//
//
//
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//         id,
//         name,
//         phone,
//         parentName,
//         parentPhone,
//         profileImage,
//         apiToken,
//         requirePhoneVerification,
//          isPhoneVerified,
//
//       ];
//
//   User copyWith({
//     int? id,
//     String? name,
//     String? phone,
//     String? parentName,
//     String? parentPhone,
//     String? profileImage,
//     String? apiToken,
//     bool? requirePhoneVerification,
//     bool? isPhoneVerified,
//   }) {
//     return User(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       parentName: parentName ?? this.parentName,
//       parentPhone: parentPhone ?? this.parentPhone,
//       profileImage: profileImage ?? this.profileImage,
//       apiToken: apiToken ?? this.apiToken,
//       requirePhoneVerification: requirePhoneVerification ?? this.requirePhoneVerification,
//       isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
//     );
//   }
//   static User example = const User(
//     id: 1,
//     name: "Ahmed",
//     phone: "01000000000",
//     parentName: "Mohamed",
//     apiToken: "token",
//     parentPhone: "01000000000",
//     requirePhoneVerification: false,
//     isPhoneVerified: true,
//     profileImage: "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
//   );
//
// }
