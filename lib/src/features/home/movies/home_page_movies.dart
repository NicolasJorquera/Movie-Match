import 'package:flutter/material.dart';
import '../widget/movieInfo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeViewMovies extends StatefulWidget {
  List<dynamic> genres = [];
  Function refreshMovies;
  HomeViewMovies({super.key, required this.genres, required this.refreshMovies});

  @override
  State<HomeViewMovies> createState() => _HomeViewMoviesState(genres, refreshMovies);
}

class _HomeViewMoviesState extends State<HomeViewMovies> {
  List<dynamic> genres;
  final user = FirebaseAuth.instance.currentUser!;
  Function refreshMovies;

  _HomeViewMoviesState(this.genres, this.refreshMovies);

  // @override
  // void initState() {
  //   super.initState();
  //   fetchGenres();
  // }

  // @override
  // void setState(fn) {
  //   if(mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color.fromRGBO(180, 0, 0, 1),
      backgroundColor: Colors.black,
      onRefresh: () {
        widget.refreshMovies();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Color.fromRGBO(180, 0, 0, 1),
                  secondary: Color.fromRGBO(180, 0, 0, 1))),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return buildRow(index);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 0);
              },
              itemCount: widget.genres.length)),
    );
  }

  Widget buildCard(int index, List<dynamic> movies) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            // onDoubleTap: () {
            //   setState(() {
            //     movies[index]['liked'] = !movies[index]['liked'];
            //   });
            // },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieInfoPage(
                          movie: movies[index],
                        )),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: movies.isNotEmpty
                    ? Stack(
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w500' +
                                movies[index]['poster_path'],
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: (MediaQuery.of(context).size.width *
                                        0.4 *
                                        3) /
                                    2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                color: const Color.fromRGBO(50, 50, 50, 1),
                              );
                            },
                            height:
                                (MediaQuery.of(context).size.width * 0.4 * 3) /
                                    2,
                            width: MediaQuery.of(context).size.width * 0.4,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              top: (MediaQuery.of(context).size.width *
                                      0.4 *
                                      3) /
                                  2.5,
                              left: MediaQuery.of(context).size.width * 0.27,
                              child: IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      movies[index]['liked'] =
                                          !movies[index]['liked'];
                                    });

                                    final usersSnap = await FirebaseDatabase
                                        .instance
                                        .ref("users/")
                                        .get();
                                    String userID = usersSnap.children
                                        .firstWhere((usr) =>
                                            usr.child('email').value ==
                                            user.email)
                                        .key!;

                                    DatabaseReference usersMoviesRef =
                                        await FirebaseDatabase.instance.ref(
                                            "users/" +
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
                                            movies[index]['id'],
                                      );
                                    } else {
                                      movieAlreadyExists = false;
                                    }

                                    if (movies[index]['liked'] &&
                                        !movieAlreadyExists) {
                                      DatabaseReference movieKey =
                                          usersMoviesRef.push();

                                      
                                      movieKey.set(movies[index]);
                                    } else {
                                      final usersMoviesSnap =
                                          await usersMoviesRef.get();
                                      if (usersMoviesSnap.children.any(
                                          (movie) =>
                                              movie.child('id').value ==
                                              movies[index]['id'])) {
                                        String movieID = '';
                                        if (usersMoviesSnap.value != null) {
                                          movieID = usersMoviesSnap.children
                                              .firstWhere((movie) =>
                                                  movie.child('id').value ==
                                                  movies[index]['id'])
                                              .key!;
                                        }

                                        usersMoviesRef.child(movieID).remove();
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    movies[index]['liked']
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: movies[index]['liked']
                                        ? const Color.fromRGBO(200, 0, 0, 1)
                                        : Colors.white,
                                    shadows: const <Shadow>[
                                      Shadow(
                                          color: Colors.black, blurRadius: 10.0)
                                    ],
                                  )))
                        ],
                      )
                    : null),
          )
        ],
      );

  Widget buildRow(int index1) {
    return widget.genres[index1]['movies'] == null
        ? Container()
        : List.from(widget.genres[index1]['movies']).length < 3
            ? Container()
            : Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 10),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.genres.isNotEmpty
                            ? widget.genres[index1]['name']
                            : '',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.left,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: (MediaQuery.of(context).size.width * 0.4 * 3) / 2,
                    child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(180, 0, 0, 1),
                                secondary: Color.fromRGBO(180, 0, 0, 1))),
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          itemBuilder: (context, index) {
                            return Row(children: [
                              buildCard(index, widget.genres[index1]['movies'])
                            ]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: widget.genres.isNotEmpty
                              ? widget.genres[index1]['movies'] != null
                                  ? widget.genres[index1]['movies'].length
                                  : 0
                              : 0,
                        )))
              ]);
  }
}