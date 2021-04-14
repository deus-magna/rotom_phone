import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_types_row.dart';
import '../../../../../core/extensions/string_extension.dart';

class PokemonHeaderInfo extends StatelessWidget {
  const PokemonHeaderInfo({
    Key key,
    @required this.name,
    @required this.id,
    @required this.genus,
    @required this.types,
  }) : super(key: key);

  final String name;
  final String id;
  final String genus;
  final List<ResourcePath> types;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(right: 40),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: TextStyle(color: Colors.white)),
              Text(
                genus,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Text(
          name.capitalize(),
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        PokemonTypesRow(types: types),
      ],
    );
  }
}
