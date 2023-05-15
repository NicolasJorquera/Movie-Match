import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class MovieTinderWidget extends StatefulWidget {
  String sessionID = '';
  MovieTinderWidget({super.key, required this.sessionID});

  @override
  State<MovieTinderWidget> createState() =>
      _MovieTinderWidgetState(this.sessionID);
}

class _MovieTinderWidgetState extends State<MovieTinderWidget> {
  List<dynamic> dayTrending = [];
  String sessionID = '';
  String image_path = 'https://image.tmdb.org/t/p/original';
  final user = FirebaseAuth.instance.currentUser!;
  _MovieTinderWidgetState(this.sessionID);
  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: AppinioSwiper(
          onSwipe: (index, direction) async {
            if (direction == AppinioSwiperDirection.right) {
              final usersRef =
                  await FirebaseDatabase.instance.ref("users/").get();

              DataSnapshot userSnapshot = usersRef.children
                  .firstWhere((usr) => usr.child('email').value == user.email);

              DatabaseReference sessionMoviesLikedRef =
                  FirebaseDatabase.instance.ref("matchSessions/" +
                      sessionID.toString() +
                      '/users/' +
                      userSnapshot.key.toString() +
                      '/moviesLiked');

              sessionMoviesLikedRef
                  .child(dayTrending[index]['id'].toString())
                  .set(dayTrending[index]);
            }
          },
          onEnd: () => Navigator.pop(context),
          cardsCount: dayTrending.length,
          cardsBuilder: (BuildContext context, int index) {
            final movie = dayTrending[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                image: DecorationImage(
                  image: NetworkImage(image_path + movie['poster_path']),
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
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

    setState(() {
      dayTrending = movs;
    });
  }
}
