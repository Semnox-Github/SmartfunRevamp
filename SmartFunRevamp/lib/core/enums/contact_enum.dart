enum ContactType {
  phone,
  email,
  facebook,
  twitter,
  wechat
}

extension ContactTypeExtension on ContactType {
  int get typeId {
    switch (this) {
      case ContactType.email:
        return 2;
      case ContactType.phone:
        return 1;
      case ContactType.facebook:
        return 2;
      case ContactType.twitter:
        return 2;
      case ContactType.wechat:
        return 2;
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
      case ContactType.facebook:
        return 3;
      case ContactType.twitter:
        return 4;
      case ContactType.wechat:
        return 5;
      default:
        return 0;
    }
  }

  String get valueString {
    switch (this) {
      case ContactType.email:
        return 'Email';
      case ContactType.phone:
        return 'Phone';
      case ContactType.facebook:
        return 'Facebook';
      case ContactType.twitter:
        return 'Twitter';
      case ContactType.wechat:
        return 'Wechat';
      default:
        return 'N/A';
    }
  }
}
