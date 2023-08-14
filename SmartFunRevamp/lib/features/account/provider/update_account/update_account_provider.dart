import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/instance_manager.dart';
import 'package:semnox/core/domain/use_cases/authentication/sign_up_user_use_case.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_set_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';
part 'update_account_state.dart';
part 'update_account_provider.freezed.dart';

final updateAccountProvider = StateNotifierProvider<AccountProvider, UpdateAccountState>(
  (ref) => AccountProvider(Get.find<SignUpUserUseCase>()),
);

class AccountProvider extends StateNotifier<UpdateAccountState> {
  AccountProvider(this._updateUseCase) : super(const _Initial());
  final SignUpUserUseCase _updateUseCase;
  Future<void> updateProfile(CustomerDTO customerDTO, Map<String, dynamic> request) async {

    List<PhoneContactDTO>? phoneContactDTOList = customerDTO.profileDto?.contactDtoList;
    List<PhoneContactDTO> newPhoneContactDTOList= [];
    List<CustomDataDTO> customDataDtoList = [];

    request.forEach((key, value) {
      switch(key) {
        case "FIRST_NAME":
          customerDTO.profileDto?.firtName = value["value"];
          break;
        case "CUSTOMER_NAME":
          customerDTO.profileDto?.firtName = value["value"];
          break;
        case "MIDDLE_NAME":
          customerDTO.profileDto?.middleName = value["value"];
          break;
        case "LAST_NAME":
          customerDTO.profileDto?.lastName = value["value"];
          break;
        case "BIRTH_DATE":
          customerDTO.profileDto?.dateOfBirth = value["value"];
          break;
        case "GENDER":
          customerDTO.profileDto?.gender = value["value"];
          break;
        case "ANNIVERSARY":
          customerDTO.profileDto?.anniversary = value["value"];
          break;
        case "NOTES":
          customerDTO.profileDto?.notes = value["value"];
          break;
        case "DESIGNATION":
          customerDTO.profileDto?.designation = value["value"];
          break;
        case "UNIQUE_ID":
          customerDTO.profileDto?.uniqueIdentifier = value["value"];
          break;
        case "USERNAME":
          customerDTO.profileDto?.userName = value["value"];
          break;
        case "RIGHTHANDED":
          customerDTO.profileDto?.rightHanded = value["value"];
          break;
        case "PASSWORD":
          customerDTO.profileDto?.password = value["value"];
          break;
        case "TAXCODE":
          customerDTO.profileDto?.taxCode = value["value"];
          break;
        case "COMPANY":
          customerDTO.profileDto?.company = value["value"];
          break;
        case "TITLE":
          customerDTO.profileDto?.title = value["value"];
          break;
        case "TERMS_AND_CONDITIONS":
          customerDTO.profileDto?.policyTermsAccepted = value["value"];
          break;
        case "EMAIL":
          customerDTO.profileDto?.userName = value["value"];
          customerDTO.email = value["value"];
          PhoneContactDTO email = PhoneContactDTO(
            contactTypeId: ContactType.email.typeId,
            contactType: ContactType.email.type,
            attribute1: value["value"],
            isActive: true,
          );
          newPhoneContactDTOList.add(email);
          break;
        case "CONTACT_PHONE":
          customerDTO.phone = value["value"];
          PhoneContactDTO phone = PhoneContactDTO(
            contactTypeId: ContactType.phone.typeId,
            contactType: ContactType.phone.type,
            attribute1: value["value"],
            isActive: true,
          );
          newPhoneContactDTOList.add(phone);
          break;

        case "WECHAT_ACCESS_TOKEN":          
          PhoneContactDTO weChat = PhoneContactDTO(
            contactTypeId: ContactType.wechat.typeId,
            contactType: ContactType.wechat.type,
            attribute1: value["value"],
            isActive: true,
          );
          newPhoneContactDTOList.add(weChat);
          break;

        default:
        
        //not included in case will be stored in custom data
          CustomDataDTO customDataDTO = CustomDataDTO(
            customAttributeId: value["customAttributeId"],
            customDataText: value["customerFieldType"] == "NUMBER" || value["customerFieldType"] == "DATE" ? null : value["value"],
            customDataNumber: value["customerFieldType"] == "NUMBER" ? int.parse(value["value"]) : null,
            customDataDate: value["customerFieldType"] == "DATE" ? DateTime.parse(value["value"]) : null
          );
          customDataDtoList.add(customDataDTO);  
      }

    });
    customerDTO.profileDto?.contactDtoList = newPhoneContactDTOList;
    customerDTO.profileDto?.isChanged = true;
    customerDTO.customDataSetDto = CustomDataSetDTO(customDataDtoList: customDataDtoList); 
    state = const _Loading();
    final response = await _updateUseCase(customerDTO.toJson());
    state = response.fold(
      (l) => const _Error('There was an error updating your profile please try again.'),
      (r) => _Success(r),
    );
  }
}
