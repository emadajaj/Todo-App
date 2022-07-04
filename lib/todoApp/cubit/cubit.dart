import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoo/todoApp/Screens/archived_task.dart';
import 'package:todoo/todoApp/Screens/done_task.dart';
import 'package:todoo/todoApp/Screens/new_task.dart';

import 'cubit_state.dart';
class CubitBee extends Cubit<CubitStates>{
  CubitBee() : super(InitialState());

  static CubitBee get(context) => BlocProvider.of(context);

  List<Widget> screens = [NewTask(), DoneTask(), ArchivedTask()];
  int currentIndex = 0;
  late Database db;
  List<Map> NewTasks=[];
  List<Map> DoneTasks=[];
  List<Map> ArchivedTasks=[];
  bool isShowingBottomSheet = false;
  IconData icona = Icons.edit;
  void ChangeNavButton(int index){
    currentIndex = index;
    emit(ChangeNavButtonState());
  }

  createDB() {
    openDatabase('test.db', version: 1, onCreate: (db, version) async {
      print('created DataBase');
       await db.execute(
          'CREATE TABLE todo(id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT ,status TEXT)')
          .then((value) {
        print('created Table');
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (db) {
      getDB(db);
    }).then((value) {
      db = value;
      emit(CreateState());
    });
    print('DataBase Opened');
  }
  void getDB(db) {
    DoneTasks=[];
    NewTasks = [];
    ArchivedTasks= [];
    emit(LoadingScreenState());
    db.rawQuery('SELECT * FROM todo').then((value) {
      print('iam in create');
      value.forEach((element) {
        if(element['status'] == 'new'){
          NewTasks.add(element);
        }
        else if(element['status'] == 'done'){
          DoneTasks.add(element);
        }
        else{ ArchivedTasks.add(element);}
      });
      emit(HatState());
    });

  }

  void updateDataBase({
    required String status,
    required int id,

}) {
    db.rawUpdate(
        'UPDATE todo SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDB(db);
      emit(UpdateDataBaseState());
    });
  }
    void deleteDataBase({
      required int id,

    }) {
      db.rawDelete('DELETE FROM todo WHERE id = ?', [id]).then((value) {
        getDB(db);
        emit(DeleteDataBaseState());
      });
  }

  insertDB(
      @required String title,
      @required String time,
      @required String date) async{
    await db.transaction((txn) {
       return txn
          .rawInsert(
          'INSERT INTO todo(title , time ,date , status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('$value Inserted DataBase');
        emit(InsertState());
        getDB(db);
      });
    });
  }
  void changeBottomSheetState(
      @required bool isShow,
      @required IconData icon
      )
  {
    isShowingBottomSheet = isShow;
    icona = icon;
    emit(ChangeBottomSheetState());
  }

}