import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
part 'hosted_payment_gateway_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class HostedPaymentGatewayRequest extends Equatable{
  HostedPaymentGatewayRequest({
    required this.hostedPaymentGateway,
    required this.amount,
    required this.transactionId,
  });
  
  final String hostedPaymentGateway;
  final double amount;
  final int transactionId;

  @override
  List<Object> get props => [hostedPaymentGateway, amount, transactionId];
}


 