// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_game_dto_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountGameDTOList _$AccountGameDTOListFromJson(Map<String, dynamic> json) =>
    AccountGameDTOList(
      json['FromDate'] == null
          ? null
          : DateTime.parse(json['FromDate'] as String),
      json['ExpiryDate'] == null
          ? null
          : DateTime.parse(json['ExpiryDate'] as String),
      (json['Quantity'] as num).toDouble(),
      json['BalanceGames'] as int,
      json['GameId'] as int,
      json['GameProfileId'] as int,
      (json['AccountGameExtendedDTOList'] as List<dynamic>?)
          ?.map((e) =>
              AccountGameExtendedDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountGameDTOListToJson(AccountGameDTOList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FromDate', instance.fromDate?.toIso8601String());
  writeNotNull('ExpiryDate', instance.expiryDate?.toIso8601String());
  val['Quantity'] = instance.quantity;
  val['BalanceGames'] = instance.balanceGames;
  val['GameId'] = instance.gameId;
  val['GameProfileId'] = instance.gameProfileId;
  writeNotNull(
      'AccountGameExtendedDTOList', instance.accountGameExtendedDTOList);
  return val;
}

AccountGameExtendedDTOList _$AccountGameExtendedDTOListFromJson(
        Map<String, dynamic> json) =>
    AccountGameExtendedDTOList(
      json['GameProfileId'] as int?,
      json['GameId'] as int?,
      json['Exclude'] as bool,
      json['PlayLimitPerGame'] as int?,
    );

Map<String, dynamic> _$AccountGameExtendedDTOListToJson(
    AccountGameExtendedDTOList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GameProfileId', instance.gameProfileId);
  writeNotNull('GameId', instance.gameId);
  val['Exclude'] = instance.exclude;
  writeNotNull('PlayLimitPerGame', instance.playLimitPerGame);
  return val;
}
