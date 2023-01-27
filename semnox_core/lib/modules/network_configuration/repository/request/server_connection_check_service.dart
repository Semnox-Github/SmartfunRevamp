import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/utils/constants.dart';

class ServerConnectionCheckService extends ModuleService {
  ServerConnectionCheckService(ExecutionContextDTO executionContext)
      : super(executionContext);
  Future<bool> ping() async {
    try {
      final response =
          await server.call()!.get(SemnoxConstants.remoteConnectionUrl);
      return response.data != null;
      // ignore: empty_catches
    } catch (e) {}
    return false;
  }
}
