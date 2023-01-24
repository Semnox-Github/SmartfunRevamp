import 'dart:async';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/model/parafait_default_values_dto.dart';
import 'package:semnox_core/modules/parafait_defaults_configuration/repository/request/parafait_default_view_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class ParafaitDefaultViewRepository {
  static String get _storageKey => "default_config";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  ParafaitDefaultViewRepository._internal();
  static final _singleton = ParafaitDefaultViewRepository._internal();

  factory ParafaitDefaultViewRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<ParafaitDefaultValueDto>?> getParfaitDefaultViewDTO(
      ExecutionContextDTO executionContext) async {
    List<Object>? parafaitDefaultDTOList = [];

    // check if the value is present in the cache or local storage
    parafaitDefaultDTOList = await _getLocalData(executionContext);

    // If the local data is not there, get remote data
    parafaitDefaultDTOList ??= await _getRemoteData(executionContext);
    return ParafaitDefaultValueDto.getParafaitDefaultDTOList(
        parafaitDefaultDTOList);
  }

  static Future<List<Object>?> _getLocalData(
      ExecutionContextDTO executionContext) async {
    List<Object>? viewDTOList = [];

    // check if the value is present in the cache
    viewDTOList = await _viewCache?.get(_getKey("cache", executionContext));

    if (viewDTOList == null) {
      var storedItem = await _parafaitStorage
          ?.getDataFromLocalStorage(_getKey("storage", executionContext));

      if (storedItem != null) {
        await _viewCache?.addToCache(
            _getKey("cache", executionContext), storedItem);
        viewDTOList = storedItem;
      }
    }
    return viewDTOList;
  }

  static setLocalData(ExecutionContextDTO executionContext, List<Object> data,
      String serverHash) async {
    await _viewCache?.addToCache(_getKey("cache", executionContext), data);
    _parafaitStorage?.addToLocalStorage(
        _getKey("storage", executionContext), data, serverHash);
  }

  static Future<List<Object>?> _getRemoteData(
      ExecutionContextDTO executionContext) async {
    ParafaitDefaultViewService? viewservice =
        ParafaitDefaultViewService(executionContext);
    // var _serverHash = LocalStorage().get(_getKey("serverhash"));
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext));

    //Create search parmeters
    Map<ParafaitDefaultValueDTOSearchParameter, dynamic> searchparams = {
      ParafaitDefaultValueDTOSearchParameter.HASH: serverHash,
      ParafaitDefaultValueDTOSearchParameter.SITEID: executionContext.siteId,
      ParafaitDefaultValueDTOSearchParameter.REBUILDCACHE: true,
    };

    // get sites data from API
    var apiResponse = await viewservice.getParafaitDefaultContainer(
        searchParams: searchparams);

    if (apiResponse?.data != null) {
      await setLocalData(
          executionContext, apiResponse!.data!, apiResponse.hash!);
    }

    return apiResponse?.data;
  }

  static String _getKey(String type, ExecutionContextDTO executionContext) {
    String storageKey = "";
    switch (type) {
      case "cache":
        storageKey = executionContext.siteHash();
        break;
      case "storage":
        storageKey = executionContext.siteHash();
        break;
    }
    return storageKey;
  }
}
