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
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500' + movies[index]['poster_path'],
                      height: (MediaQuery.of(context).size.width * 0.4 * 3) / 2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      fit: BoxFit.cover,
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
                genres.length>0? genres[index1]['name']:'',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
              )),
        ),
        SizedBox(
            height: (MediaQuery.of(context).size.width * 0.4 * 3) / 2,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 12, right: 12),
              itemBuilder: (context, index) {
                return index != genres[index1]['movies'].length - 1
                    ? Row(
                        children: [buildCard(index, genres[index1]['movies']), const SizedBox(width: 5)],
                      )
                    : Row(children: [buildCard(index, genres[index1]['movies'])]);
              },
              itemCount: genres.length>0? genres[index1]['movies'] !=null? genres[index1]['movies'].length: 0 : 0,
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
      setState(() {
        genre['movies'] = movs;
      });
    }
  }
}
