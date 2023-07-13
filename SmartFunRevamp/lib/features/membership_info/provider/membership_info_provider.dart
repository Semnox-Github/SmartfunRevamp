import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/membership/membership_info.dart';
import 'package:semnox/core/domain/entities/membership/membership_tier.dart';
import 'package:semnox/core/domain/use_cases/membership/get_membership_container_use_case.dart';
import 'package:semnox/core/domain/use_cases/membership/get_membership_info_use_case.dart';
import 'package:semnox/features/login/provider/login_notifier.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

final membershipContainerProvider = FutureProvider<List<MembershipTier>>(
  (ref) async {
    final siteId = ref.watch(loginProvider.notifier).selectedSite?.siteId ?? 0;
    final getMembershipContainer = Get.find<GetMembershipContainerUseCase>();
    final response = await getMembershipContainer(siteId);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  },
);
final membershipInfoProvider = FutureProvider.autoDispose<MembershipInfo>(
  (ref) async {
    final userId = Get.find<CustomerDTO>().id;
    final getMemberShipInfoUseCase = Get.find<GetMembershipInfoUseCase>();
    final response = await getMemberShipInfoUseCase(userId ?? -1);
    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  },
);
