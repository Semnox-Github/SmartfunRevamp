import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/sign_up/sign_up_entity.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';

import 'package:semnox/di/injection_container.dart';
import 'package:semnox_core/modules/customer/bl/customer_bl.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_set_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/profile_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

part 'sign_up_state.dart';
part 'sign_up_notifier.freezed.dart';

final signUpNotifier = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(
    sl.get<SystemUser>(),
  ),
);

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier(this._systemUser) : super(const _Initial());
  final SystemUser _systemUser;
  void signUpUser(SignUpEntity signUpEntity) async {
    state = const _InProgress();
    final executionDTO = ExecutionContextDTO(
      apiUrl: 'https://smartfungigademo.parafait.com',
      authToken: _systemUser.webApiToken,
      siteId: _systemUser.siteId,
    );
    final profileDTO = ProfileDTO(
      siteId: _systemUser.siteId,
      contactDtoList: [
        PhoneContactDTO(
          contactTypeId: 2,
          contactType: 1,
          attribute1: signUpEntity.email,
          isActive: true,
        ),
        PhoneContactDTO(
          contactTypeId: 1,
          contactType: 2,
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
      siteId: _systemUser.siteId,
    );
    Logger().d(customerDTO.toJson());
    final dto = CustomerBL.dto(
      executionDTO,
      customerDTO,
    );
    try {
      final newUser = await dto.signUp();
      state = const _Success();
      Logger().d(newUser?.toJson());
    } catch (e, s) {
      Logger().e("Error", e, s);
      state = const _Error('An error ocurred');
    }
  }
}
