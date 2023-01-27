import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/sign_up/sign_up_entity.dart';
import 'package:semnox/core/enums/contact_enum.dart';

import 'package:semnox_core/modules/customer/bl/customer_bl.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_set_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/profile_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

part 'sign_up_state.dart';
part 'sign_up_notifier.freezed.dart';

///The user name will be the email
///
///
///
///
///
final signUpNotifier = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(
    Get.find<ExecutionContextDTO>(),
  ),
);

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier(this._executionContextDTO) : super(const _Initial());
  final ExecutionContextDTO _executionContextDTO;
  void signUpUser(SignUpEntity signUpEntity) async {
    state = const _InProgress();
    final profileDTO = ProfileDTO(
      siteId: _executionContextDTO.siteId,
      contactDtoList: [
        PhoneContactDTO(
          contactTypeId: ContactType.email.typeId,
          contactType: ContactType.email.type,
          attribute1: signUpEntity.email,
          isActive: true,
        ),
        PhoneContactDTO(
          contactTypeId: ContactType.phone.typeId,
          contactType: ContactType.phone.type,
          attribute1: signUpEntity.phoneNumber,
          isActive: true,
        ),
      ],
      addressDtoList: [],
      dateOfBirth: signUpEntity.dateOfBirth,
      password: signUpEntity.password,
      userName: signUpEntity.username,
      lastName: signUpEntity.lastName,
      firstName: signUpEntity.firstName,
      title: signUpEntity.title,
    );
    final customDataSetDto = CustomDataSetDTO(customDataDtoList: []);
    final customerDTO = CustomerDTO(
      customDataSetDto: customDataSetDto,
      profileDto: profileDTO,
      email: signUpEntity.email,
      phone: signUpEntity.phoneNumber,
      siteId: _executionContextDTO.siteId,
    );
    final dto = CustomerBL.dto(
      _executionContextDTO,
      customerDTO,
    );
    try {
      await dto.signUp();
      state = const _Success();
    } on AppException catch (e, s) {
      Logger().e("Error", e, s);
      state = _Error(e.toString());
    }
  }
}
