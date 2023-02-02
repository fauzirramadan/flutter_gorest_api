import 'package:flutter/material.dart';
import 'package:flutter_gorest_api/view/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey();
final GlobalKey<NavigatorState> navKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navKey,
      title: 'Flutter Gorest API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}
