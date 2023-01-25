import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/authentication_repository_impl.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_metadata_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/sign_up_use_case.dart';
import 'package:semnox_core/modules/customer/bl/customer_usecases.dart';

void authenticaionDependecies() {
  //Repository
  Get.lazyPut<AuthenticationRepository>(() => AuthenticationRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<LoginUserUseCase>(() => LoginUserUseCase(Get.find()));
  Get.lazyPut<SignUpUseCase>(() => SignUpUseCase(Get.find()));
  Get.lazyPut<GetUserMetaDataUseCase>(() => GetUserMetaDataUseCase(Get.find()));
  Get.lazyPut<CustomerUseCases>(() => CustomerUseCases(Get.find()));
}
