/*
import 'package:sailserver_iternal/core/error/exceptions.dart';
import 'package:sailserver_iternal/features/user_feature/data/datasources/aminUser_local_data_source.dart';
import 'package:sailserver_iternal/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;


  UserLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<void> cacheUser(String email, String password) async  {
   await sharedPreferences.setString(EMAIL_KEY, email);
   await sharedPreferences.setString(PASSWORD_KEY, password);
  }

  @override
  Future<void> deleteUser() async  {
    await sharedPreferences.remove(EMAIL_KEY);
    await sharedPreferences.remove(PASSWORD_KEY);
  }

  @override
  String getEmail() {
    String? email = sharedPreferences.getString(EMAIL_KEY);
    if (email != null) {
      return email;
    } else {
      throw CacheException();
    }
  }

  @override
  String getPassword() {
    String? password = sharedPreferences.getString(PASSWORD_KEY);
    if (password != null) {
      return password;
    } else {
      throw CacheException();
    }
  }
}


 */