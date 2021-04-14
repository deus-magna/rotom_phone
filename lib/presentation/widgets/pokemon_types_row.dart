import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_type_button.dart';

class PokemonTypesRow extends StatelessWidget {
  final List<ResourcePath> types;
  final MainAxisAlignment mainAxisAlignment;
  final ButtonForm buttonsForm;

  const PokemonTypesRow({
    Key key,
    @required this.types,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.buttonsForm = ButtonForm.Circular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonTypes = types
        .map((type) => PokemonTypeButton(
              type: type,
              onPressed: () => print(type.url),
              form: buttonsForm,
            ))
        .toList();

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: pokemonTypes,
    );
  }
}
