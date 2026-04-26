enum GenderEnum {
  male(1),
  female(2);

  final int id;

  const GenderEnum(this.id);

  static GenderEnum fromId(int id) {
    return GenderEnum.values.firstWhere(
      (item) => item.id == id,
      orElse: () => GenderEnum.male,
    );
  }
}
