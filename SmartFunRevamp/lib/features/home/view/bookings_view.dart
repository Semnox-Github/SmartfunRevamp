import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/membership/get_membership_info_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customer = Get.find<CustomerDTO>();
    final useCase = Get.find<GetMembershipInfoUseCase>();
    useCase(customer.id ?? 0);
    return const Center(
      child: Text(
        'Bookings',
      ),
    );
  }
}
