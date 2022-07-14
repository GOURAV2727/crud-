import 'package:crud/providers/entry_providers.dart';
import 'package:crud/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>EntryProvider(),
      child: MaterialApp(
        home: Homescreen(),
      ),
    );
  }
}


