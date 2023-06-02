import 'package:book_store/admin/admin_upload_items.dart';
import 'package:book_store/user/fragements/dashboard_of_fragements.dart';
import 'package:book_store/user/login_screen.dart';
import 'package:book_store/user/sign_up.dart';
import 'package:book_store/user/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // using get dependency so that state can be easily managed
    return GetMaterialApp(
      title: 'book store app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: RememberUserPrefs.readUserInfo(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.data == null) {
            return AdminUploadItemsScreen();
          } else {
            return DashboardOfFragements();
          }
        },
      ),
    );
  }
}
