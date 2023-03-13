import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/cards/link_card_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

part 'link_card_state.dart';
part 'link_card_provider.freezed.dart';

final linkCardProvider = StateNotifierProvider.autoDispose<LinkCardProvider, LinkCardState>(
  (ref) => LinkCardProvider(
    Get.find<LinkCardUseCase>(),
  ),
);

class LinkCardProvider extends StateNotifier<LinkCardState> {
  final LinkCardUseCase _linkCardUseCase;

  LinkCardProvider(this._linkCardUseCase) : super(const _Initial());

  void linkCard(String cardNumber) async {
    state = const _InProgress();
    final userId = Get.find<CustomerDTO>().id;
    final response = await _linkCardUseCase(cardNumber, userId.toString());
    state = response.fold(
      (l) => _Error(l.message),
      (r) => const _Success(),
    );
  }
}
