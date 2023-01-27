import 'package:semnox_core/modules/messages/model/translation_view_dto.dart';
import 'package:semnox_core/modules/messages/repository/translation_view_repository.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';

class TranslationViewBL {
  TranslationViewRepository? _translationViewRepository;
  Map<String, dynamic>? _translationmap;
  ExecutionContextDTO? _executionContext;

  TranslationViewBL.id(ExecutionContextDTO executionContext, int id) {
    _executionContext = executionContext;
  }

  TranslationViewBL.dto(ExecutionContextDTO executionContext) {
    _executionContext = executionContext;
  }

  TranslationViewBL(ExecutionContextDTO? executionContext) {
    _translationViewRepository = TranslationViewRepository();
  }
}

class TranslationViewListBL {
  TranslationViewRepository? _translationViewRepository;
  ExecutionContextDTO? _executionContext;

  TranslationViewListBL(ExecutionContextDTO? executionContext) {
    _translationViewRepository = TranslationViewRepository();
    _executionContext = executionContext;
  }

  Future<List<TranslationViewDtoList>?> getTranslation() async {
    return await _translationViewRepository!
        .getTranslationViewDTOList(_executionContext!);
  }
}
