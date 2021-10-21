import 'package:rotom_phone/data/model/resource_path_model.dart';
import 'package:rotom_phone/domain/entities/name.dart';

class NameModel extends Name {
  NameModel({
    this.languageModel,
    name,
  }) : super(language: languageModel, name: name);

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        languageModel: json['language'] == null
            ? null
            : ResourcePathModel.fromJson(json['language']),
        name: json['name'],
      );

  final ResourcePathModel languageModel;

  Map<String, dynamic> toJson() => {
        'language': languageModel == null ? null : languageModel.toJson(),
        'name': name,
      };
}
