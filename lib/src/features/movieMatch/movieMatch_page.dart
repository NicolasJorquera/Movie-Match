import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

import 'widgets/createOrJoin_widget.dart';
import 'widgets/movieTinder_widget.dart';

class MovieMatchView extends StatefulWidget {
  const MovieMatchView({super.key});

  @override
  State<MovieMatchView> createState() => _MovieMatchViewState();
}

class _MovieMatchViewState extends State<MovieMatchView> {
  List<dynamic> dayTrending = [];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final widgets = [
      CreateOrJoinWidget(
        setSelectedIndex: () {
          setState(() {
            selectedIndex = 1;
          });
        },
        selectedIndex: selectedIndex,
      ),
      MovieTinderWidget(
        setSelectedIndex: () {
          setState(() {
            selectedIndex = 0;
          });
        },
        selectedIndex: selectedIndex,
      )
    ];

    return widgets[selectedIndex];
  }

  void fetchTrendingMovies() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';
    const image_path = 'https://image.tmdb.org/t/p/original';
    const url_image = 'https://image.tmdb.org/t/p/original';

    var url = api_url + '/trending/movie/day?api_key=' + api_Key;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final movs = json['results'];

    for (var movie in movs) {
      setState(() {
        dayTrending.add(url_image + movie['poster_path']);
      });
    }
  }
}
