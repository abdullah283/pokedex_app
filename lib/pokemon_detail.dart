import 'package:bolum_26_pokedex_uygulamasi/model/pokedex_json_http.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  PokemonDetail({Key? key, required this.pokemon}) : super(key: key);
  late final Pokemon pokemon;

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Color? baskinRenk;
  late PaletteGenerator paletteGenerator;

  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
        PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img!));
    fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor!.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.vibrantColor!.color;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    baskinRengiBul();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: baskinRenk,
        title: Text(widget.pokemon.name!),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return verticalPosition(context);
        } else {
          return horizontalPosition(context);
        }
      }),
    );
  }

  Stack verticalPosition(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            height: MediaQuery.of(context).size.height * (7 / 10),
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: MediaQuery.of(context).size.height * (0.1),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  Text(
                    widget.pokemon.name!,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Heigth :' + widget.pokemon.height!),
                  Text('Weigth :' + widget.pokemon.weight!),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Type',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type!.map((e) {
                      return Chip(
                          backgroundColor: Colors.orangeAccent.shade200,
                          label: Text(e!));
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('PrevEvolution',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution!.map((e) {
                            return Chip(
                                backgroundColor: Colors.orangeAccent.shade200,
                                label: Text(e!.name!));
                          }).toList()
                        : [const Text('Son hali')],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('NextEvolution',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution!.map((e) {
                            return Chip(
                                backgroundColor: Colors.orangeAccent.shade200,
                                label: Text(e!.name!));
                          }).toList()
                        : [const Text('Son hali')],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Weaknesses',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses!.map((e) {
                      return Chip(
                          backgroundColor: Colors.orangeAccent.shade200,
                          label: Text(e!));
                    }).toList(),
                  )
                ],
              ),
            )),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
              tag: widget.pokemon.img!,
              child: SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  widget.pokemon.img!,
                  fit: BoxFit.cover,
                ),
              )),
        )
      ],
    );
  }

  Stack horizontalPosition(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            height: MediaQuery.of(context).size.height * (7 / 10),
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: MediaQuery.of(context).size.height * (0.05),
            child: Card(
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 100, top: 10, bottom: 10, right: 10),
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.pokemon.name!,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Heigth :' + widget.pokemon.height!),
                              Text('Weigth :' + widget.pokemon.weight!),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Type',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: widget.pokemon.type!.map((e) {
                                  return Chip(
                                      backgroundColor:
                                          Colors.orangeAccent.shade200,
                                      label: Text(e!));
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('PrevEvolution',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: widget.pokemon.prevEvolution != null
                                    ? widget.pokemon.prevEvolution!.map((e) {
                                        return Chip(
                                            backgroundColor:
                                                Colors.orangeAccent.shade200,
                                            label: Text(e!.name!));
                                      }).toList()
                                    : [const Text('Son hali')],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('NextEvolution',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: widget.pokemon.nextEvolution != null
                                    ? widget.pokemon.nextEvolution!.map((e) {
                                        return Chip(
                                            backgroundColor:
                                                Colors.orangeAccent.shade200,
                                            label: Text(e!.name!));
                                      }).toList()
                                    : [const Text('Son hali')],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Weaknesses',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: widget.pokemon.weaknesses!.map((e) {
                                  return Chip(
                                      backgroundColor:
                                          Colors.orangeAccent.shade200,
                                      label: Text(e!));
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Hero(
              tag: widget.pokemon.img!,
              child: SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  widget.pokemon.img!,
                  fit: BoxFit.cover,
                ),
              )),
        )
      ],
    );
  }
}
