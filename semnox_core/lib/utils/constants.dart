class SemnoxConstants {
  SemnoxConstants._();

  static String get lookupUrl => "/api/Lookups/LookupsContainer";
  static String get genericAssetUrl => "/api/Maintenance/GenericAssets";
  static String get langauageContainerUrl =>
      "/api/Configuration/LanguageContainer";
  static String get translationUrl => "/api/Communication/MessageContainer";
  static String get remoteConnectionUrl => "/api/Common/RemoteConnectionCheck";
  static String get defaultContainerUrl =>
      "/api/Configuration/ParafaitDefaultContainer";
  static String get posMachineContainerUrl => "/api/POS/POSMachinesContainer";
  static String get siteContainerUrl => "/api/Organization/SiteContainer";

  static String get authenticateSystemUsersUrl =>
      "/api/Login/AuthenticateSystemUsers";
  static String get authenticateAppUsersUrl =>
      "/api/Login/AuthenticateUsersNew";

  static String get otpUrl => "/api/CommonServices/GenericOTP";
  static String get customersUrl => "/api/Customer/Customers";
  static String get customerLoginUrl => "/api/Customer/CustomerLogin";

  static const Duration animationDuration = Duration(milliseconds: 250);
}
