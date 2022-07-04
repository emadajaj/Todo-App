import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
//import 'package:todo/cubit/cubit.dart';
import 'package:todoo/todoApp/cubit/cubit.dart';
import 'package:todoo/todoApp/cubit/cubit_state.dart';

class HomePagee extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext? context) => CubitBee()..createDB(),
      child: BlocConsumer<CubitBee,CubitStates>(
        listener: (context, state) {
          if(state is InsertState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          CubitBee cubit = BlocProvider.of(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text('Todo'),
              backgroundColor: Colors.green,
              centerTitle: true,
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => state is! LoadingScreenState,
              widgetBuilder: (BuildContext context) =>
                  cubit.screens[cubit.currentIndex],
              fallbackBuilder: (BuildContext context) =>
                  Center(child: CircularProgressIndicator()),

            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.icona),
              onPressed: () {
                if (cubit.isShowingBottomSheet == true) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertDB(titleController.text, timeController.text,
                        dateeController.text);
                    cubit.changeBottomSheetState(false, Icons.edit);

                  }
                } else {
                  cubit.changeBottomSheetState(true, Icons.add);
                  titleController.clear();
                  timeController.clear();
                  dateeController.clear();
                  scaffoldKey.currentState!
                      .showBottomSheet((context) {
                        return Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextFormField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                      labelText: 'Title',
                                      prefixIcon: Icon(Icons.title),
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Title must be not empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: timeController,
                                    decoration: InputDecoration(
                                      labelText: 'Time',
                                      prefixIcon:
                                          Icon(Icons.watch_later_outlined),
                                      border: OutlineInputBorder(),
                                    ),
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context);
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Time must be not empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    controller: dateeController,
                                    decoration: InputDecoration(
                                      labelText: 'Date',
                                      prefixIcon:
                                          Icon(Icons.calendar_today_outlined),
                                      border: OutlineInputBorder(),
                                    ),
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2021-10-03'),
                                      ).then((value) {
                                        dateeController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Date must be not empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ));
                      })
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetState(false, Icons.edit);
                      });
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeNavButton(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_task), label: 'New Task'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done), label: 'Done Task'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived Task'),
              ],
            ),
          );
        },
      ),
    );
  }
}
