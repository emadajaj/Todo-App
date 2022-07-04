import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoo/cubit/cubit.dart';
import 'package:todoo/todoApp/componentes/buld_list.dart';
import 'package:todoo/todoApp/cubit/cubit.dart';
import 'package:todoo/todoApp/cubit/cubit_state.dart';

class DoneTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CubitBee,CubitStates>(
        listener: (context , state){} ,
        builder: (context , state) { return ListView.separated(itemBuilder: (context,index) {
          return BuildList(CubitBee.get(context).DoneTasks[index],context);
        }, separatorBuilder: (context,index){
          return Container(
            padding: EdgeInsetsDirectional.all(20),
            width: double.infinity,
            height: 1,
            color: Colors.grey[200],
          );
        }, itemCount: CubitBee.get(context).DoneTasks.length);}
    );
  }
}
