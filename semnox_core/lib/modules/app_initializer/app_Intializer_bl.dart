import 'package:async/async.dart';
import 'package:semnox_core/modules/app_information/model/app_information_dto.dart';
import 'package:semnox_core/modules/authentication/bl/authentication_bl.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/execution_context/provider/execution_context_provider.dart';
import 'package:semnox_core/modules/languages/bl/language_view_bl.dart';
import 'package:semnox_core/modules/lookups/bl/lookup_view_bl.dart';
import 'package:semnox_core/modules/messages/provider/translation_provider.dart';
import 'package:semnox_core/modules/network_configuration/model/network_configuration_dto.dart';
import 'package:semnox_core/modules/network_configuration/provider/network_connectivity_provider.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/bl/parafait_default_view_bl.dart';
import 'package:semnox_core/modules/sites/bl/site_view_bl.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';

class AppInitializerBL {
  AppInformationDTO? _appInformation;
  NetworkConfigurationDTO? _networkConfigurationDTO;
  ExecutionContextDTO? _executionContext;
  late void Function(String message)? _statusMessageListener;

  AppInitializerBL(
      {required NetworkConfigurationDTO? networkConfigurationDTO,
      required AppInformationDTO? appInformation,
      required void Function(String message)? statusMessageListener}) {
    _networkConfigurationDTO = networkConfigurationDTO;
    _appInformation = appInformation;
    _statusMessageListener = statusMessageListener;
  }

  TranslationProvider? _translationProvider;

  Future<ExecutionContextDTO?> initialize() async {
    // Step 1 - Get the execution context from the local storage
    _executionContext = await ExecutionContextProvider().getExecutionContext();

    // Step 2 - If there is no EC, login as system user
    if (_executionContext == null) {
      await _performSystemUserInitialization();
      _executionContext =
          await ExecutionContextProvider().getExecutionContext();
    } else {
      // check if the token is valid
      var isTokenValid = await ExecutionContextProvider().isTokenValid();
      if (!isTokenValid) {
        var isConnectedToNetwork = await NetworkConnectivityProvider()
            .checkNetworkConnection(_networkConfigurationDTO);
        if (isConnectedToNetwork) {
          // isConnectedToNetwork is True we continue with SystemUser Inialization process
          await _performSystemUserInitialization();
          _executionContext =
              await ExecutionContextProvider().getExecutionContext();
        } else if (_appInformation?.isOfflineEnabled == false) {
          throw UnauthorizedException();
        }
      }
    }

    try {
      await _loadAppDataParallel();
      // ignore: empty_catches
    } catch (e) {}
    return _executionContext;
  }

  Future<void> _performSystemUserInitialization() async {
    _statusMessageListener?.call(await getTranslationString(
        "No Previous Session Found. Preparing for User Login."));
    ExecutionContextDTO executionContext = ExecutionContextDTO(
        apiUrl: _networkConfigurationDTO?.serverUrl,
        posMachineName: _appInformation?.macAddress);

    final authenticateresponse =
        await AuthenticationBL(executionContext: executionContext)
            .loginSystemUser(_appInformation);
    if (authenticateresponse != null) {
      await ExecutionContextProvider().buildContext(authenticateresponse, true,
          _networkConfigurationDTO, _appInformation);
    }
  }

  Future<void> _loadAppDataParallel() async {
    final futureGroup = FutureGroup();

    /// add all the futures , this is not the best way u can create an extension method to add all at the same time
    _statusMessageListener
        ?.call(await getTranslationString("Fetching App Default Container"));
    futureGroup
        .add(ParafaitDefaultViewListBL(_executionContext).getParafaitDefault());
    futureGroup.add(LookupViewListBL(_executionContext).getLookUp());
    futureGroup.add(LanguageViewListBL(_executionContext).getLanguages());
    futureGroup.add(TranslationProvider(executionContextDTO: _executionContext)
        .initialize());
    futureGroup.add(SitesViewListBL(_executionContext).getSites());

    futureGroup.close();
    // await for future group to finish (all futures inside it to finish)
    await futureGroup.future;
  }

  getTranslationString(String key) async {
    return await _translationProvider?.getTranslationBykey(key);
  }
}
