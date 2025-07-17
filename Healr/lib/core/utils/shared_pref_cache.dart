import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefCache {
  static late SharedPreferences sharedPref;

  static Future initSharedPref() async {
    sharedPref = await SharedPreferences.getInstance();
  }

 static Future<bool> saveCache({required String key,required String value}) async {
    return await sharedPref.setString(key, value);
  }

 static String getCache({ required String key}) {
    return sharedPref.getString(key) ?? '';
  }

 static Future<bool> removeCache({required String key}) async {
    return await sharedPref.remove(key);
  }
}
