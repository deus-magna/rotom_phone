import 'package:rotom_phone/data/model/resource_path_model.dart';
import 'package:rotom_phone/domain/entities/name.dart';

class NameModel extends Name {
  NameModel({
    this.language,
    this.name,
  }) : super(language: language, name: name);

  final ResourcePathModel language;
  final String name;

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        language: json["language"] == null
            ? null
            : ResourcePathModel.fromJson(json["language"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "language": language == null ? null : language.toJson(),
        "name": name == null ? null : name,
      };
}
