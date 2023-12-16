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

Future<String> getToken() async {
  dynamic storage = getStorageInstance();
  if (kIsWeb) {
    LocalStorage webStorage = storage;
    await webStorage.ready;
    final token = webStorage.getItem('token');
    print('este es el token: $token');
    return token ?? '';
  } else {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}
