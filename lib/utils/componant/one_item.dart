import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/model/task_model.dart';
import 'package:simple_todo_app/utils/shared/cubit/cubit.dart';
import 'package:simple_todo_app/utils/shared/cubit/status.dart';

Widget oneItemBuilder({required List<TaskModel> list}) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return oneItem(taskModel: list[index]);
    },
    itemCount: list.length,
  );
}

Widget oneItem({required TaskModel taskModel}) {
  return BlocBuilder<AppCubit, AppCubitStatus>(
    builder: (context, state) {
      return Dismissible(
        key: Key(taskModel.id.toString()),
        onDismissed: (dismissDirection) {
          AppCubit.get(context).deleteFromDatabase(taskModel.id);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(taskModel.time),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      taskModel.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(taskModel.date),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).updateDatabase('done', taskModel.id);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).updateDatabase('archive', taskModel.id);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
