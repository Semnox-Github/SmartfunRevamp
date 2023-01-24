import 'dart:async';
import 'package:semnox_core/modules/languages/model/language_container_dto.dart';
import 'package:semnox_core/modules/languages/repository/request/language_view_service.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class LanguageViewRepository {
  static String get _storageKey => "language";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  LanguageViewRepository._internal();
  static final _singleton = LanguageViewRepository._internal();

  factory LanguageViewRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<LanguageContainerDto>?> getLanguageViewDTOList(
      ExecutionContextDTO executionContext) async {
    List<Object>? languageViewDTOList = [];

    // check if the value is present in the cache or local storage
    languageViewDTOList = await _getLocalData(executionContext);

    // If the local data is not there, get remote data
    languageViewDTOList ??= await _getRemoteData(executionContext);
    return LanguageContainerDto.getLanguageDTOList(languageViewDTOList);
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
        viewDTOList = storedItem.toList();
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
    LanguageViewService? viewservice = LanguageViewService(executionContext);
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext));

    //Create search parmeters
    Map<LanguageViewDTOSearchParameter, dynamic> searchparams = {
      LanguageViewDTOSearchParameter.HASH: serverHash,
      LanguageViewDTOSearchParameter.SITEID: executionContext.siteId,
      LanguageViewDTOSearchParameter.REBUILDCACHE: true,
    };

    // get sites data from API
    var apiResponse =
        await viewservice.getLanguageContainer(searchParams: searchparams);
    if (apiResponse?.data != null) {
      await setLocalData(
          executionContext, apiResponse!.data!, apiResponse.hash!);
    }

    return apiResponse?.data!;
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
