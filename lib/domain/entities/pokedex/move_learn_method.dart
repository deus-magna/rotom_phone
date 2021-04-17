import 'package:equatable/equatable.dart';

enum MoveLearnMethodType {
  LEVEL_UP,
  EGG,
  TUTOR,
  MACHINE,
  STADIUM_SURFING_PIKACHU,
  LIGHT_BALL_EGG,
  COLOSSEUM_PURIFICATION,
  XD_SHADOW,
  XD_PURIFICATION,
  FORM_CHANGE,
}

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
