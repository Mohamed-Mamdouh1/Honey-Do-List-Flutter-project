import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/observer.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/screens/homepage.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(ToDoApp());
}

class ToDoApp extends StatefulWidget {
   ToDoApp({Key? key}) : super(key: key);



  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {


return BlocProvider(
        create: (context) { return AppCubit()..createDatabase();},
        child: MaterialApp(

         debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme:ThemeData(
            brightness: Brightness.dark,
          ),
          themeMode: currentTheme,
          home: HomePage(toggleTheme: toggleTheme,currentTheme: currentTheme,),
        ));
  }
  ThemeMode currentTheme = ThemeMode.light;
  void toggleTheme() {
    setState(() {
      currentTheme = currentTheme == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
      
    });
  }


}
