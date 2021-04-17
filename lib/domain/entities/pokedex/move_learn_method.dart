import 'package:equatable/equatable.dart';
import 'package:rotom_phone/core/utils/enums.dart';

class MoveLearnMethod extends Equatable {
  MoveLearnMethod({
    this.name,
    this.url,
  });

  final MoveLearnMethodType name;
  final String url;

  @override
  List<Object> get props => [name, url];
}
