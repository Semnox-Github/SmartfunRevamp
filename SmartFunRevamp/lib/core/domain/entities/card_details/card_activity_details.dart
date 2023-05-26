import 'package:json_annotation/json_annotation.dart';
import 'package:semnox/core/domain/entities/buy_card/estimate_transaction_response.dart';
part 'card_activity_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class CardActivityDetails {
  final int transactionId;
  final String transactionOTP;
  final String? receiptHTML;
  final String? receipt;
  final DateTime? transactionDate;
  final List<TransactionLinesDTO>? transactionLinesDTOList;
  final List<TrxPaymentsDTOList>? trxPaymentDTOList;

  CardActivityDetails(
    this.transactionId,
    this.transactionOTP,
    this.transactionDate,
    this.transactionLinesDTOList,
    this.trxPaymentDTOList,
    this.receiptHTML,
    this.receipt
  );
  factory CardActivityDetails.fromJson(Map<String, dynamic> json) => _$CardActivityDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CardActivityDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class TrxPaymentsDTOList {
  final num amount;

  TrxPaymentsDTOList(this.amount);
  factory TrxPaymentsDTOList.fromJson(Map<String, dynamic> json) => _$TrxPaymentsDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$TrxPaymentsDTOListToJson(this);
}
