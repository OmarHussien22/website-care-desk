enum GfiSubscriptionStatusEnum {
  initial(0),
  pending(1),
  approved(2),
  rejected(3);

  final int id;

  const GfiSubscriptionStatusEnum(this.id);

  factory GfiSubscriptionStatusEnum.fromId(int id) {
    return GfiSubscriptionStatusEnum.values.firstWhere(
      (item) => item.id == id,
      orElse: () => GfiSubscriptionStatusEnum.initial,
    );
  }
}
