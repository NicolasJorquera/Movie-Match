import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../home/widget/movieInfo_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<dynamic> search = [];
  List<dynamic> genresMovies = [];
  List<dynamic> genresSeries = [];
  String searchString = '';
  String image_path = 'https://image.tmdb.org/t/p/w500';
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
    fetchGenresMovies();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.white,
                  ),
                  Text('Back',
                      style: const TextStyle(color: Colors.white, fontSize: 20))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: SearchBar(
                        focusNode: FocusNode(),
                    hintText: 'Search...',
                    hintStyle: const MaterialStatePropertyAll(
                        TextStyle(color: Colors.white54, fontSize: 17)),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white24),
                    textStyle: const MaterialStatePropertyAll(
                        TextStyle(color: Colors.white, fontSize: 17)),
                    onChanged: (value) {
                      setState(() {
                        searchString = value;
                      });
                      fetchSearch();
                      if (value == '') {
                        fetchTrendingMovies();
                      }
                    },
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: 100,
                            width: double.maxFinite,
                            child: GestureDetector(
                                // onDoubleTap: () {
                                //   setState(() {
                                //     search[index]['liked'] =
                                //         !search[index]['liked'];
                                //   });
                                // },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieInfoPage(
                                              movie: search[index],
                                            )),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                          color: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: SizedBox(
                                              height: 100,
                                              width: 70,
                                              child: search[index]
                                                          ['poster_path'] ==
                                                      null
                                                  ? Container(
                                                      color: Colors.white24,
                                                    )
                                                  : Image.network(
                                                      image_path +
                                                          search[index]
                                                              ['poster_path'],
                                                      fit: BoxFit.cover,
                                                    )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              height: 50,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  Text(
                                                    search[index]['title'] ??
                                                        search[index]['name'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                  width: 200,
                                                  child: ListView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              findGenres(search[
                                                                      index][
                                                                  'genre_ids']),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  search[index]
                                                          ['release_date'] ??
                                                      search[index]
                                                          ['first_air_date'],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            search[index]['liked'] =
                                                !search[index]['liked'];
                                          });

                                          final usersSnap =
                                              await FirebaseDatabase.instance
                                                  .ref("users/")
                                                  .get();
                                          String userID = usersSnap.children
                                              .firstWhere((usr) =>
                                                  usr.child('email').value ==
                                                  user.email)
                                              .key!;

                                          DatabaseReference usersMoviesRef =
                                              await FirebaseDatabase.instance
                                                  .ref("users/" +
                                                      userID +
                                                      "/likedMovies/");
                                          DataSnapshot usersMoviesSnap =
                                              await usersMoviesRef.get();

                                          dynamic movieAlreadyExists;
                                          if (usersMoviesSnap.value != null) {
                                            movieAlreadyExists =
                                                usersMoviesSnap.children.any(
                                              (movie) =>
                                                  movie.child('id').value ==
                                                  search[index]['id'],
                                            );
                                          } else {
                                            movieAlreadyExists = false;
                                          }

                                          if (search[index]['liked'] &&
                                              !movieAlreadyExists) {
                                            DatabaseReference movieKey =
                                                usersMoviesRef.push();

                                            movieKey.set(search[index]);
                                          } else {
                                            final usersMoviesSnap =
                                                await usersMoviesRef.get();
                                            if (usersMoviesSnap.children.any(
                                                (movie) =>
                                                    movie.child('id').value ==
                                                    search[index]['id'])) {
                                              String movieID = '';
                                              if (usersMoviesSnap.value !=
                                                  null) {
                                                movieID = usersMoviesSnap
                                                    .children
                                                    .firstWhere((movie) =>
                                                        movie
                                                            .child('id')
                                                            .value ==
                                                        search[index]['id'])
                                                    .key!;
                                              }

                                              usersMoviesRef
                                                  .child(movieID)
                                                  .remove();
                                            }
                                          }
                                        },
                                        icon: Icon(
                                          search[index]['liked']
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: search[index]['liked']
                                              ? const Color.fromRGBO(
                                                  200, 0, 0, 1)
                                              : Colors.white,
                                        ))
                                  ],
                                )));
                      },
                      separatorBuilder: (context, index) {
                        return const Column(
                          children: [
                            SizedBox(
                              height: 2,
                            ),
                            Divider(
                              color: Colors.white24,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 2,
                            ),
                          ],
                        );
                      },
                      itemCount: search.length))
            ],
          )),
    ));
  }

  void fetchGenresMovies() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var url = api_url + '/genre/movie/list?api_key=' + api_Key;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final gen = json['genres'];

    setState(() {
      genresMovies = gen;
    });
  }

  void fetchSeriesMovies() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var url = api_url + '/genre/movie/list?api_key=' + api_Key;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final gen = json['genres'];

    setState(() {
      genresSeries = gen;
    });
  }

  String findGenres(List genre_ids) {
    String genres = '';
    if (genre_ids.isNotEmpty) {
      for (var i = 0; i < genre_ids.length; i++) {
        dynamic genreData = genresMovies.firstWhere(
          (genre) => genre_ids[i] == genre['id'],
          orElse: () => null,
        );
        String genre = '';
        if (genreData != null) {
          genre = genreData['name'];
        } else {
          genreData = genresSeries.firstWhere(
            (genre) => genre_ids[i] == genre['id'],
            orElse: () => null,
          );
          if (genreData != null) {
            genre = genreData['name'];
          }
        }
        if (genre != '') {
          if (i == 0) {
            genres = genre;
          } else if (i == genre_ids.length - 1) {
            genres = genres + ' and ' + genre;
          } else {
            genres = genres + ', ' + genre;
          }
        }
      }
    }
    return genres;
  }

  void fetchTrendingMovies() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var url = api_url + '/trending/movie/day?api_key=' + api_Key;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final movs = json['results'];

    setState(() {
      search = movs;
    });

    for (var movie in search) {
      movie['liked'] = false;
    }
  }

  void fetchSearch() async {
    setState(() {
      search = [];
    });
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var urlMovies =
        api_url + '/search/movie?api_key=' + api_Key + '&query=' + searchString;

    final uriMovies = Uri.parse(urlMovies);
    final responseMovies = await http.get(uriMovies);
    final bodyMovies = responseMovies.body;
    final jsonMovies = jsonDecode(bodyMovies);
    final movs = jsonMovies['results'];

    var urlSeries =
        api_url + '/search/tv?api_key=' + api_Key + '&query=' + searchString;

    final uriSeries = Uri.parse(urlSeries);
    final responseSeries = await http.get(uriSeries);
    final bodySeries = responseSeries.body;
    final jsonSeries = jsonDecode(bodySeries);
    final srs = jsonSeries['results'];

    setState(() {
      search = movs + srs;
    });

    setState(() {
      search.sort((a, b) {
        return b['popularity'].compareTo(a['popularity']);
      });
    });

    for (var movie in search) {
      movie['liked'] = false;
    }
  }
}
