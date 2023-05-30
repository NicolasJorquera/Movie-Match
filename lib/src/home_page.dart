import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/home/home_page.dart';
import 'features/search/search_page.dart';
import 'features/movieMatch/createOrJoin_widget.dart';
import 'features/user/user_page.dart';
import 'features/selectPlatform/selectPlatform_page.dart';

class HomePage extends StatefulWidget {
  dynamic userData = {};
  HomePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(userData);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  dynamic userData = {};
  final user = FirebaseAuth.instance.currentUser!;
  static const url_image = 'https://image.tmdb.org/t/p/w500';
  int selectedIndex = 0;
  List<dynamic> platformsSelected = [];

  List<dynamic> movieProviders = [];
  List<dynamic> serieProviders = [];
  List<dynamic> providers = [];
  List<dynamic> genresMovies = [];
  List<dynamic> genresSeries = [];
  _HomePageState(userData);

  @override
  void initState() {
    super.initState();
    fetchSerieProviders();
    fetchMovieProviders();

    fetchGenresMovies();
    fetchGenresSeries();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {


    final screens = [
      HomeView(
        genresMovies: genresMovies,
        genresSeries: genresSeries,
        refreshMovies: (){
          fetchMovies();
        },
        refreshSeries: (){
          fetchSeries();
        },
      ),
      // const SearchView(),
      CreateOrJoinWidget(
          platformsSelected: platformsSelected,
          providers: providers,
          genres: genresMovies),
      UsersView(
        fetchMovies: () {
          fetchMovies();
        },
        userData: widget.userData,
        providers: providers,
        platformsSelected: platformsSelected,
        setPlatformsSelected: (mode, value) {
          if (mode == 'add') {
            setState(() {
              platformsSelected.add(value);
            });
          } else if (mode == 'remove') {
            setState(() {
              platformsSelected.remove(value);
            });
          }
        },
        setProviders: (mode, value) {
          if (mode == 'add') {
            setState(() {
              providers.add(value);
            });
          } else if (mode == 'remove') {
            setState(() {
              providers.remove(value);
            });
          }
        },
      )
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchView()));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ))
          ],
          title: Row(
            children: [
              Image.asset(
                'assets/icon/flixerLogo.png',
                height: 45,
                width: 45,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'FLIXER',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w100),
              )
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                // pinned: true,
                // floating: true,
                // forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                    child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                                child: ShaderMask(
                                    shaderCallback: (Rect rect) {
                                      return const LinearGradient(
                                        colors: [
                                          Colors.purple,
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.purple
                                        ],
                                        stops: [
                                          0.0,
                                          0.0,
                                          0.95,
                                          1.0
                                        ], // 10% purple, 80% transparent, 10% purple
                                      ).createShader(rect);
                                    },
                                    blendMode: BlendMode.dstOut,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                              primary:
                                                  Color.fromRGBO(180, 0, 0, 1),
                                              secondary: Color.fromRGBO(
                                                  180, 0, 0, 1))),
                                      child: ListView.separated(
                                          reverse: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (platformsSelected.every(
                                                        (element) =>
                                                            element['enable'] ==
                                                            true) &&
                                                    providers.every((element) =>
                                                        element['enable'] ==
                                                        true)) {
                                                  setState(() {
                                                    for (var element
                                                        in platformsSelected) {
                                                      element['enable'] = false;
                                                    }
                                                  });
                                                  setState(() {
                                                    for (var element
                                                        in providers) {
                                                      element['enable'] = false;
                                                    }
                                                  });
                                                }
                                                if (platformsSelected.every(
                                                    (element) =>
                                                        element['enable'])) {
                                                  setState(() {
                                                    for (var element
                                                        in platformsSelected) {
                                                      element['enable'] = false;
                                                    }
                                                  });
                                                }
                                                setState(() {
                                                  platformsSelected[index]
                                                          ['enable'] =
                                                      !platformsSelected[index]
                                                          ['enable'];
                                                });

                                                fetchMovies();
                                                fetchSeries();
                                              },
                                              child: Card(
                                                color: Colors.transparent,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                child: Image.network(
                                                  url_image +
                                                      platformsSelected[index]
                                                          ['logo_path'],
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Container(
                                                      color:
                                                          const Color.fromRGBO(
                                                              50, 50, 50, 1),
                                                    );
                                                  },
                                                  fit: BoxFit.cover,
                                                  color: providers.every(
                                                                  (element) =>
                                                                      element['enable'] ==
                                                                      true) &&
                                                              platformsSelected
                                                                  .every((element) =>
                                                                      element['enable'] ==
                                                                      true) ||
                                                          (platformsSelected.any(
                                                                  (element) =>
                                                                      element[
                                                                          'enable']) &&
                                                              !platformsSelected[
                                                                      index]
                                                                  ['enable'])
                                                      ? const Color.fromRGBO(
                                                          0, 0, 0, 0.5)
                                                      : Colors.transparent,
                                                  colorBlendMode:
                                                      BlendMode.darken,
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              width: 1,
                                            );
                                          },
                                          itemCount: platformsSelected.length),
                                    ))),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Card(
                                color: Colors.white24,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: TextButton(
                                  child: const Icon(
                                    Icons.add,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectPlatformView(
                                                fetchMovies: () {
                                                  fetchMovies();
                                                  fetchSeries();
                                                },
                                                providers: providers,
                                                platformsSelected:
                                                    platformsSelected,
                                                setPlatformsSelected:
                                                    (mode, value) {
                                                  if (mode == 'add') {
                                                    setState(() {
                                                      platformsSelected
                                                          .add(value);
                                                    });
                                                  } else if (mode == 'remove') {
                                                    setState(() {
                                                      platformsSelected
                                                          .remove(value);
                                                    });
                                                  }
                                                },
                                                setProviders: (mode, value) {
                                                  if (mode == 'add') {
                                                    setState(() {
                                                      providers.add(value);
                                                    });
                                                  } else if (mode == 'remove') {
                                                    setState(() {
                                                      providers.remove(value);
                                                    });
                                                  }
                                                },
                                              )),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Card(
                                  color: providers.every((element) =>
                                              element['enable'] == true) &&
                                          platformsSelected.every((element) =>
                                              element['enable'] == true)
                                      ? const Color.fromRGBO(180, 0, 0, 1)
                                      : Colors.black,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: providers.every((element) =>
                                                      element['enable'] ==
                                                      true) &&
                                                  platformsSelected
                                                      .every((element) => element['enable'] == true)
                                              ? const Color.fromRGBO(180, 0, 0, 1)
                                              : Colors.white24,
                                          width: 2),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: TextButton(
                                    onPressed: () {
                                      if (providers.every(
                                              (element) => element['enable']) &&
                                          platformsSelected.every(
                                              (element) => element['enable'])) {
                                        setState(() {
                                          for (var element in providers) {
                                            element['enable'] = false;
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          for (var element in providers) {
                                            element['enable'] = true;
                                          }
                                        });
                                      }

                                      setState(() {
                                        for (var element in platformsSelected) {
                                          element['enable'] = true;
                                        }
                                      });
                                      fetchMovies();
                                      fetchSeries();
                                    },
                                    child: const Text(
                                      'All',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 12,
                            )
                          ],
                        )),
                    preferredSize: const Size.fromHeight(0)),
              )
            ];
          },
          body: Container(
            padding: const EdgeInsets.only(top: 10),
            child: IndexedStack(
              index: selectedIndex,
              children: screens,
            ),
          ),
        ),
        bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    icon: selectedIndex == 0
                        ? const Icon(
                            Icons.home,
                            color: Color.fromRGBO(180, 0, 0, 1),
                            size: 30,
                          )
                        : const Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 30,
                          )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: selectedIndex == 1
                        ? const Icon(
                            Icons.flash_on,
                            color: Color.fromRGBO(180, 0, 0, 1),
                            size: 30,
                          )
                        : const Icon(
                            Icons.flash_on,
                            color: Colors.white,
                            size: 30,
                          )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    icon: selectedIndex == 2
                        ? const Icon(
                            Icons.person,
                            color: Color.fromRGBO(180, 0, 0, 1),
                            size: 30,
                          )
                        : const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30,
                          ))
              ],
            )
            // BottomNavigationBar(
            //   enableFeedback: true,
            //   backgroundColor: Colors.black,
            //   type: BottomNavigationBarType.fixed,
            //   showSelectedLabels: false,
            //   showUnselectedLabels: false,
            //   currentIndex: selectedIndex,
            //   onTap: (value) {
            //     setState(() {
            //       selectedIndex = value;
            //     });
            //   },
            //   elevation: 0,
            //   items: const [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.home, color: Colors.white),
            //       activeIcon:
            //           Icon(Icons.home, color: Color.fromRGBO(180, 0, 0, 1)),
            //       label: '',
            //       backgroundColor: Colors.transparent,
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.flash_on, color: Colors.white),
            //       activeIcon:
            //           Icon(Icons.flash_on, color: Color.fromRGBO(180, 0, 0, 1)),
            //       label: '',
            //       backgroundColor: Colors.transparent,
            //     ),

            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.person, color: Colors.white),
            //       activeIcon:
            //           Icon(Icons.person, color: Color.fromRGBO(180, 0, 0, 1)),
            //       label: '',
            //       backgroundColor: Colors.transparent,
            //     ),
            //   ],
            // ),
            ));
  }

  void fetchMovieProviders() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var url = api_url +
        '/watch/providers/movie?api_key=' +
        api_Key +
        '&watch_region=' +
        'CL';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final prov = json['results'];

    setState(() {
      movieProviders = prov;
    });

    providers = movieProviders;

    setState(() {
      for (var element in providers) {
        element['enable'] = false;
      }
    });
    for (var i = 0; i < 3; i++) {
      setState(() {
        platformsSelected.add(providers[i]);
      });
      setState(() {
        platformsSelected.last['enable'] = true;
      });
    }

    int offset = 0;
    for (var i = 0; i < 3; i++) {
      setState(() {
        providers.remove(providers[i - offset]);
      });
      offset++;
    }
    setState(() {
      providers.sort((a, b) => a['provider_name']
          .toString()
          .compareTo(b['provider_name'].toString()));
    });

    fetchMovies();
    fetchSeries();
  }

  void fetchSerieProviders() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var url = api_url +
        '/watch/providers/tv?api_key=' +
        api_Key +
        '&watch_region=' +
        'CL';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final prov = json['results'];

    setState(() {
      serieProviders = prov;
    });

    // providers = movieProviders + serieProviders;

    setState(() {
      for (var element in providers) {
        element['enable'] = false;
      }
    });
    // fetchSeries();
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

    // fetchMovies();
  }

  void fetchMovies() async {
    for (var genre in genresMovies) {
      const api_url = 'https://api.themoviedb.org/3';
      const api_Key = '36e984f2374fdfcbcea58dba752094dc';

      List platformsSelectedIds = [];

      if (platformsSelected.isNotEmpty) {
        platformsSelected.forEach((element) {
          if (element['enable'] == true) {
            platformsSelectedIds.add(element['provider_id']);
          }
        });
      }

      if (providers.every((element) => element['enable']) &&
          platformsSelected.every((element) => element['enable'])) {
        //checks if all button is pressed
        platformsSelectedIds = [];
      }

      var url = api_url +
          '/discover/movie?'
              'sort_by=popularity.desc&with_genres=' +
          genre['id'].toString() +
          '&watch_region=CL' +
          '&with_watch_providers=' +
          (platformsSelectedIds.isNotEmpty
              ? platformsSelectedIds
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(',', '|')
                  .replaceAll(' ', '')
              : '') +
          '&api_key=' +
          api_Key;

      print(url);

      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final movs = json['results'];

      final usersSnap = await FirebaseDatabase.instance.ref("users/").get();
      String userID = usersSnap.children
          .firstWhere((usr) => usr.child('email').value == user.email)
          .key!;

      final usersMoviesSnap = await FirebaseDatabase.instance
          .ref("users/" + userID + "/likedMovies/")
          .get();

      for (var element in movs) {
        bool isMovieLiked = usersMoviesSnap.children
            .any((movieLiked) => movieLiked.child('id').value == element['id']);
        if (isMovieLiked) {
          element['liked'] = true;
        } else {
          element['liked'] = false;
        }
      }
      movs.shuffle();
      setState(() {
        genre['movies'] = movs;
      });
    }
  }

  void fetchGenresSeries() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var url = api_url + '/genre/tv/list?api_key=' + api_Key;

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final gen = json['genres'];

    setState(() {
      genresSeries = gen;
    });

    // if (platformsSelected.isNotEmpty || providers.isNotEmpty) {
    //   fetchSeries();
    // }
  }

  void fetchSeries() async {
    for (var genre in genresSeries) {
      const api_url = 'https://api.themoviedb.org/3';
      const api_Key = '36e984f2374fdfcbcea58dba752094dc';

      List platformsSelectedIds = [];

      if (platformsSelected.isNotEmpty) {
        platformsSelected.forEach((element) {
          if (element['enable'] == true) {
            dynamic serieProvider = serieProviders.firstWhere(
              (serieProvider) =>
                  serieProvider['provider_name'] == element['provider_name'],
              orElse: () => null,
            );

            if (serieProvider != null) {
              platformsSelectedIds.add(serieProvider['provider_id']);
            }
          }
        });
      }

      if (providers.every((element) => element['enable']) &&
          platformsSelected.every((element) => element['enable'])) {
        //checks if all button is pressed
        platformsSelectedIds = [];
      }

      var url = api_url +
          '/discover/tv?' +
          '&sort_by=popularity.desc&with_genres=' +
          genre['id'].toString() +
          '&watch_region=CL' +
          '&with_watch_providers=' +
          (platformsSelectedIds.isNotEmpty
              ? platformsSelectedIds
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '')
                  .replaceAll(',', '|')
                  .replaceAll(' ', '')
              : '') +
          '&api_key=' +
          api_Key;

      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final srs = json['results'];

      final usersSnap = await FirebaseDatabase.instance.ref("users/").get();
      String userID = usersSnap.children
          .firstWhere((usr) => usr.child('email').value == user.email)
          .key!;

      final usersMoviesSnap = await FirebaseDatabase.instance
          .ref("users/" + userID + "/likedSeries/")
          .get();

      for (var element in srs) {
        bool isSerieLiked = usersMoviesSnap.children
            .any((movieLiked) => movieLiked.child('id').value == element['id']);
        if (isSerieLiked) {
          element['liked'] = true;
        } else {
          element['liked'] = false;
        }
      }

      srs.shuffle();
      setState(() {
        genre['series'] = srs;
      });
    }
  }
}
