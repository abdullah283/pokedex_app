import 'dart:convert';
import 'package:bolum_26_pokedex_uygulamasi/model/pokedex_json_http.dart';
import 'package:bolum_26_pokedex_uygulamasi/pokemon_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokedexHomePage extends StatefulWidget {
  const PokedexHomePage({Key? key}) : super(key: key);

  @override
  _PokedexHomePageState createState() => _PokedexHomePageState();
}

class _PokedexHomePageState extends State<PokedexHomePage> {
  late Future<Pokedex> veri;
  @override
  void initState() {
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Pokedex App"),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return dikeyPosition();
        } else {
          return yatayPosition();
        }
      }),
    );
  }

  FutureBuilder<Pokedex> yatayPosition() {
    return FutureBuilder<Pokedex>(
        future: veri,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Pokedex gelenPokedex = snapshot.data!;
            return /*GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Text(gelenPokedex.pokemon![index].name!);
                })*/
                GridView.count(
              crossAxisCount: 3,
              children: gelenPokedex.pokemon!
                  .map((poke) => InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return PokemonDetail(pokemon: poke);
                          }));
                        },
                        child: Hero(
                            tag: poke.img!,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    color: Colors.white,
                                    height: 180,
                                    width: double.infinity,
                                    child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/loading.gif',
                                        image: poke.img!),
                                  ),
                                ),
                                Text(
                                  poke.name!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return const Text("hata");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  FutureBuilder<Pokedex> dikeyPosition() {
    return FutureBuilder<Pokedex>(
        future: veri,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Pokedex gelenPokedex = snapshot.data!;
            return /*GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Text(gelenPokedex.pokemon![index].name!);
                })*/
                GridView.count(
              crossAxisCount: 2,
              children: gelenPokedex.pokemon!
                  .map((poke) => InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return PokemonDetail(pokemon: poke);
                          }));
                        },
                        child: Hero(
                            tag: poke.img!,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: (poke.id! % 2 == 1)
                                        ? const EdgeInsets.only(
                                            left: 8, top: 8, bottom: 8)
                                        : const EdgeInsets.all(8),
                                    color: Colors.white,
                                    height: 100,
                                    width: double.infinity,
                                    child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/loading.gif',
                                        image: poke.img!),
                                  ),
                                ),
                                Text(
                                  poke.name!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                      ))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return const Text("hata");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Uri url = Uri.parse(
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');

  Pokedex? pokemon;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = json.decode(response.body);
    pokemon = Pokedex.fromJson(decodedJson);
    return pokemon!;
  }
}
