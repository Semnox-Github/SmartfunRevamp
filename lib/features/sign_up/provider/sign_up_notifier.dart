import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:semnox/core/domain/entities/sign_up_entity.dart';
import 'package:semnox/core/domain/use_cases/sign_up_use_case.dart';
import 'package:semnox/di/injection_container.dart';

part 'sign_up_state.dart';
part 'sign_up_notifier.freezed.dart';

final signUpNotifier = StateNotifierProvider<SignUpNotifier, SignUpState>((ref) => SignUpNotifier(sl<SignUpUseCase>()));

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpNotifier(this._signUpUseCase) : super(const _Initial());

  void signUpUser(SignUpEntity signUpEntity) async {
    state = const _InProgress();
    // final dto = CustomerBL.dto(context, customerDTO);
    // try {
    //   final newUser = dto.create();
    // } catch (e) {
    //   Logger().e(e);
    // }

    final result = await _signUpUseCase(signUpEntity);
    state = result.fold(
      (failure) => _Error(failure.message),
      (user) {
        return const _Success();
      },
    );
  }
}
