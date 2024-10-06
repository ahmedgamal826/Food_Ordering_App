import 'package:equatable/equatable.dart';

abstract class BottomNavState extends Equatable {
  const BottomNavState();
}

class BottomNavInitial extends BottomNavState {
  final int selectedIndex;

  const BottomNavInitial({this.selectedIndex = 0});

  @override
  List<Object> get props => [selectedIndex];
}

class BottomNavUpdated extends BottomNavState {
  final int selectedIndex;

  const BottomNavUpdated(this.selectedIndex);

  @override
  List<Object> get props => [selectedIndex];
}
