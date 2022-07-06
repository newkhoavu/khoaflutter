import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_screen.dart';
import 'model/movie_localdb.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieLocalDBAdapter());
  await Hive.deleteBoxFromDisk("Favorites");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const appTitle='IMIC Movie DB App';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(title: appTitle,),
    );
  }
}

