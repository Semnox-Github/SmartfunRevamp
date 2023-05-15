import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/cards/update_card_nickname_use_case.dart';
import 'package:semnox/features/home/provider/link_card/link_card_provider.dart';

part 'update_card_nickname_provider.freezed.dart';
part 'update_card_nickname_state.dart';

final updateCardNicknameProvider = StateNotifierProvider.autoDispose<UdateCardNicknameProvider, LinkCardState>(
  (ref) => UdateCardNicknameProvider(
    Get.find<UpdateCardNicknameUseCase>(),
  ),
);

class UdateCardNicknameProvider extends StateNotifier<UpdateCardNicknameState> {
  final UpdateCardNicknameUseCase _updateCardNicknameUseCase;

  UdateCardNicknameProvider(this._updateCardNicknameUseCase) : super(const _Initial());

  void updateCardNickname(int cardId, String nickname) async {
    state = const _InProgress();
    final response = await _updateCardNicknameUseCase(cardId, nickname);
    state = response.fold(
      (l) => _Error(l.message),
      (r) => const _Success(),
    );
  }
}
