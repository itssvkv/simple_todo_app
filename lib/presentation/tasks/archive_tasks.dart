import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/utils/componant/one_item.dart';
import 'package:simple_todo_app/utils/shared/cubit/cubit.dart';
import 'package:simple_todo_app/utils/shared/cubit/status.dart';

class ArchiveTasks extends StatelessWidget {
  const ArchiveTasks({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStatus>(
      builder: (context, state) {
        return oneItemBuilder(list: AppCubit.get(context).archiveTasks);
      },
    );
  }
}
