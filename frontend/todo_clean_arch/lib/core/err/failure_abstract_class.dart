import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure(String string, {required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
