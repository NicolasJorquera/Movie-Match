import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';


class MovieTinderWidget extends StatefulWidget {
  int selectedIndex;
  Function setSelectedIndex;
  MovieTinderWidget({super.key, required this.setSelectedIndex, required this.selectedIndex});

  @override
  State<MovieTinderWidget> createState() => _MovieTinderWidgetState(this.setSelectedIndex, this.selectedIndex);
}

class _MovieTinderWidgetState extends State<MovieTinderWidget> {
  List <dynamic> dayTrending = [];
  Function setSelectedIndex;
  int selectedIndex;
  _MovieTinderWidgetState(this.setSelectedIndex, this.selectedIndex);

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
  }
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AppinioSwiper(
        onEnd: ()=> widget.setSelectedIndex() ,
        cardsCount: dayTrending.length,
        cardsBuilder: (BuildContext context, int index) {
          final movie = dayTrending[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(movie),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
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
