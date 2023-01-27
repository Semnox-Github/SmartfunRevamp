class ExecutionContextDTO {
  int? _languageId;
  int? _machineId;
  int? _siteId;
  String? _loginId;
  String? _apiUrl;
  String? _authToken;
  String? _posMachineName;
  String? _languageCode;
  bool? _isCorporate;
  bool? _inWebMode;
  bool? _isSystemLogin;

  ExecutionContextDTO(
      {int? languageId,
      int? machineId,
      int? siteId,
      String? loginId,
      String? apiUrl,
      String? authToken,
      String? posMachineName,
      String? languageCode,
      bool? isCorporate,
      bool? inWebMode,
      bool? isSystemLogin}) {
    _languageId = languageId;
    _machineId = machineId;
    _siteId = siteId;
    _loginId = loginId;
    _apiUrl = apiUrl;
    _authToken = authToken;
    _posMachineName = posMachineName;
    _languageCode = languageCode;
    _isCorporate = isCorporate;
    _inWebMode = inWebMode;
    _isSystemLogin = isSystemLogin;
  }

  int? get languageId => _languageId;
  int? get machineId => _machineId;
  int? get siteId => _siteId;
  String? get loginId => _loginId;
  String? get apiUrl => _apiUrl;
  String? get authToken => _authToken;
  String? get posMachineName => _posMachineName;
  String? get languageCode => _languageCode;
  bool get isCorporate => _isCorporate ?? false;
  bool? get inWebMode => _inWebMode;
  bool? get isSystemLogin => _isSystemLogin;

  String siteHash() {
    String hash = siteId.toString();
    return hash;
  }

  String longsiteHash() {
    String hash = ("$siteId|$loginId|$_machineId");
    return hash;
  }

  ExecutionContextDTO copyWith(
      {int? languageId,
      int? machineId,
      int? siteId,
      String? loginId,
      String? apiUrl,
      String? authToken,
      String? posMachineName,
      String? languageCode,
      bool? isCorporate,
      bool? inWebMode,
      bool? isSystemLogin}) {
    return ExecutionContextDTO(
        languageId: languageId ?? _languageId,
        machineId: machineId ?? _machineId,
        siteId: siteId ?? _siteId,
        loginId: loginId ?? _loginId,
        apiUrl: apiUrl ?? _apiUrl,
        authToken: authToken ?? _authToken,
        posMachineName: posMachineName ?? _posMachineName,
        languageCode: languageCode ?? _languageCode,
        isCorporate: isCorporate ?? _isCorporate,
        inWebMode: inWebMode ?? _inWebMode,
        isSystemLogin: isSystemLogin ?? _isSystemLogin);
  }

  factory ExecutionContextDTO.fromMap(Map<String, dynamic> json) =>
      ExecutionContextDTO(
          languageId: json["LanguageId"],
          machineId: json["MachineId"],
          siteId: json["SiteId"],
          loginId: json["LoginId"],
          apiUrl: json["ApiUrl"],
          authToken: json["AuthToken"],
          posMachineName: json["PosMachineName"],
          languageCode: json["LanguageCode"],
          isCorporate: json["IsCorporate"],
          inWebMode: json["InWebMode"],
          isSystemLogin: json["IsSystemLogin"]);

  Map<String, dynamic> toMap() => {
        "LanguageId": languageId,
        "MachineId": machineId,
        "SiteId": siteId,
        "LoginId": loginId,
        "ApiUrl": apiUrl,
        "AuthToken": authToken,
        "PosMachineName": posMachineName,
        "LanguageCode": languageCode,
        "IsCorporate": isCorporate,
        "InWebMode": inWebMode,
        "IsSystemLogin": isSystemLogin,
      };
}
