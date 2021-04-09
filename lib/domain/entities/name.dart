import 'package:equatable/equatable.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';

class Name extends Equatable {
  Name({
    this.language,
    this.name,
  });

  final ResourcePath language;
  final String name;

  @override
  List<Object> get props => [language, name];
}
