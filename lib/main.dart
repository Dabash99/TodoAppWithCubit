import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/shared/components/bloc_observer.dart';

import 'layout/home_layout.dart';

void main()
{
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
