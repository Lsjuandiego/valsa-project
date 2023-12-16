import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic getStorageInstance() {
  if (kIsWeb) {
    return LocalStorage('my_web_storage');
  } else {
    return SharedPreferences.getInstance();
  }
}
