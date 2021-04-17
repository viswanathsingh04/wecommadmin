import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wecommadmin/pages/home_page.dart';
import 'package:wecommadmin/pages/loginpage.dart';
import 'package:wecommadmin/services/shared_service.dart';

Widget _defaultHome = new LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = HomePage();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        primarySwatch: Colors.blue,
      ),
      home: _defaultHome,
    );
  }
}
