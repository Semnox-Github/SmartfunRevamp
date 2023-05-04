import 'package:get/instance_manager.dart';
import 'package:semnox/core/data/repositories/membership_repository_impl.dart';
import 'package:semnox/core/domain/repositories/membership_repository.dart';
import 'package:semnox/core/domain/use_cases/membership/get_membership_container_use_case.dart';

import 'package:semnox/core/domain/use_cases/membership/get_membership_info_use_case.dart';

void membershipDependencies() {
  //Repository
  Get.lazyPut<MembershipRepository>(() => MembershipRepositoryImpl(Get.find()));

  //Use Cases
  Get.lazyPut<GetMembershipInfoUseCase>(() => GetMembershipInfoUseCase(Get.find()));
  Get.lazyPut<GetMembershipContainerUseCase>(() => GetMembershipContainerUseCase(Get.find()));
}
