import 'dart:convert';
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
  String searchString = '';
  String image_path = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
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
        body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SearchBar(
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
                                          SizedBox(
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                height: 50,
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    Text(
                                                      search[index]['title'],
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                search[index]['genre_ids']
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              search[index]['liked'] =
                                                  !search[index]['liked'];
                                            });
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
            )));
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
    const api_url = 'https://api.themoviedb.org/3';
    const api_Key = '36e984f2374fdfcbcea58dba752094dc';

    var url =
        api_url + '/search/movie?api_key=' + api_Key + '&query=' + searchString;

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
}
