enum ContactType {
  phone,
  email,
}

extension ContactTypeExtension on ContactType {
  int get typeId {
    switch (this) {
      case ContactType.email:
        return 2;
      case ContactType.phone:
        return 1;
      default:
        return 0;
    }
  }

  int get type {
    switch (this) {
      case ContactType.email:
        return 1;
      case ContactType.phone:
        return 2;
      default:
        return 0;
    }
  }
}
