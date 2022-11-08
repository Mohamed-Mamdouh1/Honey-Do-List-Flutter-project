import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../componantes/build_items.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
        return ConditionalBuilder(

             condition: tasks.length>0,
             builder: (context)=>ListView.separated(
                 itemBuilder: (context, index) {

                   return BuildItems(
                     model: cubit.newTasks[index],
                   );
                 },
                 separatorBuilder: (context, index) {
                   return Container(
                     height: 1,
                     color: Colors.grey,
                   );
                 },
                 itemCount: cubit.newTasks.length),
              fallback: (context)=> Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset(
                    "lib/asset/noTasks.png",
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height / 1.7,
                      child:const   Text(
                        "No New Tasks Yet ",
                        style: TextStyle(
                          fontFamily: "YanoneKaffeesatz",
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.pinkAccent,
                        ),
                        textAlign: TextAlign.center,
                      ))
                ],
           )

           );

      },
    );
  }
}
