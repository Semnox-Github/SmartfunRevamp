import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/card_details/card_details.dart';
import 'package:semnox/core/domain/use_cases/cards/get_card_details_use_case.dart';

import 'package:semnox/core/domain/use_cases/home/get_user_cards_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class CardsProviders {
  static final userCardsProvider = FutureProvider<List<CardDetails>>((ref) async {
    final GetUserCardsUseCase getUserCardsUseCase = Get.find<GetUserCardsUseCase>();
    final userId = Get.find<CustomerDTO>().id;
    final response = await getUserCardsUseCase(userId.toString());
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
}

final cardsDetailsProvider = FutureProvider.family<CardDetails, String>((ref, accountNumber) async {
  final GetCardDetailsUseCase getDetails = Get.find<GetCardDetailsUseCase>();
  final response = await getDetails(accountNumber);
  return response.fold(
    (l) => throw l,
    (r) => r,
  );
});
