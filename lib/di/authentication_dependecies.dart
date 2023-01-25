import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/authentication_repository_impl.dart';
import 'package:semnox/core/domain/repositories/authentication_repository.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_by_phone_or_email_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/get_user_metadata_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/send_otp_use_case.dart';
import 'package:semnox/core/domain/use_cases/authentication/verify_otp_use_case.dart';
import 'package:semnox_core/modules/customer/bl/customer_usecases.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

void authenticaionDependecies() {
  //Repository
  Get.lazyPut<AuthenticationRepository>(() => AuthenticationRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<LoginUserUseCase>(() => LoginUserUseCase(Get.find()));
  Get.lazyPut<SendOTPUseCase>(() => SendOTPUseCase(Get.find()));
  Get.lazyPut<VerifyOTPUseCase>(() => VerifyOTPUseCase(Get.find()));
  Get.lazyPut<GetUserByPhoneOrEmailUseCase>(() => GetUserByPhoneOrEmailUseCase(Get.find()));
  Get.lazyPut<GetUserMetaDataUseCase>(() => GetUserMetaDataUseCase(Get.find()));
  Get.lazyPut<CustomerUseCases>(() => CustomerUseCases(Get.find<ExecutionContextDTO>()));
}
