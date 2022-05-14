import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late final SharedPreferences sharedPreferences;

  static void setSharedPreferences(SharedPreferences instance) =>
      sharedPreferences = instance;
}
