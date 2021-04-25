import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo_list/shared/components/components.dart';
import 'package:todo_list/shared/components/cubit/app_cubit.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: cutomAppBar(
              title: cubit.titles[cubit.currentIndex],
              color: cubit.colors[cubit.currentIndex]
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formkey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    titleController=null;
                    timeController=null;
                    dateController=null;
                  }
                } else {
                  scaffoldkey.currentState
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(20),
                                child: Form(
                                  key: formkey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultFormField(
                                          controller: titleController,
                                          type: TextInputType.text,
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'title must not be empty';
                                            }
                                            return null;
                                          },
                                          label: 'Task Title',
                                          prefix: Icons.title),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      defaultFormField(
                                          controller: timeController,
                                          type: TextInputType.datetime,
                                          ontap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              timeController.text = value
                                                  .format(context)
                                                  .toString();
                                              print(value.format(context));
                                            });
                                          },
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'time must not be empty';
                                            }
                                            return null;
                                          },
                                          label: 'Task Time',
                                          prefix: Icons.watch_later_outlined),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      defaultFormField(
                                          controller: dateController,
                                          type: TextInputType.datetime,
                                          ontap: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.parse(
                                                        '2021-12-31'))
                                                .then((value) {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value);
                                              print(DateFormat.yMMMd()
                                                  .format(value));
                                            });
                                          },
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'Date must not be empty';
                                            }
                                            return null;
                                          },
                                          label: 'Task Date',
                                          prefix: Icons.calendar_today)
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 15)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        icon: Icons.edit, isShow: false);
                  });
                  cubit.changeBottomSheetState(icon: Icons.add, isShow: true);
                }
              },
              label: Text('Add New Task'),
              icon: Icon(cubit.fabIcon),
              elevation: 2,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
                BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
              ],
            ),
          );
        },
      ),
    );
  }
}
