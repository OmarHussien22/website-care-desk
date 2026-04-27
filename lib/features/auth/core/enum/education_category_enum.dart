enum EducationCategoryEnum {
  basic(1),
  university(2);

  final int id;

  const EducationCategoryEnum(this.id);

  factory EducationCategoryEnum.fromId(int id) {
    return EducationCategoryEnum.values.firstWhere((e) => e.id == id);
  }
}
