import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/c_user.dart';
import '../model/user.dart';

class Session {

  // menyimpan session user
  static Future<bool> saveUser(User user) async {

    // Inisiasi SharedPreferences
    final pref = await SharedPreferences.getInstance();

    // koneversi kelas model menjadi Map Json
    Map<String, dynamic> mapUser = user.toJson();

    // konversi Map Json menjadi String
    String stringUser = jsonEncode(mapUser);

    // menyimpan ke shared preference, jika berhasil disimpan maka mengembalikan nilai true
    bool success = await pref.setString('user', stringUser);

    if (success) {
      // mengubah data pada controller user
      final cUser = Get.put(CUser());
      cUser.setData(user);
    }

    return success;
  }

  // Mendapatkan user saat ini yang sedang login
  static Future<User> getUser() async {

    User user = User(); // default value

    final pref = await SharedPreferences.getInstance();

    String? stringUser = pref.getString('user');

    if (stringUser != null) {

      // konversi dari String ke JSON Map
      Map<String, dynamic> mapUser = jsonDecode(stringUser);

      // konversi dari JSON Map ke Model User
      user = User.fromJson(mapUser);
    }

    // memasukan data ke kontrollernya
    final cUser = Get.put(CUser());
    cUser.setData(user);

    return user;
  }

  // Menghapus session user saat ini yang sedang login
  static Future<bool> clearUser() async {

    final pref = await SharedPreferences.getInstance();

    // menghapus session dengan kata kunci user
    bool success = await pref.remove('user');

    final cUser = Get.put(CUser());
    cUser.setData(User());

    return success;
  }
}
