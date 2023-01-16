import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:semnox/di/injection_container.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox_core/modules/customer/bl/customer_bl.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_set_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/profile_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

part 'login_state.dart';
part 'login_notifier.freezed.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(
    sl<ExecutionContextDTO>(),
  ),
);

class LoginNotifier extends StateNotifier<LoginState> {
  final ExecutionContextDTO _executionContextDTO;

  LoginNotifier(
    this._executionContextDTO,
  ) : super(const _Initial());

  void loginUser(String loginId, String password) async {
    state = const _InProgress();
    final customDataSetDto = CustomDataSetDTO(customDataDtoList: []);
    final customerDTO = CustomerDTO(
      customDataSetDto: customDataSetDto,
      siteId: _executionContextDTO.siteId,
      email: loginId,
      profileDto: ProfileDTO(
        userName: loginId,
      ),
    );
    final dto = CustomerBL.dto(
      _executionContextDTO,
      customerDTO,
    );

    try {
      final customer = await dto.login(password);
      registerUser(customer!);
      state = const _Success();
    } on AppException catch (e) {
      Logger().e(e.toString());
      state = _Error(e.toString());
    }
  }
}
