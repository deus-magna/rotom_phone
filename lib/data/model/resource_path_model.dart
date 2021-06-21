import 'package:rotom_phone/domain/entities/resource_path.dart';

class ResourcePathModel extends ResourcePath {
  ResourcePathModel({
    this.name,
    this.url,
  }) : super(
          name: name,
          url: url,
        );

  final String name;
  final String url;

  factory ResourcePathModel.fromJson(Map<String, dynamic> json) =>
      ResourcePathModel(
        name: json['name'] == null ? null : json['name'],
        url: json['url'] == null ? null : json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name == null ? null : name,
        'url': url == null ? null : url,
      };
}
