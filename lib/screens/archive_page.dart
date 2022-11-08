import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';

import '../componantes/build_items.dart';


class ArchivePage extends StatelessWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return
      BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var tasks =  AppCubit.get(context).archivedTasks;
          return

          ConditionalBuilder(condition:tasks.length>0 , builder:(context)=> ListView.separated(
              itemBuilder: (context, index) {
                return BuildItems(model: cubit.archivedTasks[index],);
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemCount: cubit.archivedTasks.length) , fallback: (context) => Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(
                "lib/asset/noTasks.png",
                fit: BoxFit.fill,
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 1.7,
                  child: const Text(
                    "No Archived Tasks Yet ",
                    style: TextStyle(
                      fontFamily: "YanoneKaffeesatz",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.pinkAccent,
                    ),
                    textAlign: TextAlign.center,
                  ))
            ],
          ));
          },

      );
  }
}