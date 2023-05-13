import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widget/movieInfo_widget.dart';

class HomeView extends StatefulWidget {
  List<dynamic> genres = [];
  HomeView({super.key, required this.genres});

  @override
  State<HomeView> createState() => _HomeViewState(this.genres);
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> genres = [];

  _HomeViewState(genres);

  // @override
  // void initState() {
  //   super.initState();
  //   fetchGenres();
  // }

  // @override
  // void setState(fn) {
  //   if(mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(180, 0, 0, 1),
                secondary: Color.fromRGBO(180, 0, 0, 1))),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return buildRow(index);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 0);
            },
            itemCount: widget.genres.length));
  }

  Widget buildCard(int index, List<dynamic> movies) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            // onDoubleTap: () {
            //   setState(() {
            //     movies[index]['liked'] = !movies[index]['liked'];
            //   });
            // },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieInfoPage(
                          movie: movies[index],
                        )),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: movies.isNotEmpty
                    ? Stack(
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w500' +
                                movies[index]['poster_path'],
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: (MediaQuery.of(context).size.width *
                                        0.4 *
                                        3) /
                                    2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                color: const Color.fromRGBO(50, 50, 50, 1),
                              );
                            },
                            height:
                                (MediaQuery.of(context).size.width * 0.4 * 3) /
                                    2,
                            width: MediaQuery.of(context).size.width * 0.4,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              top: (MediaQuery.of(context).size.width *
                                      0.4 *
                                      3) /
                                  2.5,
                              left: MediaQuery.of(context).size.width * 0.27,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      movies[index]['liked'] =
                                          !movies[index]['liked'];
                                    });
                                  },
                                  icon: Icon(
                                    movies[index]['liked']
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: movies[index]['liked']
                                        ? const Color.fromRGBO(200, 0, 0, 1)
                                        : Colors.white,
                                    shadows: const <Shadow>[
                                      Shadow(
                                          color: Colors.black, blurRadius: 10.0)
                                    ],
                                  )))
                        ],
                      )
                    : null),
          )
        ],
      );

  Widget buildRow(int index1) => Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 10),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.genres.isNotEmpty ? widget.genres[index1]['name'] : '',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
              )),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: (MediaQuery.of(context).size.width * 0.4 * 3) / 2,
            child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                        primary: Color.fromRGBO(180, 0, 0, 1),
                        secondary: Color.fromRGBO(180, 0, 0, 1))),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  itemBuilder: (context, index) {
                    return index != widget.genres[index1]['movies'].length - 1
                        ? Row(
                            children: [
                              buildCard(index, widget.genres[index1]['movies']),
                              const SizedBox(width: 5)
                            ],
                          )
                        : Row(children: [
                            buildCard(index, widget.genres[index1]['movies'])
                          ]);
                  },
                  itemCount: widget.genres.isNotEmpty
                      ? widget.genres[index1]['movies'] != null
                          ? widget.genres[index1]['movies'].length
                          : 0
                      : 0,
                )))
      ]);
}
