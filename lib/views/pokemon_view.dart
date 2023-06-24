import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ososs/models/pokemon.dart';
import 'package:ososs/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

import '../providers/base_provider.dart';
import '../styles/app_styles.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({Key? key}) : super(key: key);

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  List<Pokemon> dummyList = [];
  ScrollController _scrollController = ScrollController();

  int _currentMax = 0;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getMoreItems();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('pokemons'),
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
          color: Colors.grey.shade100,
          opacity: 0.1,
          isLoading: context.watch<PokemonProvider>().Pokemons.length > 25
              ? false
              : true,
          child: Container(
            //color: Colors.amber,
            child: Container(
              //color: Colors.green,
              height: (size.height) / 1.4,
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                shrinkWrap: true,
                itemExtent: 50,
                itemCount: dummyList.length ==
                        context.watch<PokemonProvider>().Pokemons.length
                    ? dummyList.length
                    : dummyList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == dummyList.length) {
                    return CupertinoActivityIndicator();
                  }
                  return InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 90,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 5, top: 5, bottom: 5),
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 100,
                              child: dummyList[index].sprites!.frontDefault ==
                                          '' ||
                                      dummyList[index]
                                          .sprites!
                                          .frontDefault!
                                          .isEmpty
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xffE6E6E6),
                                        radius: 30,
                                        child: Icon(
                                          Icons.person,
                                          color: Color(0xffCCCCCC),
                                        ),
                                      ),
                                    )
                                  : Image.network(
                                      dummyList[index].sprites!.frontDefault!,
                                      height: 90,
                                    ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Container(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                        dummyList[index].name!,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: AppStyles.blackSmallBoldTextStyle
                                            .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getMoreItems() {
    print("BEGIN GET MORE ITEMS");
    setState(() {
      print("Get Mote Items");
      for (int i = _currentMax; i < _currentMax + 10; i++) {
        if (i < context.read<PokemonProvider>().Pokemons.length) {
          dummyList.add(context.read<PokemonProvider>().Pokemons[i]);
        }
      }
      _currentMax = _currentMax + 10;
    });
    print("END GET MORE ITEMS");
  }

  void _scrollListener() {
    if (_scrollController.position.pixels.toInt() ==
        _scrollController.position.maxScrollExtent.toInt()) {
      print("CALL Scroll Listener");
      print(_scrollController.position.pixels.toInt());
      _getMoreItems();
    } else {
      print("NOT CALLING SCROLL LISTENER");
      //print("HERE NOT call Scroll listener");
    }
    print("END SCROLL CONTROLLER");
  }
}
