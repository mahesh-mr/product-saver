import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_task/model/category_model.dart';
import 'package:hive_task/view/home_view.dart';
import 'package:hive_task/view/style.dart/style.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(CategoryModelAdapter());

  Hive.registerAdapter(ProductModelAdapter());

  await Hive.openBox<CategoryModel>(boxname);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: bg,
      ),
      home: const HomeScreen(),
    );
  }
}
