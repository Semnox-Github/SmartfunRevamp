// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posmachine_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosMachineContainer _$PosMachineContainerFromJson(Map<String, dynamic> json) =>
    PosMachineContainer(
      (json['POSMachineContainerDTOList'] as List<dynamic>)
          .map((e) =>
              PosMachineContainerDTOList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PosMachineContainerToJson(
        PosMachineContainer instance) =>
    <String, dynamic>{
      'POSMachineContainerDTOList': instance.POSMachineContainerDTOList,
    };

PosMachineContainerDTOList _$PosMachineContainerDTOListFromJson(
        Map<String, dynamic> json) =>
    PosMachineContainerDTOList(
      json['POSMachineId'] as int,
      json['POSName'] as String,
      json['ComputerName'] as String,
      (json['POSPaymentModeInclusionContainerDTOList'] as List<dynamic>)
          .map((e) => PaymentModeInclusionsContainerDTOList.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PosMachineContainerDTOListToJson(
        PosMachineContainerDTOList instance) =>
    <String, dynamic>{
      'POSMachineId': instance.pOSMachineId,
      'POSName': instance.pOSName,
      'ComputerName': instance.computerName,
      'POSPaymentModeInclusionContainerDTOList':
          instance.pOSPaymentModeInclusionContainerDTOList,
    };

PaymentModeInclusionsContainerDTOList
    _$PaymentModeInclusionsContainerDTOListFromJson(
            Map<String, dynamic> json) =>
        PaymentModeInclusionsContainerDTOList(
          json['POSPaymentModeInclusionId'] as int,
          json['POSMachineId'] as int,
          json['PaymentModeId'] as int,
          json['FriendlyName'] as String,
        );

Map<String, dynamic> _$PaymentModeInclusionsContainerDTOListToJson(
        PaymentModeInclusionsContainerDTOList instance) =>
    <String, dynamic>{
      'POSPaymentModeInclusionId': instance.pOSPaymentModeInclusionId,
      'POSMachineId': instance.pOSMachineId,
      'PaymentModeId': instance.paymentModeId,
      'FriendlyName': instance.friendlyName,
    };
