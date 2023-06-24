import 'package:flutter/material.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pokemons'),
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
