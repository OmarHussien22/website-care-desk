import '../../shared/domain/entities/app_status_entity.dart';
import '../../shared/domain/entities/education_type_enum.dart';
import '../constants/enums/app_mode.dart';

class AppSettings {
  AppSettings._();
  static AppMode appMode = AppMode.prod;

  static final bool _isCurrencyText = true;
  static bool get isCurrencyText => _isCurrencyText;

  static final bool _isDiscountAmount = true;
  static bool get isDiscountAmount => _isDiscountAmount;

  static AppEducationType appEducationType = AppEducationType.university;

  static List<AppLanguage> appLanguage = [];

  static final bool _showTracksPage = false;
  static bool get showTracksPage => _showTracksPage;

  ///  phone setting
  static String countryCode = "+966";
  static bool get isCountryCodeConst => true;

  /// checkout
  static bool get isCheckoutFake => false;

  /// fake complete Data
  static bool get isFakeCompleteData => false;

  static final String contactUsPhone = "";
  static final String contactUsEmail = "";
  static final String contactUsWhatsApp = "";
}
