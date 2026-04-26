enum TimerTypeEnum {
  none(0),
  up(1),
  down(2);

  final int id;
  const TimerTypeEnum(this.id);

  static TimerTypeEnum fromId(int id) {
    return TimerTypeEnum.values.firstWhere(
          (e) => e.id == id,
      orElse: () => TimerTypeEnum.none,
    );
  }
}