import 'package:json_annotation/json_annotation.dart';
part 'membership_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class MembershipInfo {
  final int? membershipId;
  final double? membershipTotalPoints;
  final String? memberShipName;
  final DateTime? membershipValidity;

  MembershipInfo(
    this.membershipId,
    this.membershipTotalPoints,
    this.memberShipName,
    this.membershipValidity,
  );
  factory MembershipInfo.fromJson(Map<String, dynamic> json) => _$MembershipInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipInfoToJson(this);
}
