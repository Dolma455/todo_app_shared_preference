import 'package:flutter/material.dart';
import 'package:todo_app_using_sharedpref/app/app.dart';

import 'package:provider/provider.dart';
import 'package:todo_app_using_sharedpref/todo_app/screen/fruit_list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FruitsProvider(),
      child: const MyApp(),
    ),
  );
}
