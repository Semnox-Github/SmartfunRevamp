import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/messages/model/translation_view_dto.dart';
import 'package:semnox_core/modules/messages/repository/request/translation_service.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_cache.dart';
import 'package:semnox_core/utils/parafait_cache/parafait_storage.dart';

class TranslationViewRepository {
  static String get _storageKey => "translation";
  static int get _cacheLife => 60 * 24;
  static ParafaitCache? _viewCache;
  static ParafaitStorage? _parafaitStorage;
  TranslationViewRepository._internal();
  static final _singleton = TranslationViewRepository._internal();

  factory TranslationViewRepository() {
    _viewCache ??= ParafaitCache(_cacheLife);
    _parafaitStorage ??= ParafaitStorage(_storageKey, _cacheLife);
    return _singleton;
  }

  Future<List<TranslationViewDtoList>?> getTranslationViewDTOList(
      ExecutionContextDTO executionContext) async {
    List<Object>? translationViewDTOList = [];
    // check if the value is present in the cache or local storage
    translationViewDTOList = await _getLocalData(executionContext);

    // If the local data is not there, get remote data
    translationViewDTOList ??= await _getRemoteData(executionContext);

    return TranslationViewDtoList.getTranslationViewDTOList(
        translationViewDTOList);
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
      ExecutionContextDTO? executionContext) async {
    TranslationService? viewservice = TranslationService(executionContext);
    // var _serverHash = LocalStorage().get(_getKey("serverhash"));
    var serverHash = await _parafaitStorage
        ?.getServerHash(_getKey("storage", executionContext!));

    //Create search parmeters
    Map<TranslationViewDTOSearchParameter, dynamic> searchparams = {
      TranslationViewDTOSearchParameter.SITEID: executionContext?.siteId,
      TranslationViewDTOSearchParameter.HASH: serverHash,
      TranslationViewDTOSearchParameter.LANGUAGEID:
          executionContext?.languageId,
      TranslationViewDTOSearchParameter.REBUILDCACHE: false
    };

    // get sites data from API
    var apiResponse =
        await viewservice.gettranslation(searchParams: searchparams);

    if (apiResponse != null) {
      await setLocalData(
          executionContext!, apiResponse.data!, apiResponse.hash!);
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
