part of 'login_notifier.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.inProgress() = _InProgress;
  const factory LoginState.success(CustomerDTO? customer) = _Success;
  const factory LoginState.selectLocationNeeded(CustomerDTO? customer) = _SelectLocationNeeded;
  const factory LoginState.customerVerificationNeeded() = _CustomerVerificationNeeded;
  const factory LoginState.error(String message) = _Error;
  const factory LoginState.otpGenerated() = _OtpGenerated;
  const factory LoginState.otpResend() = _OtpResend;
  const factory LoginState.verifyingOTp() = _VerifyingOTP;
  const factory LoginState.otpVerified() = _OtpVerified;
  const factory LoginState.otpVerificationError(String msg) = _OtpVerificationError;
}
