import 'package:todoo/cubit/cubit.dart';
import 'package:todoo/todoApp/cubit/cubit.dart';

import 'componentes.dart';
import 'package:flutter/material.dart';
bool isMorning = true;
  // ignore: non_constant_identifier_names
  Widget BuildList(Map x,context) {
    return Dismissible(
      key: Key('x'),
      child: Container(
        padding: EdgeInsetsDirectional.all(20),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              child: Text('${x['time']}'),
            ),
            SizedBox(width:10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${x['title']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                  Text('${x['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),)
                ],
              ),
            ),
            IconButton(
              icon : Icon(Icons.done , color: Colors.greenAccent,),
              onPressed: (){
                CubitBee.get(context).updateDataBase(status: 'done', id: x['id']);
              },
            ),
            IconButton(
              icon : Icon(Icons.archive_outlined , color: Colors.grey,),
              onPressed: (){
                CubitBee.get(context).updateDataBase(status: 'archived', id: x['id']);
              },
            ),
          ],
        ),
      ),
      onDismissed: (direction){
        CubitBee.get(context).deleteDataBase(id: x['id']);
      },
    );
    
  }

