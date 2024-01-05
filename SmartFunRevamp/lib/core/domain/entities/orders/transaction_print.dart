import 'package:json_annotation/json_annotation.dart';
part 'transaction_print.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionPrint {
  String name;
  String format;
  String documentType;
  int templateId;
  int pOSPrinterId;
  String data;

  TransactionPrint(
    this.name,
    this.format,
    this.documentType,
    this.templateId,
    this.pOSPrinterId,
    this.data);

  factory TransactionPrint.fromJson(Map<String, dynamic> json) =>
      _$TransactionPrintFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionPrintToJson(this);
}