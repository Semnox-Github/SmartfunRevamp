import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/entities/config/parafait_defaults_response.dart';
import 'package:semnox/core/domain/entities/sign_up/sign_up_entity.dart';
import 'package:semnox/core/domain/use_cases/authentication/sign_up_user_use_case.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

part 'sign_up_state.dart';
part 'sign_up_notifier.freezed.dart';

final signUpNotifier = StateNotifierProvider<SignUpNotifier, SignUpState>(
  (ref) => SignUpNotifier(
    Get.find<ExecutionContextDTO>(),
    Get.find<SignUpUserUseCase>(),
  ),
);

class SignUpNotifier extends StateNotifier<SignUpState> {
  final ExecutionContextDTO _executionContextDTO;
  final SignUpUserUseCase _signUpUserUseCase;
  SiteViewDTO? selectedSite;
  ParafaitDefaultsResponse? parafaitDefault;
  String? defaultSiteId;
  SignUpNotifier(this._executionContextDTO, this._signUpUserUseCase) : super(const _Initial());

  void signUpUser(SignUpEntity signUpEntity) async {
    state = const _InProgress();

    final customerDTO = CustomerDTO(
      customDataSetDto: signUpEntity.customDataSetDto,
      profileDto: signUpEntity.profileDto,
      email: signUpEntity.email,
      phone: signUpEntity.phone,
      siteId: _executionContextDTO.siteId,
    );
    final response = await _signUpUserUseCase(customerDTO.toJson());
    response.fold(
      (l) => state = _Error(l.message),
      (_) => state = _Success(signUpEntity),
    );
  }
}
