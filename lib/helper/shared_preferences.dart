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

  static Future<void> removePref() async{
     final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  static Future<void> setUserId(String key, int val) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key,val);
  }

  static Future<int> getUser(String key) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }

  static Future<void> setUserName(String key, String name) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key,name);
  }

  static Future<String> getUserName(String key) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  

 

}