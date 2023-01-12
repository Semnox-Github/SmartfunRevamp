import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/core/domain/use_cases/authentication/login_user_use_case.dart';
import 'package:semnox/di/injection_container.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox_core/modules/customer/bl/customer_bl.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_set_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/profile_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

part 'login_state.dart';
part 'login_notifier.freezed.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    sl<LoginUserUseCase>(),
    sl<SystemUser>(),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUserUseCase _loginUserUseCase;
  final SystemUser _systemUser;

  LoginNotifier(this._loginUserUseCase, this._systemUser) : super(const _Initial());

  void loginUser(String loginId, String password) async {
    state = const _InProgress();
    final executionDTO = ExecutionContextDTO(
      apiUrl: 'https://smartfungigademo.parafait.com',
      authToken: _systemUser.webApiToken,
      siteId: _systemUser.siteId,
    );
    final customDataSetDto = CustomDataSetDTO(customDataDtoList: []);
    final customerDTO = CustomerDTO(
      customDataSetDto: customDataSetDto,
      siteId: _systemUser.siteId,
      email: loginId,
      profileDto: ProfileDTO(
        userName: loginId,
      ),
    );
    final dto = CustomerBL.dto(
      executionDTO,
      customerDTO,
    );

    try {
      await dto.login(password);
    } catch (e) {
      Logger().e(e);
    }
  }
}
