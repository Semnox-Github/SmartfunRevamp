import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:semnox_core/modules/machine_mac_address/mac_address_provider.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/bl/network_configuration_bl.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_configuration_provider.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_connectivity_provider.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/semnox_core.dart';
import 'package:semnox_core/utils/dataprovider/data_provider.dart';
import 'package:semnox_core/utils/dataprovider/data_state.dart';
import 'package:semnox_logger/semnox_logger.dart';

class NetworkConfigurationFormViewModel extends ChangeNotifier {
  static final provider =
      ChangeNotifierProvider<NetworkConfigurationFormViewModel>(
    (ref) {
      return NetworkConfigurationFormViewModel();
    },
  );

  NetworkConfigurationFormViewModel() {
    _log = SemnoxLogger(runtimeType.toString());
    _init();
  }

  final BehaviorSubject<String> _ssId = BehaviorSubject.seeded("");
  ValueStream<String> get ssId => _ssId.stream;
  final BehaviorSubject<String> _deviceipAddress = BehaviorSubject.seeded("");
  ValueStream<String> get deviceipAddress => _deviceipAddress.stream;
  final BehaviorSubject<String> _macAddress = BehaviorSubject.seeded("");
  ValueStream<String> get macAddress => _macAddress.stream;

  final DataProvider<NetworkConfigurationDTO?> _conctionInfoProvider =
      DataProvider<NetworkConfigurationDTO?>();
  ValueStream<DataState<NetworkConfigurationDTO?>> get connectionInfoProvider =>
      _conctionInfoProvider.dataStream;

  late SemnoxTextFieldProperties serverIpField =
      SemnoxTextFieldProperties(hintText: "No Server");

  late SemnoxTextFieldProperties portNoField =
      SemnoxTextFieldProperties(hintText: "No PortNo");

  late SemnoxTextFieldProperties subnetworkMaskField =
      SemnoxTextFieldProperties(hintText: "No SubNetwork Mask");

  SemnoxLogger? _log;
  NetworkConfigurationDTO? _networkConfigurationDTO;
  TranslationProvider? _translationProvider;

  _init() async {
    _networkConfigurationDTO = await _fetchLocalStorageNetworkConfiguration();
    _networkConfigurationDTO ??= NetworkConfigurationDTO(
        ssId: await NetworkConnectivityProvider().getNetworkSSID(),
        deviceipAddress:
            await NetworkConnectivityProvider().getDeviceIpAddress(),
        serverUrl: "http://192.168.29.99:90",
        portNumber: portNoField.value,
        subNetworkMask: subnetworkMaskField.value);
    _buildConfigurationForm(_networkConfigurationDTO);
  }

  void _buildConfigurationForm(
      NetworkConfigurationDTO? networkConfigurationDTO) async {
    _conctionInfoProvider.updateData(_networkConfigurationDTO);
    if (_networkConfigurationDTO == null) return;
    _ssId.add(networkConfigurationDTO?.ssId ?? "");
    _deviceipAddress.add(networkConfigurationDTO?.deviceipAddress ?? "");
    _macAddress.add(await MacAddressProvider().getMacAddress());
    serverIpField.setInitialValue(networkConfigurationDTO?.serverUrl ?? "");
  }

  Future<NetworkConfigurationDTO?>
      _fetchLocalStorageNetworkConfiguration() async {
    try {
      _networkConfigurationDTO =
          await NetworkConfigurationProvider().getNetworkConfiguration();
    } on NetworkConfigurationNotFoundException {
      _log?.error(
          "_getNetworkConfiguration",
          await getTranslationString(
              "Network Configuration Not Found Exception"),
          NetworkConfigurationNotFoundException());
    }
    return _networkConfigurationDTO;
  }

  Future<bool> validateIpAddress() async {
    bool isValid = await NetworkConfigurationBL(_networkConfigurationDTO)
        .checkServerAddressisValid();
    return isValid;
  }

  saveNetworkConfiguraton() async {
    NetworkConfigurationProvider()
        .storeNetworkConfiguration(_networkConfigurationDTO);
  }

  getTranslationString(String key) async {
    return await _translationProvider?.getTranslationBykey(key);
  }
}
