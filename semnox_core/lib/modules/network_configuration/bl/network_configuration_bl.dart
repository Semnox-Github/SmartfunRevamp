import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/repository/server_connection_check_repository.dart';

class NetworkConfigurationBL {
  NetworkConfigurationDTO? _networkConfigurationDTO;
  final _serverValidationBL = ServerConnectionCheckRepository();

  NetworkConfigurationBL(NetworkConfigurationDTO? networkConfigurationDTO) {
    _networkConfigurationDTO = networkConfigurationDTO;
  }

  Future<bool> checkServerAddressisValid() async {
    bool isValid = await _serverValidationBL
        .checkServerAddressisValid(_networkConfigurationDTO!.serverUrl!);
    return isValid;
  }
}
