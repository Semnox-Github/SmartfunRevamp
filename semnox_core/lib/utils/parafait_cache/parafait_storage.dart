import 'dart:convert';
import 'package:semnox_core/utils/storage_service/local_storage.dart';

class ParafaitStorage<T> {
  String? _storageKey;
  int _dataLifeInMins = 60;
  ParafaitStorage(String? storageKey, int dataLifeInMins) {
    _storageKey = storageKey;
    _dataLifeInMins = dataLifeInMins;
  }

  void addToLocalStorage(
      String? dataKey, T? dataList, String? serverHash) async {
    ParafaitStorageItem? _storageItem = ParafaitStorageItem(
        dataKey: dataKey,
        dataList: dataList,
        serverHash: serverHash,
        lastRefreshedTime: DateTime.now().toIso8601String());

    //Changed Today
    LocalStorage().save(_storageKey!,
        json.encode(_storageItem)); // Not getting Saved in LocalStorage
  }

  void clearFromLocalStorage() {
    LocalStorage().save(_storageKey!, "");
  }

  bool isLocalDataStale(String dataKey) {
    var data = LocalStorage().get(_storageKey!);
    ParafaitStorageItem? _storageItem = json.decode(data!);
    if (_storageItem!.getDataKey() == dataKey) {
      return _isLocalDataStale(_storageItem);
    } else {
      return false;
    }
  }

  bool _isLocalDataStale(ParafaitStorageItem? _storageItem) {
    var _lastRefreshedTime = _storageItem!.getLastRefreshedTime();
    if (_lastRefreshedTime == null) {
      return true;
    }
    if (DateTime.parse(_lastRefreshedTime).isBefore(
        DateTime.now().subtract(Duration(minutes: _dataLifeInMins)))) {
      return true;
    }
    return false;
  }

  Future<String?> getServerHash(String dataKey) async {
    var data = LocalStorage().get(_storageKey!);
    if (data == null) {
      return null;
    } else {
      ParafaitStorageItem? _storageItem =
          ParafaitStorageItem.fromJson(json.decode(data));
      if (_storageItem.getDataKey() == dataKey &&
          !_isLocalDataStale(_storageItem)) {
        return _storageItem.getServerHash();
      } else {
        return null;
      }
    }
  }

  Future<T?> getDataFromLocalStorage(String dataKey) async {
    var data = LocalStorage().get(_storageKey!);
    if (data == null) {
      return null;
    } else {
      var valueMap = json.decode(data);

      ParafaitStorageItem? _storageItem =
          ParafaitStorageItem.fromJson(valueMap);
      if (_storageItem.getDataKey() == dataKey &&
          !_isLocalDataStale(_storageItem)) {
        return _storageItem.getDataList();
      } else {
        return null;
      }
    }
  }
}

class ParafaitStorageItem<T> {
  String? _dataKey;
  T? _dataList;
  String? _lastRefreshedTime;
  String? _serverHash;

  ParafaitStorageItem(
      {String? dataKey,
      T? dataList,
      String? serverHash,
      String? lastRefreshedTime}) {
    _dataKey = dataKey;
    _dataList = dataList;
    _lastRefreshedTime = lastRefreshedTime;
    _serverHash = serverHash;
  }

  String? getDataKey() {
    return _dataKey;
  }

  T? getDataList() {
    return _dataList;
  }

  String? getLastRefreshedTime() {
    return _lastRefreshedTime;
  }

  String? getServerHash() {
    return _serverHash;
  }

  String? get dataKey => _dataKey;
  T? get dataList => _dataList;
  String? get lastRefreshedTime => _lastRefreshedTime;
  String? get serverHash => _serverHash;

  factory ParafaitStorageItem.fromJson(Map<String, dynamic> json) =>
      ParafaitStorageItem(
          dataKey: json['dataKey'],
          dataList: json['dataList'],
          lastRefreshedTime: json['lastRefreshedTime'],
          serverHash: json['serverHash']);

  Map<String, dynamic> toJson() => {
        'dataKey': _dataKey,
        'dataList': _dataList,
        'lastRefreshedTime': _lastRefreshedTime,
        'serverHash': _serverHash
      };
}
