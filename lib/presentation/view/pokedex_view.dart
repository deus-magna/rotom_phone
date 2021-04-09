import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotom_phone/core/framework/colors.dart';
import 'package:rotom_phone/data/model/pokedex/local_pokedex_entry_model.dart';
import 'package:rotom_phone/presentation/cubit/pokedex/pokedex_cubit.dart';
import 'package:rotom_phone/presentation/widgets/pokedex_list.dart';
import '../../injector/injection_container.dart';

class PokedexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<PokedexCubit>(),
        child: BlocBuilder<PokedexCubit, PokedexState>(
          builder: (context, state) {
            if (state is PokedexInitial) {
              return Container(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final pokedexCubit = context.read<PokedexCubit>();
                      pokedexCubit.getRegionalPokedex(1);
                    },
                    child: Text('Init Pokedex'),
                  ),
                ),
              );
            } else if (state is PokedexLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is PokedexLoaded) {
              final pokedexEntries = state.pokedexEntries;
              return _buildPokedexBody(context, pokedexEntries);
            } else {
              return Container(
                child: Center(
                  child: Text('Error'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPokedexBody(
      BuildContext context, List<LocalPokedexEntryModel> pokedexEntries) {
    return Column(
      children: [
        _pokemonHeader(context),
        Expanded(
          child: PokedexList(
            pokedexEntries: pokedexEntries,
            nextPage: (offset) {
              print('Nada que hacer aca');
            },
          ),
        ),
      ],
    );
  }

  _pokemonHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: Colors.transparent,
          width: double.infinity,
          height: size.height * 0.3,
          child: CustomPaint(
            painter: PokedexHeaderPainter(),
          ),
        ),
        Positioned(
          top: size.height * 0.04,
          right: 0,
          child: Image.asset(
            'assets/images/rotom_phone_icon.png',
            height: 232,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.transparent,
          width: double.infinity,
          height: size.height * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pokédex',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  hintText: 'Search any Pokemon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PokedexHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = secondary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, -size.height * 2), size.height * 3, paint1);
    paint1 = Paint()..color = primary;
    canvas.drawCircle(
        Offset(size.width / 2, -(size.height * 2) - (size.height * 0.14)),
        size.height * 3,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
