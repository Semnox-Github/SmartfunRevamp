import 'package:semnox_core/modules/common_services/model/generic_otp_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';

class GenericOtpService extends ModuleService {
  GenericOtpService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  Future<GenericOtpDTO>? createOtp(
      Map<String, dynamic> generateotprequestDto) async {
    APIResponse response = await server
        .call()!
        .post("${SemnoxConstants.otpUrl}/Create", generateotprequestDto);
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    Map<String, dynamic> data = response.data;
    return GenericOtpDTO.fromJson(data["data"]);
  }

  Future<bool?> validateOTP(int otpId, String otp) async {
    try {
      final response = await server
          .call()!
          .post("${SemnoxConstants.otpUrl}/$otpId/Validate", {"Code": otp});
      return response.data != null;
      // ignore: empty_catches
    } catch (e) {}
    return false;
  }
}
