import 'package:semnox_core/modules/lookups/model/lookup_container_dto.dart';
import 'package:semnox_core/modules/lookups/repository/lookup_view_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class LookupViewBL {
  LookupViewRepository? _lookupViewRepository;
  LookupsContainerDTO? _lookupContainerDto;

  LookupViewBL.id(ExecutionContextDTO executionContext, int id) {
    _lookupViewRepository = LookupViewRepository();
  }

  LookupViewBL.dto(
      ExecutionContextDTO executionContext, LookupsContainerDTO siteViewDTO) {
    _lookupViewRepository = LookupViewRepository();
    _lookupContainerDto = siteViewDTO;
  }

  LookupsContainerDTO? getLookupViewDTO() {
    return _lookupContainerDto;
  }
}

class LookupViewListBL {
  LookupViewRepository? _lookupViewRepository;
  ExecutionContextDTO? _executionContext;

  LookupViewListBL(ExecutionContextDTO? executionContext) {
    _lookupViewRepository = LookupViewRepository();
    _executionContext = executionContext;
  }

  Future<List<LookupsContainerDTO>?> getLookUp() async {
    var sitesViewDTO =
        await _lookupViewRepository?.getLookupViewDTOList(_executionContext!);
    return sitesViewDTO;
  }
}
