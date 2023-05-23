import 'package:freezed_annotation/freezed_annotation.dart';
part 'membership_tier.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.pascal,
  explicitToJson: true,
)
class MembershipContainerResponse {
  final List<MembershipTier> membershipContainerDTOList;

  MembershipContainerResponse(this.membershipContainerDTOList);
  factory MembershipContainerResponse.fromJson(Map<String, dynamic> json) => _$MembershipContainerResponseFromJson(json['data']);
  Map<String, dynamic> toJson() => _$MembershipContainerResponseToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.pascal,
  explicitToJson: true,
)
class MembershipTier {
  final int membershipId;
  final String membershipName;
  final String description;
  @JsonKey(name: 'VIP')
  final bool isVip;
  final List<int> nextMembershipIdList;

  MembershipTier(
    this.membershipId,
    this.membershipName,
    this.description,
    this.isVip,
    this.nextMembershipIdList,
  );
  factory MembershipTier.fromJson(Map<String, dynamic> json) => _$MembershipTierFromJson(json);
  Map<String, dynamic> toJson() => _$MembershipTierToJson(this);
  @override
  String toString() {
    return membershipName;
  }
}
