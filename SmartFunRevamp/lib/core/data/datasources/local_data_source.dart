import 'package:dartz/dartz.dart';
import 'package:glutton/glutton.dart';
import 'package:logger/logger.dart';
import 'package:semnox/core/errors/failures.dart';
import 'package:semnox_core/modules/sites/model/site_view_dto.dart';

abstract class LocalDataSource {
  static String kSitesListKey = 'sites_list';
  static String kFirstTime = 'first_time';
  static String kSelectedSite = 'selected_site';
  Future<void> saveSites(List<SiteViewDTO> sites);
  Future<List<SiteViewDTO>> retrieveSites();
  Future<void> saveBool(String key, bool value);
  Future<bool> retrieveBool(String key);
  Future<void> saveCustomClass(String key, Map<String, dynamic> json);
  Future<Either<Failure, Map<String, dynamic>>> retrieveCustomClass(String key);
}

class GluttonLocalDataSource implements LocalDataSource {
  @override
  Future<void> saveSites(List<SiteViewDTO> sites) async {
    try {
      final result = await Glutton.eat(LocalDataSource.kSitesListKey, sites.map((e) => e.toJson()).toList());
      Logger().d('Result->$result');
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<List<SiteViewDTO>> retrieveSites() async {
    try {
      final List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(await Glutton.vomit(LocalDataSource.kSitesListKey, []));
      return list.map((e) => SiteViewDTO.fromJson(e)).toList();
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  @override
  Future<bool> retrieveBool(String key) async {
    try {
      return await Glutton.vomit(key, false);
    } catch (e) {
      Logger().e(e);
      return false;
    }
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    try {
      final result = await Glutton.eat(key, value);
      Logger().d('Result->$result');
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  Future<void> saveCustomClass(String key, Map<String, dynamic> json) async {
    try {
      final result = await Glutton.eat(key, json);
      Logger().d('Result->$result');
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
}
