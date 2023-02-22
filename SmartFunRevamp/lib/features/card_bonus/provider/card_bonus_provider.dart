import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/account/account_detail.dart';
import 'package:semnox/core/domain/use_cases/account_bonus/get_account_details_use_case.dart';


class CardBonusProvider {
  static final cardBonusProvider = FutureProvider<List<AccountDetail>>((ref) async {
    
    final GetAccountDetailsUseCase getAccountDetailsUseCase = Get.find<GetAccountDetailsUseCase>();
    final response = await getAccountDetailsUseCase();
    Logger().d(response);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  });
}