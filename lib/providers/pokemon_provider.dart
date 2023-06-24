import 'package:ososs/models/pokemon.dart';
import 'package:ososs/services/pokemon_service.dart';

import 'base_provider.dart';

class PokemonProvider extends BaseProvider {
  List<Pokemon> _pokemons = <Pokemon>[];
  List<Pokemon> get Pokemons => _pokemons;

  PokemonService pokemonService = PokemonService();

  Future getAllPokemons() async {
    try {
      print("BEGIN : GET All Pokemons Provider");
      _pokemons = await pokemonService.getPokemons();
    } catch (e) {
      print("Exception : GET All Pokemons" + e.toString());
      _pokemons = [];
    }
    notifyListeners();
  }
}
