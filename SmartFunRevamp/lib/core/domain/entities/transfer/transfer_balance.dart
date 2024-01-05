import 'package:semnox/core/domain/entities/card_details/card_details.dart';

class TransferBalance {
  final CardDetails from;
  CardDetails to;
  final num amount;
  final String entitlement;
  final int entitlementType;

  TransferBalance(this.from, this.to, this.amount, this.entitlement, this.entitlementType);

  Map<String, dynamic> toJson() {
    return {
      "SourceAccountDTO": {"AccountId": from.accountId},
      "DestinationAccountDTO": {"AccountId": to.accountId},
      entitlement: amount,
    };
  }
}
