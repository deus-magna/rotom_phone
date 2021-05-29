import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Failure extends Equatable {
  Failure({
    @required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

// Failures generales de la app
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
