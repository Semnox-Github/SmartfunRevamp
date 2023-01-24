import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/utils/constants.dart';

class LookupViewService extends ModuleService {
  LookupViewService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<LookUpViewDTOSearchParameter, dynamic> _queryParams = {
    LookUpViewDTOSearchParameter.HASH: "hash",
    LookUpViewDTOSearchParameter.REBUILDCACHE: "rebuildCache"
  };

  Future<DataWithHash<List<Object>?>?> getCommonLookups(
      {required Map<LookUpViewDTOSearchParameter, dynamic>
          searchParams}) async {
    APIResponse response = await server.call()!.get(SemnoxConstants.lookupUrl,
        queryParameters: await _constructContainerQueryParams(searchParams));
    var data = response.data;
    return data["data"] == null
        ? null
        : DataWithHash(
            data: data["data"]["LookupsContainerDTOList"],
            hash: data["data"]["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<LookUpViewDTOSearchParameter, dynamic> searchParams) async {
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
