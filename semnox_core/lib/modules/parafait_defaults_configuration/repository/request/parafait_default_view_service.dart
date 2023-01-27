import 'dart:async';
import 'package:semnox_core/modules/parafait_defaults_configuration/model/parafait_default_values_dto.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/utilities/api_service_library/api_response.dart';
import 'package:semnox_core/modules/utilities/api_service_library/data_with_hash.dart';
import 'package:semnox_core/modules/utilities/api_service_library/module_service.dart';
import 'package:semnox_core/modules/utilities/api_service_library/server_exception.dart';
import 'package:semnox_core/utils/constants.dart';

class ParafaitDefaultViewService extends ModuleService {
  ParafaitDefaultViewService(ExecutionContextDTO executionContext)
      : super(executionContext);

  static final Map<ParafaitDefaultValueDTOSearchParameter, dynamic>
      _queryParams = {
    ParafaitDefaultValueDTOSearchParameter.HASH: "hash",
    ParafaitDefaultValueDTOSearchParameter.REBUILDCACHE: "rebuildCache"
  };

  Future<DataWithHash<List<Object>?>?> getParafaitDefaultContainer(
      {required Map<ParafaitDefaultValueDTOSearchParameter, dynamic>
          searchParams}) async {
    APIResponse response = await server.call()!.get(
        SemnoxConstants.defaultContainerUrl,
        queryParameters: await _constructContainerQueryParams(searchParams));
    var data = response.data;

    if (data is! Map) throw AppException(" Invalid response.");
    return data["data"] == null
        ? null
        : DataWithHash(
            data: data["data"]["ParafaitDefaultContainerDTOList"],
            hash: data["data"]["Hash"]);
  }

  Future<Map<String, dynamic>> _constructContainerQueryParams(
      Map<ParafaitDefaultValueDTOSearchParameter, dynamic> searchParams) async {
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
