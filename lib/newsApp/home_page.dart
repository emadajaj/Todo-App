import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoo/cubit/cubit.dart';
import 'package:todoo/cubit/status_cubit.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit , CubitState>(
        listener: (context , state){},
        builder: (context , state){
          return
            Scaffold(
              appBar: AppBar(
                title: Text('News'
                  ,style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                backgroundColor: Colors.black87,
              ),
              body:
              Container(
                color:  Colors.grey[800],
                child: Center(
                  child: Text('hI'
                    ,style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (index){
                  AppCubit.get(context).changeBottomButton(index);
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.sports ,) , label: 'Sports'),
                  BottomNavigationBarItem(icon: Icon(Icons.science ,) , label: 'science'),
                  BottomNavigationBarItem(icon: Icon(Icons.business ,) , label: 'business'),
                ],
              ),
            );},
      ),
    );
  }
}
