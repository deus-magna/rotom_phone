import 'package:flutter/material.dart';
import 'package:rotom_phone/domain/entities/resource_path.dart';
import 'package:rotom_phone/presentation/widgets/pokemon_type_button.dart';

class PokemonTypesRow extends StatelessWidget {

  const PokemonTypesRow({
    Key key,
    @required this.types,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.buttonsForm = ButtonForm.circular,
  }) : super(key: key);
  
  final List<ResourcePath> types;
  final MainAxisAlignment mainAxisAlignment;
  final ButtonForm buttonsForm;

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
