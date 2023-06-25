import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ososs/models/pokemon.dart';
import 'package:ososs/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

import '../providers/base_provider.dart';
import '../styles/app_colors.dart';
import '../styles/app_styles.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({Key? key}) : super(key: key);

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text('Pokemons'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (Provider.of<BaseProvider>(context, listen: false).isLoading ==
              true) {
            return false;
          } else {
            return true;
          }
        },
        child: LoadingOverlay(
          isLoading: context.watch<PokemonProvider>().Pokemons.length > 0
              ? false
              : true,
          color: AppColors.lightLightGreyColor,
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 5),
            height: (size.height) / 1.2,
            child: Selector<PokemonProvider, List<Pokemon>>(
              selector: (context, pokemonProvider) => pokemonProvider.Pokemons,
              builder: (_, pokemons, __) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemExtent: 130,
                  itemCount: pokemons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 10, right: 5),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        color: AppColors.lightLightGreyColor,
                        child: Container(
                          height: 130,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5, bottom: 5, right: 5),
                                child: Container(
                                  color: AppColors.lightLightGreyColor,
                                  width: 95,
                                  height: 130,
                                  child: pokemons[index]
                                                  .sprites!
                                                  .frontDefault ==
                                              '' ||
                                          pokemons[index]
                                              .sprites!
                                              .frontDefault!
                                              .isEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xffE6E6E6),
                                            radius: 30,
                                            child: Icon(
                                              Icons.person,
                                              color: Color(0xffCCCCCC),
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            pokemons[index]
                                                .sprites!
                                                .frontDefault!,
                                            height: 90,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Container(
                                  height: 130,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          pokemons[index].name!,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: AppStyles
                                              .blackSmallBoldTextStyle
                                              .copyWith(
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
