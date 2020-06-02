import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './unlocker_bloc.dart';
import './ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<UnlockerBloc>(
        create: (context) => UnlockerBloc(),
        child: MyHomePage(
          title: 'Light unlocker',
        ),
      ),
    );
  }
}