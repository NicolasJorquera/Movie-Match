import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class MovieInfoPage extends StatefulWidget {
  final dynamic movie;
  const MovieInfoPage({super.key, required this.movie});
  @override
  _MovieInfoPageState createState() => _MovieInfoPageState(movie);
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  dynamic _controller = '';
  final dynamic movie;
  List videos = [];
  List cast = [];
  bool isVideoEnded = false;
  List recommendations = [];
  List platforms = [];
  String genres = '';
  _MovieInfoPageState(this.movie);

  static const image_url = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    super.initState();
    fetchVideos();
    fetchCast();
    fetchRecommendations();
    fetchPlatforms();
    fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
        body: Theme(
      data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(180, 0, 0, 1),
              secondary: Color.fromRGBO(180, 0, 0, 1))),
      child: WillPopScope(
        onWillPop: () {
          if (videos.isNotEmpty) {
            setState(() {
              _controller.pause();
            });
            setState(() {
              isVideoEnded = true;
            });
          }

          return Future.value(true);
        },
        child: ListView(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: movie['backdrop_path'] == null
                        ? Container()
                        : (videos.isEmpty && !isVideoEnded) || isVideoEnded
                            ? Image.network(
                                image_url + movie['backdrop_path'],
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: YoutubePlayer(
                                  controlsTimeOut: Duration.zero,
                                  controller: _controller,
                                  showVideoProgressIndicator: false,
                                  onReady: () {
                                    setState(() {
                                      isVideoEnded = false;
                                    });
                                  },
                                  onEnded: (metaData) {
                                    setState(() {
                                      isVideoEnded = true;
                                    });
                                  },
                                ),
                              ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.22,
                  right: MediaQuery.of(context).size.width * 0.85,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(180, 0, 0, 1),
                                secondary: Color.fromRGBO(180, 0, 0, 1))),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Text(
                                movie['title'] == null
                                    ? movie['name']
                                    : movie['title'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    overflow: TextOverflow.fade),
                              ),
                            ]),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 10,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie['vote_average'].toString() + '/10',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 5,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            movie['release_date'] == null
                                ? movie['first_air_date']
                                : movie['release_date'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.circle,
                            color: Colors.white,
                            size: 5,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            genres,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                movie['overview'],
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.white24,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'Trailer',
            //     style: TextStyle(color: Colors.white, fontSize: 20),
            //   ),
            // ),
            // videos.length > 0
            //     ? Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: YoutubePlayer(
            //           controller: _controller,
            //           showVideoProgressIndicator: false,
            //           bottomActions: [],
            //           topActions: [],
            //         ),
            //       )
            //     : Container(),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Divider(
            //   color: Colors.white24,
            //   thickness: 2,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Platforms',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            platforms.length == 0
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: const Text('No platforms available in your region',
                        style: TextStyle(color: Colors.white)),
                  )
                : SizedBox(
                    height: 60,
                    child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(180, 0, 0, 1),
                                secondary: Color.fromRGBO(180, 0, 0, 1))),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  image_url + platforms[index]['logo_path'],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 5,
                              );
                            },
                            itemCount: platforms.length))),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.white24,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Cast',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                height: 200,
                child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: Color.fromRGBO(180, 0, 0, 1),
                            secondary: Color.fromRGBO(180, 0, 0, 1))),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.black,
                              child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return const LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                    ).createShader(Rect.fromLTRB(
                                        0, 0, rect.width, rect.height));
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: cast[index]['profile_path'] != null
                                      ? Image.network(
                                          image_url +
                                              cast[index]['profile_path'],
                                          height: 200,
                                          width: 130,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          height: 200,
                                          width: 130,
                                          color: Colors.white24,
                                        )),
                            ),
                            Positioned(
                              top: 160,
                              left: 5,
                              child: Text(
                                cast[index]['name'] + ' as',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            Positioned(
                              top: 180,
                              left: 5,
                              child: Text(
                                cast[index]['character'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ]);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: cast.length))),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.white24,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Related',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                height: 200,
                child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: Color.fromRGBO(180, 0, 0, 1),
                            secondary: Color.fromRGBO(180, 0, 0, 1))),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Stack(children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MovieInfoPage(
                                            movie: recommendations[index])));
                              
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.hardEdge,
                                color: Colors.black,
                                child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ],
                                      ).createShader(Rect.fromLTRB(
                                          0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: recommendations[index]
                                                ['poster_path'] !=
                                            null
                                        ? Image.network(
                                            image_url +
                                                recommendations[index]
                                                    ['poster_path'],
                                            height: 200,
                                            width: 130,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            height: 200,
                                            width: 130,
                                            color: Colors.white24,
                                          )),
                              ),
                            ),
                            Positioned(
                              top: 180,
                              left: 5,
                              child: Text(
                                recommendations[index]['name'] ??
                                    recommendations[index]['title'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ]);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: recommendations.length))),
          ],
        ),
      ),
    ));
  }

  void fetchGenres() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    String url = '';
    if (movie['name'] == null) {
      url =
          api_url + '/movie/' + movie['id'].toString() + '?api_key=' + api_Key;
    } else {
      url = api_url + '/tv/' + movie['id'].toString() + '?api_key=' + api_Key;
    }

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final gnres = json['genres'];

    for (var index = 0; index < gnres.length; index++) {
      if (index == 0) {
        genres = gnres[index]['name'];
      } else if (index == gnres.length - 1) {
        genres = genres + ' and ' + gnres[index]['name'];
      } else {
        genres = genres + ', ' + gnres[index]['name'];
      }
    }
    ;
  }

  void fetchPlatforms() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    String url = '';
    if (movie['name'] == null) {
      url = api_url +
          '/movie/' +
          movie['id'].toString() +
          '/watch/providers?api_key=' +
          api_Key;
    } else {
      url = api_url +
          '/tv/' +
          movie['id'].toString() +
          '/watch/providers?api_key=' +
          api_Key;
    }

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final pltforms = json['results'];
    final pltformsCountry = pltforms['CL'];
    if (pltformsCountry != null) {
      pltformsCountry.forEach((key, value) {
        if (value is List) {
          for (var element in value) {
            if (element['logo_path'] != null &&
                !platforms.any((platform) =>
                    platform['provider_id'] == element['provider_id'])) {
              setState(() {
                platforms.add(element);
              });
            }
          }
        }
      });
    }
  }

  void fetchRecommendations() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    String url = '';
    if (movie['name'] == null) {
      url = api_url +
          '/movie/' +
          movie['id'].toString() +
          '/recommendations?api_key=' +
          api_Key;
    } else {
      url = api_url +
          '/tv/' +
          movie['id'].toString() +
          '/recommendations?api_key=' +
          api_Key;
    }

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final recms = json['results'];
    setState(() {
      recommendations = recms;
    });
  }

  void fetchCast() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    String url = '';
    if (movie['name'] == null) {
      url = api_url +
          '/movie/' +
          movie['id'].toString() +
          '/credits?api_key=' +
          api_Key;
    } else {
      url = api_url +
          '/tv/' +
          movie['id'].toString() +
          '/credits?api_key=' +
          api_Key;
    }

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final cst = json['cast'];
    setState(() {
      cast = cst;
    });
  }

  void fetchVideos() async {
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    String url = '';

    if (movie['name'] == null) {
      url = api_url +
          '/movie/' +
          movie['id'].toString() +
          '/videos?api_key=' +
          api_Key;
    } else {
      url = api_url +
          '/tv/' +
          movie['id'].toString() +
          '/videos?api_key=' +
          api_Key;
    }

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final vds = json['results'];
    setState(() {
      videos = vds;
    });
    if (videos.length > 0) {
      dynamic trailer;
      for (var videoData in videos) {
        if (videoData['type'] == 'Trailer') {
          trailer = videoData;
        }
        if (videos.last == videoData && trailer == null) {
          trailer = videoData;
        }
      }
      setState(() {
        _controller = YoutubePlayerController(
          initialVideoId: trailer['key'],
          flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              hideControls: true,
              hideThumbnail: true,
              enableCaption: false,
              useHybridComposition: true),
        );
      });
    }
  }
}
