import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/cards/update_card_nickname_use_case.dart';
import 'package:semnox/features/home/provider/link_card/link_card_provider.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

part 'update_card_nickname_state.dart';
part 'update_card_nickname_provider.freezed.dart';

final updateCardNicknameProvider = StateNotifierProvider.autoDispose<UdateCardNicknameProvider, LinkCardState>(
  (ref) => UdateCardNicknameProvider(
    Get.find<UpdateCardNicknameUseCase>(),
  ),
);

class UdateCardNicknameProvider extends StateNotifier<UpdateCardNicknameState> {
  final UpdateCardNicknameUseCase _linkCardUseCase;

  UdateCardNicknameProvider(this._linkCardUseCase) : super(const _Initial());

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
