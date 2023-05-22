import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../../../home/widget/movieInfo_widget.dart';
import 'tinder_buttons.dart';
import '../results/results_widget.dart';

class MovieTinderWidget extends StatefulWidget {
  String sessionID = '';
  List<dynamic> allProviders = [];
  MovieTinderWidget({super.key, required this.sessionID});

  @override
  State<MovieTinderWidget> createState() =>
      _MovieTinderWidgetState(sessionID, this.allProviders);
}

class _MovieTinderWidgetState extends State<MovieTinderWidget> {
  List<dynamic> sessionMovies = [];
  String sessionID = '';
  Map sessionData = {};
  List<dynamic> allProviders = [];
  String image_path = 'https://image.tmdb.org/t/p/w500';
  final user = FirebaseAuth.instance.currentUser!;
  _MovieTinderWidgetState(this.sessionID, this.allProviders);
  final AppinioSwiperController controller = AppinioSwiperController();
  int cardIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchSessionMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Row(children: [
              BackButton(
                color: Colors.white,
              ),
              Text(
                'Back',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.68,
              child: AppinioSwiper(
                swipeOptions: AppinioSwipeOptions.horizontal,
                unlimitedUnswipe: true,
                unswipe: (unswiped) {
                  if (unswiped) {
                    cardIndex--;
                  }
                },
                controller: controller,
                onSwipe: (index, direction) async {
                  if (direction == AppinioSwiperDirection.right) {
                    final usersRef =
                        await FirebaseDatabase.instance.ref("users/").get();

                    DataSnapshot userSnapshot = usersRef.children.firstWhere(
                        (usr) => usr.child('email').value == user.email);

                    DatabaseReference sessionMoviesLikedRef =
                        FirebaseDatabase.instance.ref("matchSessions/" +
                            sessionID.toString() +
                            '/flixers/' +
                            userSnapshot.key.toString() +
                            '/moviesLiked');

                    sessionMoviesLikedRef
                        .child(sessionMovies[index]['id'].toString())
                        .set(sessionMovies[index]);

                    cardIndex++;
                  }
                },
                onEnd: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultsWidget(
                              sessionID: sessionID,
                              allProviders: widget.allProviders,
                            )),
                  );
                },
                cardsCount: sessionMovies.length - 1,
                cardsBuilder: (BuildContext context, int index) {
                  final movie = sessionMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieInfoPage(
                                  movie: movie,
                                )),
                      );
                    },
                    child: Card(
                      color: Colors.transparent,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image:
                                NetworkImage(image_path + movie['poster_path']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                unswipeButton(controller),
                swipeLeftButton(controller),
                swipeRightButton(controller),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieInfoPage(
                                movie: sessionMovies[cardIndex],
                              )),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.movie_creation_outlined,
                      color: Color.fromRGBO(150, 150, 150, 1),
                      size: 40,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void fetchSessionMovies() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';
    const image_path = 'https://image.tmdb.org/t/p/original';
    const url_image = 'https://image.tmdb.org/t/p/original';

    DatabaseReference sessionRef =
        FirebaseDatabase.instance.ref("matchSessions/" + sessionID.toString());

    DataSnapshot sessionSnapshot = await sessionRef.get();

    if (sessionSnapshot.exists && sessionSnapshot.key != 0) {
      setState(() {
        sessionData = Map<dynamic, dynamic>.from(
            sessionSnapshot.child('sessionData').value! as Map);
      });

      String movieOrSeries = '';
      if (sessionData['MoviesOrSeries'] == 'Movies and Series') {
        movieOrSeries = 'movie';
      } else if (sessionData['MoviesOrSeries'] == 'Movies') {
        movieOrSeries = 'movie';
      } else if (sessionData['MoviesOrSeries'] == 'Series') {
        movieOrSeries = 'tv';
      }

      var urlGenres =
          api_url + '/genre/' + movieOrSeries + '/list?api_key=' + api_Key;
      final uriGenres = Uri.parse(urlGenres);
      final responseGenres = await http.get(uriGenres);
      final bodyGenres = responseGenres.body;
      final jsonGenres = jsonDecode(bodyGenres);
      final genres = jsonGenres['genres'];
      String idGenres = '';
      if (sessionData['Genres'] == null) {
        idGenres = '';
      } else {
        for (var genre in sessionData['Genres']) {
          genres.forEach((element) {
            if (element['name'] == genre) {
              if (idGenres == '') {
                idGenres += element['id'].toString();
              } else {
                idGenres += '|' + element['id'].toString();
              }
            }
          });
        }
      }

      String idGenres2 = '';
      if (sessionData['MoviesOrSeries'] == 'Movies and Series') {
        var urlGenres = api_url + '/genre/' + 'tv' + '/list?api_key=' + api_Key;
        final uriGenres = Uri.parse(urlGenres);
        final responseGenres = await http.get(uriGenres);
        final bodyGenres = responseGenres.body;
        final jsonGenres = jsonDecode(bodyGenres);
        final genres = jsonGenres['genres'];

        if (sessionData['Genres'] == null) {
          idGenres = '';
        } else {
          for (var genre in sessionData['Genres']) {
            genres.forEach((element) {
              if (element['name'] == genre) {
                if (idGenres == '') {
                  idGenres2 += element['id'].toString();
                } else {
                  idGenres2 += '|' + element['id'].toString();
                }
              }
            });
          }
        }
      }

      var urlProviders = api_url +
          '/watch/providers/' +
          movieOrSeries +
          '?watch_region=CL&api_key=' +
          api_Key;
      final uriProvider = Uri.parse(urlProviders);
      final responseProviders = await http.get(uriProvider);
      final bodyProviders = responseProviders.body;
      final jsonProviders = jsonDecode(bodyProviders);
      final providers = jsonProviders['results'];
      String idProviders = '';

      if (sessionData['Platforms'] == null) {
        idProviders = '';
      } else {
        for (var platform in sessionData['Platforms']) {
          providers.forEach((element) {
            if (element['provider_name'] == platform) {
              if (idProviders == '') {
                idProviders += element['provider_id'].toString();
              } else {
                idProviders += '|' + element['provider_id'].toString();
              }
            }
          });
        }
      }

      String idProviders2 = '';
      if (sessionData['MoviesOrSeries'] == 'Movies and Series') {
        var urlProviders = api_url +
            '/watch/providers/' +
            'tv' +
            '?watch_region=CL&api_key=' +
            api_Key;
        final uriProvider = Uri.parse(urlProviders);
        final responseProviders = await http.get(uriProvider);
        final bodyProviders = responseProviders.body;
        final jsonProviders = jsonDecode(bodyProviders);
        final providers = jsonProviders['results'];

        if (sessionData['Platforms'] == null) {
          idProviders = '';
        } else {
          for (var platform in sessionData['Platforms']) {
            providers.forEach((element) {
              if (element['provider_name'] == platform) {
                if (idProviders == '') {
                  idProviders += element['provider_id'].toString();
                } else {
                  idProviders += '|' + element['provider_id'].toString();
                }
              }
            });
          }
        }
      }

      var url = api_url +
          '/discover/' +
          movieOrSeries +
          '?api_key=' +
          api_Key +
          '&sort_by=popularity.desc&with_genres=' +
          idGenres +
          '&watch_region=CL' +
          '&with_watch_providers=' +
          idProviders;

      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final movs = json['results'];

      dynamic series = {};
      if (sessionData['MoviesOrSeries'] == 'Movies and Series') {
        var url = api_url +
            '/discover/' +
            'tv' +
            '?api_key=' +
            api_Key +
            '&sort_by=popularity.desc&with_genres=' +
            idGenres2 +
            '&watch_region=CL' +
            '&with_watch_providers=' +
            idProviders2;

        final uri = Uri.parse(url);
        final response = await http.get(uri);
        final body = response.body;
        final json = jsonDecode(body);
        series = json['results'];
      }

      setState(() {
        sessionMovies = movs;
      });

      if (sessionData['MoviesOrSeries'] == 'Movies and Series') {
        if (sessionMovies.length < 10) {
          setState(() {
            sessionMovies.addAll(series);
          });
        } else {
          setState(() {
            sessionMovies = sessionMovies.sublist(0, 10);
          });
          setState(() {
            sessionMovies.addAll(series);
          });
        }
        setState(() {
          sessionMovies.shuffle();
        });
      }
    }
  }
}
