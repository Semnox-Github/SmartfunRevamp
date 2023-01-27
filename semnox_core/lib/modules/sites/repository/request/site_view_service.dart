import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/utils/constants.dart';

class SiteViewService extends ModuleService {
  SiteViewService(ExecutionContextDTO? executionContext)
      : super(executionContext);

  static final Map<SiteViewDTOSearchParameter, dynamic> _queryParams = {
    SiteViewDTOSearchParameter.HASH: "hash",
    SiteViewDTOSearchParameter.REBUILDCACHE: "rebuildCache"
  };

  Future<DataWithHash<List<Object>?>?> getSites(
      {required Map<SiteViewDTOSearchParameter, dynamic> searchParams}) async {
    APIResponse response = await server.call()!.get(
        SemnoxConstants.siteContainerUrl,
        queryParameters: await _constructContainerQueryParams(searchParams));
    var data = response.data;
    return data["data"] == null
        ? null
        : DataWithHash(
            data: data["data"]["SiteContainerDTOList"],
            hash: data["data"]["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<SiteViewDTOSearchParameter, dynamic> searchParams) async {
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
