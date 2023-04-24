part of 'verify_provider.dart';

@freezed
class SendOtpState with _$SendOtpState {
  const factory SendOtpState.initial() = _Initial;
  const factory SendOtpState.inProgress() = _InProgress;
  const factory SendOtpState.success(ContactType contactType) = _Success;
  const factory SendOtpState.otpVerified(ContactType contactType) = _OTPVerified;
  const factory SendOtpState.error(String message) = _Error;
}
