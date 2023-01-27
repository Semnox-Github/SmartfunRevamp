import 'package:semnox_core/modules/messages/bl/translation_view_bl.dart';
import 'package:semnox_core/modules/messages/model/translation_view_dto.dart';
import '../../execution_context/model/execution_context_dto.dart';

class TranslationProvider {
  static ExecutionContextDTO? _executionContextDTO;
  static final Map<String, String> _translationByKey = {};
  static final Map<int, String> _translationByMessageNo = {};

  TranslationProvider({ExecutionContextDTO? executionContextDTO}) {
    _executionContextDTO = executionContextDTO;
  }

  initialize() async {
    if (_executionContextDTO == null ||
        (_executionContextDTO?.longsiteHash() !=
            _executionContextDTO?.longsiteHash())) {
      // _executionContextDTO = _executionContextDTO;
      // load data from the repository and build the maps
      var translationViewDTOList =
          await TranslationViewListBL(_executionContextDTO).getTranslation();
      if (translationViewDTOList != null) {
        _loadMap(translationViewDTOList);
      }
    }
  }

  Future<String?> getTranslationBykey(key) async {
    return (_translationByKey[key]) ?? key;
  }

  Future<Map<String, String>> getTranslationByKey() async {
    return _translationByKey;
  }

  Future<String?> getMessageByMessageNo(msgNo) async {
    return (_translationByMessageNo[msgNo]) ?? msgNo;
  }

  void _loadMap(List<TranslationViewDtoList> translationViewDTOList) {
    for (var element in translationViewDTOList) {
      _translationByKey[element.message!] = element.translatedMessage!;
      //load _translationByMessageNo
      _translationByMessageNo[element.messageNumber!] =
          element.translatedMessage!;
    }
  }
}
