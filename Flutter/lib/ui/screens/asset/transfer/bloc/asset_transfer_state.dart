import 'package:algorand_dart/algorand_dart.dart';
import 'package:equatable/equatable.dart';
import 'package:algo_learn/models/models.dart';

abstract class AssetTransferState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssetTransferInitial extends AssetTransferState {}

class AssetTransferFailure extends AssetTransferState {
  final AlgorandException exception;

  AssetTransferFailure(this.exception);

  @override
  List<Object?> get props => [exception];
}

class AssetTransferSuccess extends AssetTransferState {
  final AlgorandStandardAsset asset;

  AssetTransferSuccess({required this.asset});

  @override
  List<Object?> get props => [asset];
}

class AssetTransferInProgress extends AssetTransferState {
  AssetTransferInProgress();

  @override
  List<Object?> get props => [];
}

class AssetTransferSentSuccess extends AssetTransferState {
  final String transactionId;

  AssetTransferSentSuccess(this.transactionId);

  @override
  List<Object?> get props => [transactionId];
}
