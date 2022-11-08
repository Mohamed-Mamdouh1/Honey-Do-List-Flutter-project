import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/componantes/text_form_field.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/screens/aboutUs_page.dart';
import 'package:todo/screens/help_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/states.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.toggleTheme, required this.currentTheme})
      : super(key: key);
  Function toggleTheme;
  ThemeMode currentTheme;
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();

  void makeCall() async {
    var url = Uri.parse("tel:01155812725");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {
        if (state is AppInsertToDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
              backgroundColor: Colors.pinkAccent,
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(clipBehavior: Clip.hardEdge, children: [
                    Image.asset(
                      'lib/asset/drawerChecklist.png',

                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height / 1.6,
                        left: MediaQuery.of(context).size.width / 6,
                        child: const Text(
                          "HONEY-DO LIST",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ))
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(primary: Colors.pink),
                      onPressed: makeCall,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Contact us ',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Pacifico",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.contact_phone,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                  TextButton(
                      style: TextButton.styleFrom(primary: Colors.pink),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const AboutUs();
                        }));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'About us ',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Pacifico",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                  TextButton(
                      style: TextButton.styleFrom(primary: Colors.pink),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HelpPage();
                        }));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Help',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Pacifico",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 52),
                            child: Icon(
                              Icons.help_rounded,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                ],
              )),
          appBar: AppBar(
            backgroundColor: Colors.pink.shade300,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu_open_rounded,size: 30,),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            toolbarHeight: 100,
            elevation: 14,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70))),
            title: Text(
              cubit.appBar[cubit.currentIndex],
              style: TextStyle(
                  fontFamily: "YanoneKaffeesatz",
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            actions: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(boxShadow: const [
                      BoxShadow(
                          blurRadius: 7, spreadRadius: 3, color: Colors.pink)
                    ], shape: BoxShape.circle, color: Colors.pink.shade400),
                    child: IconButton(
                      onPressed: () {
                        toggleTheme();
                      },
                      icon: currentTheme == ThemeMode.light
                          ? const Icon(Icons.dark_mode_rounded)
                          : const Icon(Icons.light_mode),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(boxShadow: const [
                      BoxShadow(
                          blurRadius: 7, spreadRadius: 3, color: Colors.pink)
                    ], shape: BoxShape.circle, color: Colors.pink.shade400),
                    child: IconButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        icon: const Icon(
                          Icons.logout,
                        )),
                  ),
                  const SizedBox(
                    width: 26,
                  )
                ],
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xfff50d56),
            onPressed: () {
              if (cubit.isBottomSheet) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDateBase(
                    time: timeController.text,
                    title: titleController.text,
                    date: dateController.text,
                  );
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(elevation: 0, (context) {
                      return SingleChildScrollView(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                topLeft: Radius.circular(30)),
                            color: Color(0xff1d1e32),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Center(
                                    child: Container(
                                      height: 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      width: 50,
                                    ),
                                  ),
                                ),
                                CustomField(
                                  type: TextInputType.text,
                                  controller: titleController,
                                  prefix: Icons.title_rounded,
                                  hintText: const Text(
                                    "Task Title",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomField(
                                  type: TextInputType.datetime,
                                  controller: dateController,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2023-05-03"),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  prefix: Icons.date_range_rounded,
                                  hintText: const Text(
                                    "Task Date",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomField(
                                  type: TextInputType.datetime,
                                  controller: timeController,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  prefix: Icons.access_time_filled,
                                  hintText: const Text(
                                    "Task Time",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                    .closed
                    .then((value) {
                      cubit.changeBottomSheetState(
                        isShow: false,
                        icon: const Icon(Icons.edit),
                      );

                      // setState(() {
                      //   fabIcon = const Icon(Icons.edit);
                      // });
                    });
                cubit.changeBottomSheetState(
                  isShow: true,
                  icon: const Icon(
                    Icons.add_rounded,
                    size: 26,
                  ),
                );
              }
              titleController.clear();
              dateController.clear();
              timeController.clear();
            },
            child: cubit.fabIcon,
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(70),
              topRight: Radius.circular(70),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 120,
              child: BottomNavigationBar(
                backgroundColor: Colors.pink.shade300,
                elevation: 0,
                selectedIconTheme: const IconThemeData(
                    size: 60, color: Colors.cyanAccent, opacity: 1),
                unselectedIconTheme: const IconThemeData(size: 20, opacity: .1),
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.task_rounded,
                    ),
                    label: "TASKS",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.done_rounded),
                    label: "DONE",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.archive_rounded,
                      ),
                      label: "ARCHIVE")
                ],
              ),
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
