import 'package:json_annotation/json_annotation.dart';
part 'account_gameplays.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class AccountGameplays {
  final int gameplayId;
  final String? playDate;
  final String? game;
  final String? site;
  final double? credits;
  final double courtesy;
  final double? bonus;
  final double time;
  final double? cpBonus;
  final double? cpCredits;
  final double? cpCardBalance;
  final double cardGame;
  final double? CPBonus;
  final double? CPCredits;

  AccountGameplays(
      this.gameplayId,
      this.playDate,
      this.game,
      this.site,
      this.credits,
      this.courtesy,
      this.bonus,
      this.time,
      this.cpBonus,
      this.cpCredits,
      this.cpCardBalance,
      this.cardGame,
      this.CPBonus,
      this.CPCredits
      );
  factory AccountGameplays.fromJson(Map<String, dynamic> json) =>
      _$AccountGameplaysFromJson(json);
  Map<String, dynamic> toJson() => _$AccountGameplaysToJson(this);
}
