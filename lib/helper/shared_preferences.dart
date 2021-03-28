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

  static Future<void> removePref(String key) async{
     final SharedPreferences pref = await SharedPreferences.getInstance();
     pref.remove(key);
  }

  static Future<void> setUserId(String key, int val) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key,val);
  }

  static Future<int> getUser(String key) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  static int getUserId(String key) async{
    int user = await getUser(key);

  }

}