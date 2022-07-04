import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoo/todoApp/Screens/home_page.dart';
import 'bloc_observer/bloc_observer.dart';
import 'newsApp/home_page.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'x',
      home:HomePagee(),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
