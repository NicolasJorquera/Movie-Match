import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> genres = [];

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return buildRow(index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 0);
        },
        itemCount: genres.length);
  }

  Widget buildCard(int index, List<dynamic> movies) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
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
                              color: Color.fromRGBO(50, 50, 50, 1),
                            );
                          },
                          height:
                              (MediaQuery.of(context).size.width * 0.4 * 3) / 2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            top: (MediaQuery.of(context).size.width * 0.4 * 3) /
                                2.5,
                            left: MediaQuery.of(context).size.width * 0.27,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    movies[index]['liked'] = !movies[index]['liked'];
                                  });
                                },
                                icon: Icon(
                                  movies[index]['liked']? Icons.favorite : Icons.favorite_border,
                                  color: movies[index]['liked']? Color.fromRGBO(200, 0, 0, 1) : Colors.white,
                                  shadows: <Shadow>[
                                    Shadow(
                                        color: Colors.black, blurRadius: 10.0)
                                  ],
                                )))
                      ],
                    )
                  : null)
        ],
      );

  Widget buildRow(int index1) => Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 10),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                genres.length > 0 ? genres[index1]['name'] : '',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
              )),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
            height: (MediaQuery.of(context).size.width * 0.4 * 3) / 2,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 12, right: 12),
              itemBuilder: (context, index) {
                return index != genres[index1]['movies'].length - 1
                    ? Row(
                        children: [
                          buildCard(index, genres[index1]['movies']),
                          const SizedBox(width: 5)
                        ],
                      )
                    : Row(
                        children: [buildCard(index, genres[index1]['movies'])]);
              },
              itemCount: genres.length > 0
                  ? genres[index1]['movies'] != null
                      ? genres[index1]['movies'].length
                      : 0
                  : 0,
            ))
      ]);

  void fetchGenres() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';
    const image_path = 'https://image.tmdb.org/t/p/original';
    const url_image = 'https://image.tmdb.org/t/p/w500';

    var url = api_url + '/genre/movie/list?api_key=' + api_Key;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final gen = json['genres'];

    setState(() {
      genres = gen;
    });

    fetchMovies();
  }

  void fetchMovies() async {
    for (var genre in genres) {
      const api_url = 'https://api.themoviedb.org/3';
      const api_Key = '36e984f2374fdfcbcea58dba752094dc';
      const image_path = 'https://image.tmdb.org/t/p/original';
      const url_image = 'https://image.tmdb.org/t/p/w500';

      var url = api_url +
          '/discover/movie?api_key=' +
          api_Key +
          '&sort_by=popularity.desc&with_genres=' +
          genre['id'].toString();

      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final movs = json['results'];

      for (var element in movs) {
        element['liked'] = false;
      }

      setState(() {
        genre['movies'] = movs;
      });
    }
  }
}
