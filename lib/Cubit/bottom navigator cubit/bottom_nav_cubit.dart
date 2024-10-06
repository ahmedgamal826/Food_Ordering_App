import 'package:bloc/bloc.dart';
import 'package:food_ordering_app/Cubit/bottom%20navigator%20cubit/bottom_nav_states.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavInitial());

  void selectIndex(int index) {
    emit(BottomNavUpdated(index));
  }
}
