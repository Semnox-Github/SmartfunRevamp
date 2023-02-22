import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/account_repository_impl.dart';
import 'package:semnox/core/domain/repositories/account_repository.dart';
import 'package:semnox/core/domain/use_cases/account_bonus/get_account_details_use_case.dart';


void accountDetailDependencies() {
  //Repository
  Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetAccountDetailsUseCase>(() => GetAccountDetailsUseCase(Get.find()));
}