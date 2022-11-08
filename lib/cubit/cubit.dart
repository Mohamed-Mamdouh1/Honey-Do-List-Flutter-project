import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart%20';
import 'package:todo/cubit/states.dart';

import '../screens/archive_page.dart';
import '../screens/done_page.dart';
import '../screens/tasks_page.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheet = false;
  Widget fabIcon = const Icon(Icons.edit);
  Widget checkIcon= const Icon(Icons.check_box_outline_blank_rounded,color: Colors.cyan,);
  bool isDone=false;
  List<Widget> screens = [
     const TasksPage(),
     const  DonePage(),
     const ArchivePage(),
  ];
  List<String> appBar = [
    'Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  void createDatabase() {
    openDatabase('Honey.db', version: 1, onCreate: (database, version) {
      print("Database Created");

      database
          .execute(
              "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, time TEXT,date TEXT,status TEXT)")
          .then((value) {
        print("Table Created");
      }).catchError((error) {
        print("Can not create table because ${error.toString()}");
      });
    }, onOpen: (database) {
      getFromDataBase(database);
      print('Database Opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDateBase({
    required String title,
    required String date,
    required String time
  }) async {
    return await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print("$value Insertion successful");
        emit(AppInsertToDatabaseState());
        getFromDataBase(database);
      });
    });
  }
  void getFromDataBase(database)  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
     database.rawQuery('SELECT * FROM tasks').then((value) {
       value.forEach((element){


         if (element['status']=="new"){
           newTasks.add(element);
         }else if (element["status"]=="done"){
           doneTasks.add(element);
         }else {archivedTasks.add(element);}
       });

       emit(AppGetDatabaseState());
     });
  }

  void update({required String status, required int id}) async {

     database!.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getFromDataBase(database);
      emit(AppUpdateDatabaseState());
     });
  }
  void delete({ required int id}) async {

    database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getFromDataBase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeBottomSheetState({required bool isShow, required Widget icon}) {
    isBottomSheet = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }



}
