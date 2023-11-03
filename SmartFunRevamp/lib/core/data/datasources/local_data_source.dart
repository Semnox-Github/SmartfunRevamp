import 'package:dartz/dartz.dart';
import 'package:glutton/glutton.dart';

import 'package:logger/logger.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/customer/model/customer/customer_dto.dart';

abstract class LocalDataSource {
  static String kSitesListKey = 'sites_list';
  static String kFirstTime = 'first_time';
  static String kSelectedSite = 'selected_site';
  static String kUserId = 'userId';
  static String kUser = 'user';
  static String kSplashScreenURL = 'splash_image_url';
  static String kTransactionId = 'transaction_id';
  static String kAppUpdateReminderDate = "app_update_reminder_date";
  static String kLanguagesContainer = "languanges_container";
  static String kSelectedLanguage = "selected_language";

  // Future<bool> retrieveBool(String key);
  Future<void> saveValue(String key, dynamic value);
  Future<T?> retrieveValue<T>(String key);
  Future<int?> retrieveLastTransactionId();
  Future<void> deleteValue(String key);
  Future<void> saveCustomClass(String key, Map<String, dynamic> json);
  Future<void> deleteCustomClass(String key);
  Future<Either<Failure, Map<String, dynamic>>> retrieveCustomClass(String key);
  Future<Map<String, dynamic>?> retrieveJsonClass(String key);
  Future<void> saveUser(CustomerDTO customerDTO);
  Future<void> logoutUser();
  Future<void> resetUser();
  Future<CustomerDTO?> retrieveCustomer();
}

class GluttonLocalDataSource implements LocalDataSource {
  @override
  Future<void> saveValue(String key, dynamic value) async {
    try {
      await Glutton.eat(key, value);
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<T?> retrieveValue<T>(String key) async {
    try {
      return await Glutton.vomit(key) as T;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteValue(String key) async {
    try {
      await Glutton.digest(key);
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<void> saveCustomClass(String key, Map<String, dynamic> json) async {
    try {
      await Glutton.eat(key, json);
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> retrieveCustomClass(String key) async {
    try {
      return Right(await Glutton.vomit(key));
    } catch (e) {
      Logger().e(e);
      return Left(LocalDataSourceFailure('Error Retrieving Key'));
    }
  }

  @override
  Future<Map<String, dynamic>?> retrieveJsonClass(String key) async {
    return await Glutton.vomit(key, null);
  }

  @override
  Future<void> deleteCustomClass(String key) async {
    try {
      if (key == LocalDataSource.kSelectedSite) {
        Logger().i('Selected Key deleted');
      }
      await Glutton.digest(key);
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<CustomerDTO?> retrieveCustomer() async {
    try {
      final json = await Glutton.vomit(LocalDataSource.kUser) as Map<String, dynamic>;
      return CustomerDTO.fromJson(json);
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  @override
  Future<int?> retrieveLastTransactionId() async {
    try {
      final lastTransactionId = await Glutton.vomit(LocalDataSource.kTransactionId);
      return lastTransactionId as int;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  @override
  Future<void> saveUser(CustomerDTO customerDTO) async {
    await Glutton.eat(LocalDataSource.kUser, customerDTO.toJson());
  }

  @override
  Future<void> logoutUser() async {
    try {
      await Glutton.digest(LocalDataSource.kUserId);
      await Glutton.digest(LocalDataSource.kUser);
      await Glutton.digest(LocalDataSource.kSelectedSite);
      await Glutton.digest(LocalDataSource.kTransactionId);
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<void> resetUser() async {
    try {
      await Glutton.digest(LocalDataSource.kUserId);
      await Glutton.digest(LocalDataSource.kUser);
    } catch (e) {
      Logger().e(e);
    }
  }
}
