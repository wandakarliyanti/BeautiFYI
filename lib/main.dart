import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_mobile/pages/home_page.dart';
import 'package:uas_mobile/pages/login_page.dart';
import 'package:uas_mobile/pages/register_page.dart';
import 'package:uas_mobile/pages/search_page.dart';
import 'package:uas_mobile/pages/splash_page.dart';
import 'package:uas_mobile/viewmodels/makeup_list_viewmodel.dart';
import 'package:uas_mobile/viewmodels/user_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MakeupListViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashScreen(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
          '/search': (context) => SearchPage(),
        },
      ),
    );
  }
}
