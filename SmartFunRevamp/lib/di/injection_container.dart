import 'package:semnox/core/api/parafait_api.dart';
import 'package:semnox/core/api/smart_fun_api.dart';
import 'package:semnox/core/domain/entities/splash_screen/authenticate_system_user.dart';
import 'package:semnox/di/authentication_dependecies.dart';
import 'package:semnox/di/config_dependencies.dart';
import 'package:semnox/di/feedback_dependecies.dart';
import 'package:semnox/di/gameplays_dependencies.dart';
import 'package:semnox/di/home_dependecies.dart';
import 'package:semnox/di/membership_dependencies.dart';
import 'package:semnox/di/notifications_dependecies.dart';
import 'package:semnox/di/orders_dependencies.dart';
import 'package:semnox/di/products_price_dependecies.dart';
import 'package:semnox/di/select_location_dependecies.dart';
import 'package:semnox/di/payment_dependencies.dart';
import 'package:semnox/di/splash_screen_dependencies.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';
import 'package:get/get.dart';
import 'package:semnox_core/modules/execution_context/model/execution_context_dto.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

Future<void> init() async {
  Get.lazyPut(() => ParafaitApi());
  Get.lazyPut(() => SmartFunApi());
  selectLocationDependecies();
  splashScreenDependencies();
  authenticaionDependecies();
  gameplaysDependencies();
  paymentDependencies();
  productsPriceDependecies();
  selectLocationDependecies();
  homeDependecies();
  notificationsDependecies();
  membershipDependencies();
  feedbackDependencies();
  ordersDependencies();
  configDependecies();
}

void authenticateApi(SystemUser systemUser, String baseURL) {
  Get.replace(SmartFunApi(baseURL, systemUser.webApiToken ?? ''));
  Get.put<SystemUser>(systemUser);
  ExecutionContextDTO executionDTO = ExecutionContextDTO(
    apiUrl: baseURL,
    authToken: systemUser.webApiToken,
    siteId: systemUser.siteId,
  );
  Get.create<ExecutionContextDTO>(() => executionDTO);
}

void changeSiteId(SiteViewDTO siteViewDTO) {
  final executionContext = Get.find<ExecutionContextDTO>();
  Get.replace<ExecutionContextDTO>(
    ExecutionContextDTO(
      apiUrl: executionContext.apiUrl,
      authToken: executionContext.authToken,
      siteId: siteViewDTO.siteId,
    ),
  );
}

void registerUser(CustomerDTO customerDTO) {
  Get.replace<CustomerDTO>(customerDTO);
}
