import 'package:flutter/material.dart';
import 'package:ovip2/pages/mainPage.dart';

  // WidgetsFlutterBinding.ensureInitialized();
  // Directory document = await getApplicationDocumentsDirectory();
  //Hive.init(document.path);
  //Hive.openBox<String>("студосы");

void main()
{
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainPage(title: 'Главное меню'),
    );
  }
}




