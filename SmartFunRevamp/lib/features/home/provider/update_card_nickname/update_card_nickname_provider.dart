import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/cards/update_card_nickname_use_case.dart';

part 'update_card_nickname_provider.freezed.dart';
part 'update_card_nickname_state.dart';

final updateCardNicknameProvider = StateNotifierProvider.autoDispose<UdateCardNicknameProvider, UpdateCardNicknameState>(
  (ref) => UdateCardNicknameProvider(
    Get.find<UpdateCardNicknameUseCase>(),
  ),
);

class UdateCardNicknameProvider extends StateNotifier<UpdateCardNicknameState> {
  final UpdateCardNicknameUseCase _updateCardNicknameUseCase;

  UdateCardNicknameProvider(this._updateCardNicknameUseCase) : super(const _Initial());

  Future<String> updateCardNickname(int cardId, String nickname) async {
    state = const _InProgress();
    final response = await _updateCardNicknameUseCase(cardId, nickname);
    state = response.fold(
      (l) => _Error(l.message),
      (r) => const _Success(),
    );
    return 'done';
  }
}
