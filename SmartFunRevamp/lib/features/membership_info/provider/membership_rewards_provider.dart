import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/card_details/account_credit_plus_dto_list.dart';
import 'package:semnox/core/domain/use_cases/cards/get_bonus_summary_use_case.dart';
import 'package:semnox/features/home/provider/cards_provider.dart';

part 'membership_rewards_state.dart';
part 'membership_rewards_provider.freezed.dart';

final membershipRewardsProvider = StateNotifierProvider.autoDispose<MembershipRewardsProvider, MembershipRewardsState>(
  (ref) {
    final accountNumber = ref.watch(CardsProviders.membershipCardProvider).accountNumber ?? '-1';
    return MembershipRewardsProvider(
      Get.find<GetBonusSummaryUseCase>(),
      accountNumber,
    );
  },
);
final fromDateProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now().subtract(const Duration(days: 365));
});
final toDateProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now();
});

class MembershipRewardsProvider extends StateNotifier<MembershipRewardsState> {
  final GetBonusSummaryUseCase _getBonusSummary;
  final String _accountNumber;

  MembershipRewardsProvider(this._getBonusSummary, this._accountNumber) : super(const _InProgress()) {
    _getMembershipRewards(_accountNumber);
  }
  List<AccountCreditPlusDTOList> _list = [];
  void _getMembershipRewards(String accountNumber) async {
    final response = await _getBonusSummary(accountNumber);
    response.fold(
      (l) => state = _Error(l.message),
      (r) {
        _list = r;
        // state = _Success(_list);
        filter(DateTime.now().subtract(const Duration(days: 365)), DateTime.now());
      },
    );
  }

  void filter(DateTime from, DateTime to) async {
    state = const _InProgress();
    final filteredList = _list.where((element) => (element.periodFrom?.isAfter(from) ?? false) && (element.periodTo?.isBefore(to) ?? false)).toList();
    state = _Success(filteredList);
  }
}
