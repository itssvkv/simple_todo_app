import 'package:simple_todo_app/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class MainRepository {
  Future<Database> createDatabase() async {
    return await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        print('db created');
        db
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (db) {
        print('db opened');
      },
    );
  }

  Future<void> insertToDatabase(
      String title, String time, String date, Database database) async {
    database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO Tasks(title, time, date, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print('$value is add successfully');
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  Future<List<TaskModel>> getAllFromDatabase(Database database) async {
    List<Map> response = await database.rawQuery('SELECT * FROM Tasks');
    List<TaskModel> taskModelList = [];
    for (var map in response) {
      taskModelList.add(
        TaskModel(
          id: map['id'],
          title: map['title'],
          time: map['time'],
          date: map['date'],
          statues: map['status'],
        ),
      );
    }
    return taskModelList;
  }

  Future<int> updateDatabase(
      Database database, String newStatus, int id) async {
    return await database
        .rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?', [newStatus, id]);
  }

  Future<int> deleteFromDatabase(Database database, int id) async {
    return await database.rawDelete(
      'DELETE FROM Tasks WHERE id = ?',
      [id],
    );
  }
}
