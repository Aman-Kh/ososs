import 'package:ososs/models/pokemon.dart';
import 'package:ososs/services/pokemon_service.dart';

import 'base_provider.dart';

class PokemonProvider extends BaseProvider {
  List<Pokemon> _pokemons = <Pokemon>[];
  List<Pokemon> get Pokemons => _pokemons;

  PokemonService pokemonService = PokemonService();

  Future<List<Pokemon>> getAllPokemons() async {
    try {
      print("BEGIN : GET All Pokemons Provider");
      //var _pokemons = <Pokemon>[];
      for (int i = 1; i < 60; i++) {
        var pokemon = await pokemonService.getPokemonById(i.toString());
        if (_pokemons != null && pokemon != null) {
          _pokemons.add(pokemon!);
          print("ADD ONE POKEMON : POKEMON NAME:  " + pokemon.name.toString());
          notifyListeners();
          print("POkemons Length  " + Pokemons.length.toString());
        }
      }
    } catch (e) {
      print("Exception : GET All Pokemons" + e.toString());
      _pokemons = [];
    }
    notifyListeners();
    return _pokemons;
  }
}
