import 'package:coursaty/src/landing/presentation/pages/landing_binding.dart';
import 'package:coursaty/src/landing/presentation/pages/landing_page.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import 'route_args.dart';

class AppRouter {
  // All pages registered here
  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.landing,
      page: () => const LandingPage(),
      binding: LandingBinding(),
      transition: Transition.fadeIn,
    ),
    if (kIsWeb)
      GetPage(
        name: AppRoutes.landingRoot,
        page: () => const LandingPage(),
        binding: LandingBinding(),
        transition: Transition.fadeIn,
      ),
    // GetPage(
    //   name: AppRoutes.splash,
    //   page: () => const SplashPage(),
    //   // transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: AppRoutes.welcomeSplash,
    //   page: () => const WelcomeAppPage(),
    //   // transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: AppRoutes.errorPage,
    //   page: () => const ErrorPage(),
    //   // transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: AppRoutes.language,
    //   page: () => const LanguagePage(),
    //   // transition: Transition.fadeIn,
    // ),
    // GetPage(
    //   name: AppRoutes.selectCountry,
    //   page: () => const SelectCountryPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.onboarding,
    //   page: () => const OnBoardingPage(),
    //   // transition: Transition.rightToLeft,
    // ),
    // GetPage(
    //   name: AppRoutes.mainAuth,
    //   page: () => const MainAuthPage(),
    //   // transition: Transition.noTransition,
    // ),
    // GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    // GetPage(
    //   name: AppRoutes.forgotPassword,
    //   page: () => const ForgotPasswordPage(),
    // ),
    // GetPage(name: AppRoutes.register, page: () => const RegisterPage()),

    // GetPage(
    //   name: AppRoutes.verifyCode,
    //   page: () => VerifyCodePage(args: Get.arguments as VerifyCodeArgs),
    // ),
    // GetPage(
    //   name: AppRoutes.register,
    //   page: () => const RegisterPage(),
    // ),

    // GetPage(
    //   name: AppRoutes.welcomePage,
    //   page: () => const WelcomePage(),
    // ),
    // GetPage(
    //   name: AppRoutes.checkApproving,
    //   page: () => const CheckApprovingPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.blockPage,
    //   page: () => const BlockedPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.enterPhonePage,
    //   page: () => const EnterPhonePage(),
    // ),
    // GetPage(
    //   name: AppRoutes.resetPassword,
    //   page: () => const ResetPasswordPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.verifyCode,

    //   // Get.arguments replaces state.extra
    //   page: () => VerifyYourPhonePage(
    //     args: Get.arguments as VerifyCodeArgs,
    //   ),
    // ),
    // GetPage(
    //   name: AppRoutes.assest,
    //   // Get.arguments replaces state.extra
    // GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
    // GetPage(
    //   name: AppRoutes.changePassword,
    //   page: () => const ChangePasswordPage(),
    // ),
    // GetPage(name: AppRoutes.aboutApp, page: () => const AboutUsPage()),
    // GetPage(
    //   name: AppRoutes.privacyPolicy,
    //   page: () => const PrivacyPolicyPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.termsConditions,
    //   page: () => const TermsConditionsPage(),
    // ),
    // GetPage(name: AppRoutes.faqs, page: () => const FAQsPage()),
    // GetPage(name: AppRoutes.support, page: () => const SupportPage()),
    // GetPage(
    //   name: AppRoutes.setEducationInfo,
    //   page: () => const SetEducationInfoPage(),
    // ),
    // GetPage(name: AppRoutes.editProfile, page: () => const EditProfilePage()),
    // GetPage(name: AppRoutes.parentInfo, page: () => const ParentInfoPage()),
    // GetPage(name: AppRoutes.inviteCode, page: () => const InvitationCodePage()),
  ];
}
