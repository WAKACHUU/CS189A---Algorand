import 'package:equatable/equatable.dart';
import 'package:algo_learn/models/models.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardStarted extends DashboardEvent {
  final DateTime lastUpdated;

  DashboardStarted() : this.lastUpdated = DateTime.now();

  @override
  List<Object?> get props => [lastUpdated];
}

class DashboardAssetChanged extends DashboardEvent {
  final AlgorandStandardAsset asset;

  DashboardAssetChanged(this.asset);

  @override
  List<Object?> get props => [asset];
}

class DashboardCompoundStarted extends DashboardEvent {}
