import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  
  static Future<void> setPref(String key, int val) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key,val);
  }

  static Future<int> getPref(String key) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }
}