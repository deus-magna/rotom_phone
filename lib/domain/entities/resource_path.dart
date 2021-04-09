import 'package:equatable/equatable.dart';

class ResourcePath extends Equatable {
  ResourcePath({
    this.name,
    this.url,
  });

  final String name;
  final String url;

  @override
  List<Object> get props => [name, url];
}
