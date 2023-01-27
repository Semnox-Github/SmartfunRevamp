import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/messages/model/translation_view_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/utils/constants.dart';

class TranslationService extends ModuleService {
  TranslationService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<TranslationViewDTOSearchParameter, dynamic> _queryParams = {
    TranslationViewDTOSearchParameter.HASH: "hash",
    TranslationViewDTOSearchParameter.REBUILDCACHE: "rebuildCache",
    TranslationViewDTOSearchParameter.LANGUAGEID: "languageId",
    TranslationViewDTOSearchParameter.SITEID: "siteId"
  };

  Future<DataWithHash<List<Object>?>?> gettranslation(
      {required Map<TranslationViewDTOSearchParameter, dynamic>
          searchParams}) async {
    APIResponse response = await server.call()!.get(
        SemnoxConstants.translationUrl,
        queryParameters: await _constructContainerQueryParams(searchParams));
    var data = response.data;
    return data["data"] == null
        ? null
        : DataWithHash(
            data: data["data"]["MessageContainerDTOList"],
            hash: data["data"]["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<TranslationViewDTOSearchParameter, dynamic> searchParams) async {
    Map<String, dynamic> queryparameter = {};

    _queryParams.forEach((key, value) {
      var valu = searchParams[key];
      if (valu != null) {
        queryparameter.addAll({value: valu});
      }
    });
    return queryparameter;
  }
}
