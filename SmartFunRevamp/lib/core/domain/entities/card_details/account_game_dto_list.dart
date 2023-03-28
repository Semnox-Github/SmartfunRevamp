import 'package:json_annotation/json_annotation.dart';
part 'account_game_dto_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountGameDTOList {
  final DateTime? fromDate;
  final DateTime? expiryDate;
  final double quantity;
  final int balanceGames;
  final int gameId;
  final int gameProfileId;
  final List<AccountGameExtendedDTOList> accountGameExtendedDTOList;

  AccountGameDTOList(
    this.fromDate,
    this.expiryDate,
    this.quantity,
    this.balanceGames,
    this.gameId,
    this.gameProfileId,
    this.accountGameExtendedDTOList
  );

  factory AccountGameDTOList.fromJson(Map<String, dynamic> json) => _$AccountGameDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$AccountGameDTOListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class AccountGameExtendedDTOList {
  final int? gameProfileId;
  final int? gameId;
  late final bool exclude;
  final int? playLimitPerGame;

  AccountGameExtendedDTOList(
    this.gameProfileId, 
    this.gameId, 
    this.exclude, 
    this.playLimitPerGame
  );
  
  factory AccountGameExtendedDTOList.fromJson(Map<String, dynamic> json) => _$AccountGameExtendedDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$AccountGameExtendedDTOListToJson(this);
}
