import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/gameplays/account_gameplays.dart';
import 'package:semnox/core/domain/use_cases/gameplays/get_card_gameplays_use_case.dart';

class GameplaysProvider {
  static final accountGameplaysProvider = FutureProvider.autoDispose.family<List<AccountGameplays>, int>((ref, cardId) async {
    final GetCardGameplaysUseCase getCardGameplaysUseCase = Get.find<GetCardGameplaysUseCase>();
    final response = await getCardGameplaysUseCase(cardId);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
}
