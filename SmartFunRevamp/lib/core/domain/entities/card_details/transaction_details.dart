import 'package:json_annotation/json_annotation.dart';
part 'transaction_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionDetail {
  final int transactionId;
  final String transactionOTP;
  final String? receipt;
  final String? status;
  final double? transactionTaxTotal;
  final double? transactionNetAmount;
  final DateTime? transactionDate;
  final List<TransactionLineDTO>? transactionLineDTOList;
  final List<TransactionTaxLineDTOList>? transactionTaxLineDTOList;

  TransactionDetail(
      this.transactionId,
      this.transactionOTP,
      this.transactionDate,
      this.transactionLineDTOList,
      this.transactionTaxLineDTOList,
      this.receipt,
      this.status,
      this.transactionTaxTotal,
      this.transactionNetAmount
      );
  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionDetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionLineDTO {
  final String TagNumber;
  final String ProductName;

  TransactionLineDTO(this.TagNumber,this.ProductName);
  factory TransactionLineDTO.fromJson(Map<String, dynamic> json) =>
      _$TransactionLineDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionLineDTOToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TransactionTaxLineDTOList {
  final double TaxAmount;

  TransactionTaxLineDTOList(this.TaxAmount);
  factory TransactionTaxLineDTOList.fromJson(Map<String, dynamic> json) =>
      _$TransactionTaxLineDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionTaxLineDTOListToJson(this);
}