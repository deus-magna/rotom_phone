import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}

// Failures generales de la app
class ServerFailure extends Failure {}
