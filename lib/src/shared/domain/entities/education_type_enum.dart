enum AppEducationType {
  basic,
  graduate,
  university,
  all,
  non,
}

class EducationTypeFactory {

 static AppEducationType toEnum(int? value) {
    switch (value) {
      case 1:
        return AppEducationType.basic;
      case 2:
        return AppEducationType.graduate;
      case 3:
        return AppEducationType.university;
        case 4:
        return AppEducationType.all;

      default:
        return AppEducationType.all;
    }
  }

 static int toInt(AppEducationType? value) {
    switch (value) {
      case AppEducationType.basic:
        return 1;
      case AppEducationType.graduate:
        return 2;
      case AppEducationType.university:
        return 3;
      case AppEducationType.all:
        return 4;
      default:
        return 4;
    }
  }
}
