import 'package:json_annotation/json_annotation.dart';
part 'posmachine_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class PosMachineContainer{
  final List<PosMachineContainerDTOList> POSMachineContainerDTOList;

  PosMachineContainer(
      this.POSMachineContainerDTOList,
      );

  factory PosMachineContainer.fromJson(Map<String, dynamic> json) => _$PosMachineContainerFromJson(json);
  Map<String, dynamic> toJson() => _$PosMachineContainerToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.pascal)
class PosMachineContainerDTOList {
  int pOSMachineId;
  String pOSName;
  String computerName;
  List<PaymentModeInclusionsContainerDTOList>
  pOSPaymentModeInclusionContainerDTOList;

  PosMachineContainerDTOList(this.pOSMachineId,
    this.pOSName,
    this.computerName,
    this.pOSPaymentModeInclusionContainerDTOList);

  factory PosMachineContainerDTOList.fromJson(Map<String, dynamic> json) => _$PosMachineContainerDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$PosMachineContainerDTOListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class PaymentModeInclusionsContainerDTOList {
  int pOSPaymentModeInclusionId;
  int pOSMachineId;
  int paymentModeId;
  String friendlyName;

  PaymentModeInclusionsContainerDTOList(this.pOSPaymentModeInclusionId,
    this.pOSMachineId,
    this.paymentModeId,
    this.friendlyName);

  factory PaymentModeInclusionsContainerDTOList.fromJson(Map<String, dynamic> json) => _$PaymentModeInclusionsContainerDTOListFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModeInclusionsContainerDTOListToJson(this);
}