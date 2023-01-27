import 'package:network_info_plus/network_info_plus.dart';
import 'package:semnox_core/modules/network_configuration/bl/network_configuration_bl.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:universal_platform/universal_platform.dart';

class NetworkConnectivityProvider {
  NetworkInfo? _networkInfo;
  NetworkConnectivityProvider() {
    _networkInfo = NetworkInfo();
  }
  getNetworkSSID() async {
    return UniversalPlatform.isWeb ? "--" : await _networkInfo?.getWifiName();
  }

  getDeviceIpAddress() async {
    return UniversalPlatform.isWeb ? "--" : await _networkInfo?.getWifiIP();
  }

  Future<bool> checkNetworkConnection(
      NetworkConfigurationDTO? networkConfigurationDTO) async {
    if (networkConfigurationDTO == null) {
      throw NetworkConfigurationNotFoundException(
          "Network Configuration Not Found Exception");
    }
    var serverreachable = await NetworkConfigurationBL(networkConfigurationDTO)
        .checkServerAddressisValid();
    if (serverreachable == false) {
      throw ServerNotReachableException("Server Not Reachable Exception");
    }
    return serverreachable;
  }
}
