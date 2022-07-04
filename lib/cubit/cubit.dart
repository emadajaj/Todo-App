import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoo/cubit/status_cubit.dart';
class AppCubit extends Cubit<CubitState>{
  AppCubit() : super(InitialState());
  int currentIndex = 0;
  static AppCubit get(context) => BlocProvider.of(context);

  void changeBottomButton(index){
    currentIndex = index;
    emit(BottonNavgitorChangeState());
  }
}