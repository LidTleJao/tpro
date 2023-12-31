import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tpro/menu/login_page.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _currentIndex = 3;

  // final tabs = [Homepage(), AddImagePage(), AccountPage(), IoginPage()];

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: const LoginPage(),
    );
  }
}
