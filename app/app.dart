import 'package:flutter/material.dart';
import 'package:todo_app_using_sharedpref/todo_app/screen/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: const FruitsPage(),
    );
  }
}
