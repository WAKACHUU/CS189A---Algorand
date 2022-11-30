import 'package:equatable/equatable.dart';
import 'package:algo_learn/models/navigation/navigation_tab.dart';

abstract class NavigationEvent extends Equatable {}

class NavigationTabChanged extends NavigationEvent {
  final NavigationTab tab;

  NavigationTabChanged({required this.tab});

  @override
  List<Object?> get props => [tab];
}