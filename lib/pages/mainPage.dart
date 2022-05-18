import 'package:flutter/material.dart';
import 'package:ovip2/pages/311groupPage.dart';
import 'package:ovip2/pages/312groupPage.dart';
//->taskkill /F /IM "qemu-system-x86_64.exe" /T
class MainPage extends StatelessWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OVIP2.1'),),        
        body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            ElevatedButton(
                child: const Text('ПРИ-311'),
                onPressed : () {
                  Navigator.push(context,
                      MaterialPageRoute (builder: (context) {return  PRI311Page(); })
                      );}),          
            ElevatedButton(
                child: const Text('ПРИ-312'),
                onPressed : () {
                  Navigator.push(context,
                      MaterialPageRoute (builder: (context) {return  PRI311Page(); })
                      );}),
              ],
        )
      ), 
   );
  }
}
