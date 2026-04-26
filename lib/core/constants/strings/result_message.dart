import 'assets.dart';

enum ResultMessage {
  excellent(
    preMessage: 'prefix_message_excellent',
    sufMessage: 'suffix_message_excellent',
    lottie: Assets.lottieTrophy,
  ),
  veryGood(
    preMessage: 'prefix_message_very_good',
    sufMessage: 'suffix_message_very_good',
    lottie: Assets.lottieVeryHappy,
  ),
  good(
    preMessage: 'prefix_message_good',
    sufMessage: 'suffix_message_good',
    lottie: Assets.lottieHappy,
  ),
  fair(
    preMessage: 'prefix_message_fair',
    sufMessage: 'suffix_message_fair',
    lottie: Assets.lottieSad,
  ),
  fail(
    preMessage: 'prefix_message_failure',
    sufMessage: 'suffix_message_failure',
    lottie: Assets.lottiePale,
  );

  final String preMessage;
  final String sufMessage;
  final String lottie;

  const ResultMessage({
    required this.preMessage,
    required this.sufMessage,
    required this.lottie,
  });

  static ResultMessage fromPercentage(double percentage) {
    if (percentage >= 85) {
      return ResultMessage.excellent;
    } else if (percentage >= 75) {
      return ResultMessage.veryGood;
    } else if (percentage >= 65) {
      return ResultMessage.good;
    } else if (percentage >= 50) {
      return ResultMessage.fair;
    } else {
      return ResultMessage.fail;
    }
  }
}
