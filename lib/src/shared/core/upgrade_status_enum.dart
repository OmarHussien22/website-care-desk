enum UpgradeStatus {
  noUpgrade(1),
  optional(2),
  mandatory(3);

  final int value;
  const UpgradeStatus(this.value);

  static UpgradeStatus fromInt(int? value) {
    switch (value) {
      case 1:
        return UpgradeStatus.noUpgrade;
      case 2:
        return UpgradeStatus.optional;
      case 3:
        return UpgradeStatus.mandatory;
      default:
        return UpgradeStatus.noUpgrade;
    }
  }
}