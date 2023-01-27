import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'request/server_connection_check_service.dart';

class ServerConnectionCheckRepository {
  Future<bool> checkServerAddressisValid(String address) async {
    ServerConnectionCheckService _service =
        ServerConnectionCheckService(ExecutionContextDTO(apiUrl: address));
    try {
      return await _service.ping();
    } catch (error) {
      if (error is InvalidResponseException || error is NotFoundException) {
        return true;
      }
    }
    return false;
  }
}
