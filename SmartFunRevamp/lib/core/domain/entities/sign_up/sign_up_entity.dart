import 'package:json_annotation/json_annotation.dart';
import 'package:semnox/core/enums/contact_enum.dart';
import 'package:semnox_core/modules/customer/model/customer/address_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/custom_data_set_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/phone_contact_dto.dart';
import 'package:semnox_core/modules/customer/model/customer/profile_dto.dart';
part 'sign_up_entity.g.dart';

enum MetaDataKeys {
  customerId('CUSTOMER_ID'),
  cardNumber("CARD_NUMBER"),
  membership("MEMBERSHIP"),
  customerLastUpdatedBy("CUSTOMER_LAST_UPDATED_BY"),
  customerLastUpdatedDate("CUSTOMER_LAST_UPDATED_DATE"),

  // Display Only
  customerName("CUSTOMER_NAME"),
  firstName("FIRST_NAME"), // Display Name for CUSTOMER_NAME
  middleName("MIDDLE_NAME"),
  lastName("LAST_NAME"),
  birthDate("BIRTH_DATE"),
  gender("GENDER"),
  anniversary("ANNIVERSARY"),
  notes("NOTES"),
  designation("DESIGNATION"),
  uniqueId("UNIQUE_ID"),
  username("USERNAME"),
  rightHanded("RIGHTHANDED"),
  teamUser("TEAMUSER"),
  customerPhoto("CUSTOMER_PHOTO"),
  verified("VERIFIED"),
  password("PASSWORD"),
  lastLoginTime("LASTLOGINTIME"),
  externalSystemRef("EXTERNALSYSTEMREF"),
  downloadBatchId("DOWNLOADBATCHID"),
  channel("CHANNEL"),
  taxCode("TAXCODE"),
  company("COMPANY"),
  idProofFileName("IDPROOFFILENAME"),
  title("TITLE"),
  optInPromotions("OPT_IN_PROMOTIONS"),
  optInPromotionsMode("OPT_IN_PROMOTIONS_MODE"),
  termsAndConditions("TERMS_AND_CONDITIONS"),

  //ADDRESS_FIELDS
  city("CITY"),
  state("STATE"),
  country("COUNTRY"),
  pin("PIN"),
  address1("ADDRESS1"),
  address2("ADDRESS2"),
  address3("ADDRESS3"),
  addressType("ADDRESS_TYPE"),
  // ACTIVE

  // CONTACT_FIELDS
  contactPhone("CONTACT_PHONE"),
  email("EMAIL"),
  fbUserId("FBUSERID"),
  fbAccessToken("FBACCESSTOKEN"),
  twAccessToken("TWACCESSTOKEN"),
  twAccessSecret("TWACCESSSECRET"),
  wechatAccessToken("WECHAT_ACCESS_TOKEN"),
  countryCode("COUNTRY_CODE"),
  countryId("COUNTRY_ID"),
  // PASSWORD="PASSWORD"),

  // Contact Table columns
  contactType("CONTACT_TYPE"),
  attribute1("ATTRIBUTE_1"),
  attribute2("ATTRIBUTE_2");
  
  const MetaDataKeys(this.key);
  final String key;
}

@JsonSerializable()
class SignUpEntity {
  SignUpEntity(
      {int? id,
      int? profileId,
      int? masterEntityId,
      int? membershipId,
      ProfileDTO? profileDto,
      CustomDataSetDTO? customDataSetDto,
      String? creationDate,
      String? lastUpdateDate,
      int? siteId,
      String? guid,
      // we need to check
      //  String? memberShipName,
      String? phone,
      String? email}) {
    _id = id;
    _profileId = profileId;
    _masterEntityId = masterEntityId;
    _membershipId = membershipId;
    _profileDto = profileDto;
    _customDataSetDto = customDataSetDto;
    _creationDate = creationDate;
    _lastUpdateDate = lastUpdateDate;
    _siteId = siteId;
    _guid = guid;
    //  _memberShipName = memberShipName;
    _phone = phone;
    _email = email;
  }

  int? _id;
  int? _profileId;
  int? _masterEntityId;
  int? _membershipId;
  ProfileDTO? _profileDto;
  CustomDataSetDTO? _customDataSetDto;
  String? _creationDate;
  String? _lastUpdateDate;
  int? _siteId;
  String? _guid;
  String? _memberShipName;
  String? _phone;
  String? _email;

  int? get id => _id;
  int? get profileId => _profileId;
  int? get masterEntityId => _masterEntityId;
  int? get membershipId => _membershipId;
  CustomDataSetDTO? get customDataSetDto => _customDataSetDto;
  String? get creationDate => _creationDate;
  String? get lastUpdateDate => _lastUpdateDate;
  int? get siteId => _siteId;
  String? get guid => _guid;
  String? get memberShipName => _memberShipName;
  String? get phone => _phone;
  String? get email => _email;

  // ProfileDTO gettter
  ProfileDTO? get profileDto => _profileDto;
  int? get profileTypeId => _profileDto?.profileTypeId;
  int? get profileType => _profileDto?.profileType;
  String? get title => _profileDto?.title;
  String? get firstName => _profileDto?.firstName;
  String? get middleName => _profileDto?.middleName;
  String? get lastName => _profileDto?.lastName;
  String? get nickName => _profileDto?.nickName;
  String? get notes => _profileDto?.notes;
  String? get dateOfBirth => _profileDto?.dateOfBirth;
  String? get gender => _profileDto?.gender;
  String? get anniversary => _profileDto?.anniversary;
  String? get photoUrl => _profileDto?.photoUrl;
  bool? get rightHanded => _profileDto?.rightHanded;
  bool? get teamUser => _profileDto?.teamUser;
  String? get uniqueIdentifier => _profileDto?.uniqueIdentifier;
  String? get idProofFileUrl => _profileDto?.idProofFileUrl;
  String? get taxCode => _profileDto?.taxCode;
  String? get designation => _profileDto?.designation;
  String? get company => _profileDto?.company;
  String? get userName => _profileDto?.userName;
  String? get password => _profileDto?.password;
  String? get lastLoginTime => _profileDto?.lastLoginTime;
  List<PhoneContactDTO>? get contactDtoList => _profileDto?.contactDtoList;
  List<AddressDTO>? get addressDtoList => _profileDto?.addressDtoList;
  dynamic get profileContentHistoryDtoList => _profileDto?.profileContentHistoryDtoList;
  bool? get optInPromotions => _profileDto?.optInPromotions;
  String? get optInPromotionsMode => _profileDto?.optInPromotionsMode;
  String? get optInLastUpdatedDate => _profileDto?.optInLastUpdatedDate;
  bool? get policyTermsAccepted => _profileDto?.policyTermsAccepted;
  bool? get isActive => _profileDto?.isActive;
  String? get profilecreatedBy => _profileDto?.createdBy;
  String? get profilecreationDate => _profileDto?.creationDate;
  String? get profilelastUpdatedBy => _profileDto?.lastUpdatedBy;
  String? get profilelastUpdateDate => _profileDto?.lastUpdateDate;
  bool? get synchStatus => _profileDto?.synchStatus;
  String? get externalSystemReference => _profileDto?.externalSystemReference;
  bool? get optOutWhatsApp => _profileDto?.optOutWhatsApp;
  String? get userStatus => _profileDto?.userStatus;
  String? get passwordChangeDate => _profileDto?.passwordChangeDate;
  int? get invalidAccessAttempts => _profileDto?.invalidAccessAttempts;
  String? get lockedOutTime => _profileDto?.lockedOutTime;
  bool? get passwordChangeOnNextLogin => _profileDto?.passwordChangeOnNextLogin;
  bool? get isChanged => _profileDto?.isChanged;
  bool? get isChangedRecursive => _profileDto?.isChangedRecursive;


  Map<String, dynamic> toJson() => _$SignUpEntityToJson(this);
  factory SignUpEntity.fromJson(Map<String, dynamic> json) => _$SignUpEntityFromJson(json);
  factory SignUpEntity.fromMetaData(Map<String, dynamic> json) {
    
    List<CustomDataDTO> customDataDtoList = [];
    ProfileDTO profile = ProfileDTO();
    String? email;
    String? phone;
    List<PhoneContactDTO> phoneContactDTO = [];
    //iterate the dynamic fields to set values 
    json.forEach((key, value) { 
      switch(key) {
        case "FIRST_NAME":
          profile.firtName = value["value"];
          break;
        case "CUSTOMER_NAME":
          profile.firtName = value["value"];
          break;
        case "MIDDLE_NAME":
          profile.middleName = value["value"];
          break;
        case "LAST_NAME":
          profile.lastName = value["value"];
          break;
        case "BIRTH_DATE":
          profile.dateOfBirth = value["value"];
          break;
        case "GENDER":
          profile.gender = value["value"];
          break;
        case "ANNIVERSARY":
          profile.anniversary = value["value"];
          break;
        case "NOTES":
          profile.notes = value["value"];
          break;
        case "DESIGNATION":
          profile.designation = value["value"];
          break;
        case "UNIQUE_ID":
          profile.uniqueIdentifier = value["value"];
          break;
        case "USERNAME":
          profile.userName = value["value"];
          break;
        case "RIGHTHANDED":
          profile.rightHanded = value["value"] == 'true' ? true : false;
          break;
        case "PASSWORD":
          profile.password = value["value"];
          break;
        case "TAXCODE":
          profile.taxCode = value["value"];
          break;
        case "COMPANY":
          profile.company = value["value"];
          break;
        case "TITLE":
          profile.title = value["value"];
          break;
        case "TERMS_AND_CONDITIONS":
          profile.policyTermsAccepted = value["value"] == 'true' ? true : false;
          break;
        case "EMAIL":
          phoneContactDTO.add(PhoneContactDTO(
            contactTypeId: ContactType.email.typeId,
            contactType: ContactType.email.type,
            attribute1: value["value"],
            isActive: true,
          ));
          email = value["value"];
          break;
        case "CONTACT_PHONE":
          phoneContactDTO.add(PhoneContactDTO(
            contactTypeId: ContactType.phone.typeId,
            contactType: ContactType.phone.type,
            attribute1: value["value"],
            isActive: true,
          ));
          phone = value["value"];
          break;
        case "WECHAT_ACCESS_TOKEN":
          phoneContactDTO.add(PhoneContactDTO(
            contactTypeId: ContactType.wechat.typeId,
            contactType: ContactType.wechat.type,
            attribute1: value["value"],
            isActive: true,
          ));
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
    //if contact list has elements then set value
    if (phoneContactDTO.length > 1) {
      profile.contactDtoList = phoneContactDTO;
    }
  
    return SignUpEntity(
      email: email,
      profileDto: profile,
      phone: phone,
      customDataSetDto: CustomDataSetDTO(customDataDtoList: customDataDtoList)      
    );
  }
}
