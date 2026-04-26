import 'package:coursaty/src/core/constants/enums/app_mode.dart';

import '../../features/quiz/domain/enitities/timer_type_enum.dart';

class AppSettings {
  static AppMode appMode = AppMode.prod;

  static final bool isFake = false;

  static final bool enableVideoPlaceHolder = true;

  static bool handelInputSubmitted = false;
  static bool hideArrowTopicPerformance = true;

  static TimerTypeEnum? examTimerType;
}
