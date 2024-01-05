part of 'membership_rewards_provider.dart';

@freezed
class MembershipRewardsState with _$MembershipRewardsState {
  const factory MembershipRewardsState.initial() = _Initial;
  const factory MembershipRewardsState.inProgress() = _InProgress;
  const factory MembershipRewardsState.success(List<CreditPlusSummary> rewards) = _Success;
  const factory MembershipRewardsState.error(String message) = _Error;
}
