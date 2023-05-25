import 'package:flutter/material.dart';
import '../widget/movieInfo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeViewSeries extends StatefulWidget {
  List<dynamic> genres = [];
  HomeViewSeries({super.key, required this.genres});

  @override
  State<HomeViewSeries> createState() => _HomeViewSeriesState(genres);
}

class _HomeViewSeriesState extends State<HomeViewSeries> {
  List<dynamic> genres = [];
  final user = FirebaseAuth.instance.currentUser!;

  _HomeViewSeriesState(genres);

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
  Widget build(BuildContext context) {
    return Theme(
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
            itemCount: widget.genres.length));
  }

  Widget buildCard(int index, List<dynamic> series) => Column(
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
                          movie: series[index],
                        )),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: series.isNotEmpty
                    ? Stack(
                        children: [
                          series[index]['poster_path'] == null
                              ? Container(
                                  color: Colors.white24,
                                  height: (MediaQuery.of(context).size.width *
                                          0.4 *
                                          3) /
                                      2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                )
                              : Image.network(
                                  'https://image.tmdb.org/t/p/w500' +
                                      series[index]['poster_path'],
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height:
                                          (MediaQuery.of(context).size.width *
                                                  0.4 *
                                                  3) /
                                              2,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      color:
                                          const Color.fromRGBO(50, 50, 50, 1),
                                    );
                                  },
                                  height: (MediaQuery.of(context).size.width *
                                          0.4 *
                                          3) /
                                      2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
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
                                      series[index]['liked'] =
                                          !series[index]['liked'];
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

                                    DatabaseReference usersSeriesRef =
                                        await FirebaseDatabase.instance.ref(
                                            "users/" +
                                                userID +
                                                "/likedSeries/");
                                    DataSnapshot usersSeriesSnap =
                                        await usersSeriesRef.get();

                                    dynamic serieAlreadyExists;
                                    if (usersSeriesSnap.value != null) {
                                      serieAlreadyExists =
                                          usersSeriesSnap.children.any(
                                        (serie) =>
                                            serie.child('id').value ==
                                            series[index]['id'],
                                      );
                                    } else {
                                      serieAlreadyExists = null;
                                    }

                                    if (series[index]['liked'] &&
                                        !serieAlreadyExists) {
                                      DatabaseReference serieKey =
                                          usersSeriesRef.push();

                                      serieKey.set({
                                        'id': series[index]['id'],
                                        'name': series[index]['name'],
                                        'poster_path': series[index]
                                            ['poster_path'],
                                        'overview': series[index]['overview'],
                                        'vote_average': series[index]
                                            ['vote_average'],
                                        'release_date': series[index]
                                            ['release_date'],
                                        'liked': series[index]['liked']
                                      });
                                    } else {
                                      final usersSerieSnap =
                                          await usersSeriesRef.get();
                                      if (usersSerieSnap.children.any((serie) =>
                                          serie.child('id').value ==
                                          series[index]['id'])) {
                                        String serieID = '';
                                        if (usersSeriesSnap.value != null) {
                                          serieID = usersSeriesSnap.children
                                              .firstWhere((serie) =>
                                                  serie.child('id').value ==
                                                  series[index]['id'])
                                              .key!;
                                        }

                                        usersSeriesRef.child(serieID).remove();
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    series[index]['liked']
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: series[index]['liked']
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

  Widget buildRow(int index1) => Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 10),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.genres.isNotEmpty ? widget.genres[index1]['name'] : '',
                style: const TextStyle(color: Colors.white, fontSize: 20),
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
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  itemBuilder: (context, index) {
                    return index != widget.genres[index1]['series'].length - 1
                        ? Row(
                            children: [
                              buildCard(index, widget.genres[index1]['series']),
                              const SizedBox(width: 5)
                            ],
                          )
                        : Row(children: [
                            buildCard(index, widget.genres[index1]['series'])
                          ]);
                  },
                  itemCount: widget.genres.isNotEmpty
                      ? widget.genres[index1]['series'] != null
                          ? widget.genres[index1]['series'].length
                          : 0
                      : 0,
                )))
      ]);
}
