import 'package:dio/dio.dart';
import 'package:ososs/models/pokemon.dart';
import '../constants/configuration.dart';

class PokemonService {
  Dio dio = Dio();

  Future<Pokemon?> getPokemonById(String id) async {
    try {
      Response response = await dio.get('$baseUrl/api/v2/pokemon/${id}');

      print(response);
      if (response != null) {
        if (response.data != null) {
          var pokemon = Pokemon.fromJson(response.data);
          return pokemon;
        }
        return null;
      }
      return null;
    } catch (e) {
      print("RESPONSE:${e.toString()}");
      return null;
    }
  }

  Future<List<Pokemon>> getPokemons() async {
    try {
      var pokemons = <Pokemon>[];
      for (int i = 1; i < 60; i++) {
        var pokemon = await getPokemonById(i.toString());
        if (pokemon != null) {
          pokemons.add(pokemon);
        }
      }
      return pokemons;
    } catch (e) {
      print("RESPONSE:${e.toString()}");
      return [];
    }
  }
}
