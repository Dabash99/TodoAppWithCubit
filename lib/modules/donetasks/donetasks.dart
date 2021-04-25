import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/shared/components/components.dart';
import 'package:todo_list/shared/components/cubit/app_cubit.dart';

class Donetaskscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          var tasks=AppCubit.get(context).doneTasks;
          return tasksBuilder(tasks: tasks);
        });
  }
}
