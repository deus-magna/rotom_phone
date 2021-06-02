import 'package:rotom_phone/core/utils/enums.dart';
import 'package:rotom_phone/core/utils/pokemon_utils.dart';
import 'package:rotom_phone/domain/entities/pokedex/move_learn_method.dart';

class MoveLearnMethodModel extends MoveLearnMethod {
  MoveLearnMethodModel({
    this.name,
    this.url,
  }) : super(name: name, url: url);

  final MoveLearnMethodType name;
  final String url;

  factory MoveLearnMethodModel.fromJson(Map<String, dynamic> json) {
    final String name = json['name'] == null ? '' : json['name'];

    return MoveLearnMethodModel(
      name: learnMethodType(name),
      url: json['url'] == null ? null : json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name == null ? null : name.toString(),
        'url': url == null ? null : url,
      };
}
