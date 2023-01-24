class LookupsContainerDTO {
  int? _lookupId;
  String? _lookupName;
  String? _isProtected;
  List<LookupValuesContainerDtoList>? _lookupValuesContainerDtoList;

  LookupsContainerDTO(
      {int? lookupId,
      String? lookupName,
      String? isProtected,
      List<LookupValuesContainerDtoList>? lookupValuesContainerDtoList}) {
    _lookupId = lookupId;
    _lookupName = lookupName;
    _isProtected = isProtected;
    _lookupValuesContainerDtoList = lookupValuesContainerDtoList;
  }

  int? get lookupId => _lookupId;
  String? get lookupName => _lookupName;
  String? get isProtected => _isProtected;
  List<LookupValuesContainerDtoList>? get lookupValuesContainerDtoList =>
      _lookupValuesContainerDtoList;

  factory LookupsContainerDTO.fromMap(Map<String, dynamic> json) =>
      LookupsContainerDTO(
        lookupId: json["LookupId"],
        lookupName: json["LookupName"],
        isProtected: json["IsProtected"],
        lookupValuesContainerDtoList: List<LookupValuesContainerDtoList>.from(
            json["LookupValuesContainerDTOList"]
                .map((x) => LookupValuesContainerDtoList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "LookupId": lookupId,
        "LookupName": lookupName,
        "IsProtected": isProtected,
        "LookupValuesContainerDTOList": List<dynamic>.from(
            lookupValuesContainerDtoList!.map((x) => x.toMap())),
      };

  static List<LookupsContainerDTO>? getLookupContainerDTOList(
      List<dynamic>? dtoList) {
    if (dtoList == null) {
      return null;
    }

    List<LookupsContainerDTO> lookupContainerDTOList = [];
    for (var element in dtoList) {
      lookupContainerDTOList.add(LookupsContainerDTO.fromMap(element));
    }
    return lookupContainerDTOList;
  }
}

class LookupValuesContainerDtoList {
  LookupValuesContainerDtoList({
    required this.lookupValueId,
    required this.lookupValue,
    required this.description,
    this.lookupName,
  });

  final int lookupValueId;
  final String lookupValue;
  final String description;
  final dynamic lookupName;

  LookupValuesContainerDtoList copyWith({
    int? lookupValueId,
    String? lookupValue,
    String? description,
    dynamic lookupName,
  }) =>
      LookupValuesContainerDtoList(
        lookupValueId: lookupValueId ?? this.lookupValueId,
        lookupValue: lookupValue ?? this.lookupValue,
        description: description ?? this.description,
        lookupName: lookupName ?? this.lookupName,
      );

  factory LookupValuesContainerDtoList.fromMap(Map<String, dynamic> json) =>
      LookupValuesContainerDtoList(
        lookupValueId: json["LookupValueId"],
        lookupValue: json["LookupValue"],
        description: json["Description"],
        lookupName: json["LookupName"],
      );

  Map<String, dynamic> toMap() => {
        "LookupValueId": lookupValueId,
        "LookupValue": lookupValue,
        "Description": description,
        "LookupName": lookupName,
      };
}

enum LookUpViewDTOSearchParameter { HASH, REBUILDCACHE, SITEID } // Id