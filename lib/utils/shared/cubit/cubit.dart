import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/model/bottom_bar_item.dart';
import 'package:simple_todo_app/model/task_model.dart';
import 'package:simple_todo_app/presentation/tasks/archive_tasks.dart';
import 'package:simple_todo_app/presentation/tasks/done_tasks.dart';
import 'package:simple_todo_app/presentation/tasks/new_tasks.dart';
import 'package:simple_todo_app/repository/main_repository.dart';
import 'package:simple_todo_app/utils/shared/cubit/status.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppCubitStatus> {
  AppCubit() : super(AppInitialStatus());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  List<BottomBarItem> bottomBarItems = [
    BottomBarItem(
      icon: Icons.menu,
      title: 'Tasks',
    ),
    BottomBarItem(
      icon: Icons.done_outlined,
      title: 'Done',
    ),
    BottomBarItem(
      icon: Icons.archive_outlined,
      title: 'Archive',
    ),
  ];

  List<Widget> bodies = [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];

  int currentIndex = 0;

  Database? database;
  List<TaskModel> newTasks = [];
  List<TaskModel> doneTasks = [];
  List<TaskModel> archiveTasks = [];
  bool isBottomSheetOpened = false;

  IconData fabIcon = Icons.edit;

  List<BottomNavigationBarItem> getBottomNavBarItems() {
    List<BottomNavigationBarItem> items = [];
    for (var item in bottomBarItems) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title,
        ),
      );
    }
    return items;
  }

  void onCurrentIndexChanged(int index) {
    currentIndex = index;
    emit(AppBottomBarIndexChanged());
  }

  void onBottomSheetStateChanged(bool isShow, IconData icon) {
    isBottomSheetOpened = isShow;
    fabIcon = icon;
    emit(AppBottomSheetStateChanged());
  }

  void createDatabase() {
    MainRepository().createDatabase().then((value) {
      database = value;
      emit(AppCreateDatabase());
      getAllFromDatabase(value);
    });
  }

  void getAllFromDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    MainRepository().getAllFromDatabase(database).then((value) {
      for (var item in value) {
        if (item.statues == 'new') {
          newTasks.add(item);
        } else if (item.statues == 'done') {
          doneTasks.add(item);
        } else {
          archiveTasks.add(item);
        }
      }
      emit(AppGetFromDatabase());
    });
  }

  void insertToDatabase(
    String title,
    String time,
    String date,
  ) {
    if (database != null) {
      MainRepository()
          .insertToDatabase(title, time, date, database!)
          .then((value) {
        emit(AppInsertTODatabase());
        getAllFromDatabase(database!);
      });
    }
  }

  void updateDatabase(String newStatus, int id) {
    if (database != null) {
      MainRepository().updateDatabase(database!, newStatus, id).then((value) {
        emit(AppUpdateDatabase());
        getAllFromDatabase(database!);
      });
    }
  }

  void deleteFromDatabase(int id) {
    if (database != null) {
      MainRepository().deleteFromDatabase(database!, id).then((value) {
        emit(AppDeleteDatabase());
        getAllFromDatabase(database!);
      });
    }
  }
}
