import 'package:flutter/material.dart';
import 'package:todo/cubit/cubit.dart';

class BuildItems extends StatelessWidget {
  BuildItems({
    required this.model,
    Key? key,
  }) : super(key: key);
  Map model;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    bool isDone = false;
    return Dismissible(
      movementDuration: Duration(microseconds: 1),
      resizeDuration: Duration(microseconds: 1 ),
      background: Container(
        width: double.infinity,
        color: Colors.red[900],
        child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Delete",style: TextStyle(color: Colors.white,fontSize: 39,fontWeight: FontWeight.bold,fontFamily: 'Pacifico')),Text("Delete",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: 'Pacifico'),)],)
      ),
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        cubit.delete(id: model["id"]);
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.pink,
              child: Text(
                '${model["time"]}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black54,
                    fontFamily: "Pacifico"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model["title"]}',
                    style:
                        const TextStyle(fontSize: 30,fontWeight: FontWeight.bold, fontFamily: "YanoneKaffeesatz"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${model['date']}",
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                isDone = !isDone;
                cubit.update(
                  status: "done",
                  id: model['id'],
                );
              },
              icon: model['status'] == "done"
                  ? const Icon(
                      Icons.check_box_rounded,
                      color: Colors.cyan,
                    )
                  : const Icon(Icons.check_box_outline_blank_rounded),
            ),
            IconButton(
                onPressed: () {
                  cubit.update(
                    status: "archived",
                    id: model['id'],
                  );
                },
                icon: const Icon(
                  Icons.archive_rounded,
                  color: Colors.pinkAccent,
                )),
          ],
        ),
      ),
    );
  }
}
