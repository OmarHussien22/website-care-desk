enum ApprovalStatusEnum {
  pending(0),
  approved(1),
  rejected(2);

  final int id;

  const ApprovalStatusEnum(this.id);

  static ApprovalStatusEnum fromId(int id) {
    return ApprovalStatusEnum.values.firstWhere(
      (status) => status.id == id,
      orElse: () => pending,
    );
  }
}
