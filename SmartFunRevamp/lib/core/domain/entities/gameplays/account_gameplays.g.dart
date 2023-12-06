// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_gameplays.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountGameplays _$AccountGameplaysFromJson(Map<String, dynamic> json) =>
    AccountGameplays(
      json['GameplayId'] as int,
      json['PlayDate'] as String?,
      json['Game'] as String?,
      json['Site'] as String?,
      (json['Credits'] as num).toDouble(),
      (json['Courtesy'] as num).toDouble(),
      (json['Bonus'] as num).toDouble(),
      (json['Time'] as num).toDouble(),
      (json['CPBonus'] as num).toDouble(),
      (json['CPCredits'] as num).toDouble(),
      (json['CPCardBalance'] as num).toDouble(),
      (json['CardGame'] as num).toDouble(),
    );

Map<String, dynamic> _$AccountGameplaysToJson(AccountGameplays instance) {
  final val = <String, dynamic>{
    'GameplayId': instance.gameplayId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlayDate', instance.playDate);
  writeNotNull('Game', instance.game);
  writeNotNull('Site', instance.site);
  val['Credits'] = instance.credits;
  val['Courtesy'] = instance.courtesy;
  val['Bonus'] = instance.bonus;
  val['Time'] = instance.time;
  val['CPBonus'] = instance.cpBonus;
  val['CPCredits'] = instance.cpCredits;
  val['CPCardBalance'] = instance.cpCardBalance;
  val['CardGame'] = instance.cardGame;

  return val;
}
