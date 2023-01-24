import 'package:semnox_core/modules/authentication/model/authentication_response_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/constants.dart';

class AuthenticationService extends ModuleService {
  AuthenticationService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  Future<AuthenticateResponseDTO>? authenticateSystemUsers(
      Map<String, dynamic> authenticationrequestDTO) async {
    APIResponse response = await server.call()!.post(
        SemnoxConstants.authenticateSystemUsersUrl, authenticationrequestDTO);
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    Map<String, dynamic> data = response.data;
    return AuthenticateResponseDTO.fromJson(data["data"]);
  }

  Future<AuthenticateResponseDTO> authenticateAppUsers(
      Map<String, dynamic> authenticationrequestDTO) async {
    APIResponse response = await server.call()!.post(
        SemnoxConstants.authenticateAppUsersUrl, authenticationrequestDTO);
    if (response.data is! Map) {
      throw InvalidResponseException("Invalid Response.");
    }
    Map<String, dynamic> data = response.data;
    return AuthenticateResponseDTO.fromJson(data["data"]);
  }
}
