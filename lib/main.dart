import 'package:app_develop/provider/screen_provider.dart';
import 'package:app_develop/src/page/geo_page.dart';
import 'package:app_develop/src/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<ScreenCurrent>(create: (context) => ScreenCurrent())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          "home": (BuildContext context) => HomePage(),
          "map": (_) => MapaPage(),
        },
      ),
    );
  }
}