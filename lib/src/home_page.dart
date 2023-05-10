import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'features/home/home_page.dart';
import 'features/search/search_page.dart';
import 'features/movieMatch/createOrJoin_widget.dart';
import 'features/user/user_page.dart';
import 'features/selectPlatform/selectPlatform_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const url_image = 'https://image.tmdb.org/t/p/w500';
  int selectedIndex = 0;
  int previousSelectedIndex = 0;
  List<dynamic> platformsSelected = [];

  List<dynamic> movieProviders = [];
  List<dynamic> serieProviders = [];
  List<dynamic> providers = [];

  @override
  void initState() {
    super.initState();
    fetchMovieProviders();
    fetchSerieProviders();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeView(),
      CreateOrJoinWidget(
        platformsSelected: platformsSelected,
        providers: providers,
      ),
      const SearchView(),
      UsersView(
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
        appBar: AppBar(
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
                                        primary: Color.fromRGBO(180, 0, 0, 1),
                                        secondary:
                                            Color.fromRGBO(180, 0, 0, 1))),
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
                                                  element['enable'] == true)) {
                                            setState(() {
                                              platformsSelected
                                                  .forEach((element) {
                                                element['enable'] = false;
                                              });
                                            });
                                            setState(() {
                                              providers.forEach((element) {
                                                element['enable'] = false;
                                              });
                                            });
                                          }
                                          if (platformsSelected.every(
                                              (element) => element['enable'])) {
                                            setState(() {
                                              platformsSelected
                                                  .forEach((element) {
                                                element['enable'] = false;
                                              });
                                            });
                                          }
                                          setState(() {
                                            platformsSelected[index]['enable'] =
                                                !platformsSelected[index]
                                                    ['enable'];
                                          });

                                          print(platformsSelected);
                                        },
                                        child: Card(
                                          color: Colors.transparent,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Image.network(
                                            url_image +
                                                platformsSelected[index]
                                                    ['logo_path'],
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                color: Color.fromRGBO(
                                                    50, 50, 50, 1),
                                              );
                                            },
                                            fit: BoxFit.cover,
                                            color: providers.every((element) =>
                                                            element['enable'] ==
                                                            true) &&
                                                        platformsSelected.every(
                                                            (element) =>
                                                                element[
                                                                    'enable'] ==
                                                                true) ||
                                                    (platformsSelected.any(
                                                            (element) => element[
                                                                'enable']) &&
                                                        !platformsSelected[
                                                            index]['enable'])
                                                ? const Color.fromRGBO(
                                                    0, 0, 0, 0.5)
                                                : Colors.transparent,
                                            colorBlendMode: BlendMode.darken,
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
                                    builder: (context) => SelectPlatformView(
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
                                    platformsSelected.every(
                                        (element) => element['enable'] == true)
                                ? const Color.fromRGBO(180, 0, 0, 1)
                                : Colors.black,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: providers.every((element) =>
                                                element['enable'] == true) &&
                                            platformsSelected.every((element) =>
                                                element['enable'] == true)
                                        ? const Color.fromRGBO(180, 0, 0, 1)
                                        : Colors.white24,
                                    width: 2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10))),
                            child: TextButton(
                              onPressed: () {
                                if (providers.every(
                                        (element) => element['enable']) &&
                                    platformsSelected.every(
                                        (element) => element['enable'])) {
                                  setState(() {
                                    providers.forEach((element) {
                                      element['enable'] = false;
                                    });
                                  });
                                } else {
                                  setState(() {
                                    providers.forEach((element) {
                                      element['enable'] = true;
                                    });
                                  });
                                }

                                setState(() {
                                  platformsSelected.forEach((element) {
                                    element['enable'] = true;
                                  });
                                });
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
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 10),
          child: IndexedStack(
            index: selectedIndex,
            children: screens,
          ),
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                previousSelectedIndex = selectedIndex;
                selectedIndex = value;
              });
            },
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                activeIcon:
                    Icon(Icons.home, color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.flash_on, color: Colors.white),
                activeIcon:
                    Icon(Icons.flash_on, color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white),
                activeIcon:
                    Icon(Icons.search, color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.white),
                activeIcon:
                    Icon(Icons.person, color: Color.fromRGBO(180, 0, 0, 1)),
                label: '',
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ));
  }

  void fetchMovieProviders() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';
    const image_path = 'https://image.tmdb.org/t/p/original';
    const url_image = 'https://image.tmdb.org/t/p/original';

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
      providers.forEach((element) {
        element['enable'] = false;
      });
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
  }

  void fetchSerieProviders() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';
    const image_path = 'https://image.tmdb.org/t/p/original';
    const url_image = 'https://image.tmdb.org/t/p/original';

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
      providers.forEach((element) {
        element['enable'] = false;
      });
    });
  }
}
