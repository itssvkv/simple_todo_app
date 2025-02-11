import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/utils/componant/bottom_sheet.dart';
import 'package:simple_todo_app/utils/shared/cubit/cubit.dart';
import 'package:simple_todo_app/utils/shared/cubit/status.dart';

class TodoHomeScreen extends StatelessWidget {
  TodoHomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocBuilder<AppCubit, AppCubitStatus>(
        builder: (context, state) {

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(AppCubit.get(context).bottomBarItems[AppCubit.get(context).currentIndex].title),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (AppCubit.get(context).isBottomSheetOpened) {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context).insertToDatabase(
                      titleController.text,
                      timeController.text,
                      dateController.text,
                    );
                    Navigator.pop(context);
                    AppCubit.get(context).onBottomSheetStateChanged(false, Icons.edit);
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) {
                          return Form(
                            key: formKey,
                            child: customBottomSheet(
                                controller: titleController,
                                validator: (String? value) {
                                  if (value != null && value.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Title must not be empty';
                                  }
                                },
                                controller1: timeController,
                                onTap1: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then(
                                    (value) {
                                      if (value != null) {
                                        timeController.text =
                                            value.format(context).toString();
                                      }
                                    },
                                  );
                                },
                                validator1: (String? value) {
                                  if (value != null && value.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Time must not be empty';
                                  }
                                },
                                controller2: dateController,
                                onTap2: () {
                                  showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2026-01-01'),
                                  ).then((value) {
                                    dateController.text = value.toString();
                                  });
                                },
                                validator2: (String? value) {
                                  if (value != null && value.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Title must not be empty';
                                  }
                                }),
                          );
                        },
                        elevation: 10,
                      )
                      .closed
                      .then((value) {
                        AppCubit.get(context).onBottomSheetStateChanged(false, Icons.edit);
                      });
                  AppCubit.get(context).onBottomSheetStateChanged(true, Icons.add);
                }
              },
              child: Icon(AppCubit.get(context).fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              items: AppCubit.get(context).getBottomNavBarItems(),
              onTap: (index) {
                AppCubit.get(context).onCurrentIndexChanged(index);
              },
            ),
            body: AppCubit.get(context).bodies[AppCubit.get(context).currentIndex],
          );
        },
      ),
    );
  }
}
