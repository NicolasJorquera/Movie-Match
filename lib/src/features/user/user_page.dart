import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';

import 'settings/settings_widget.dart';

class UsersView extends StatefulWidget {
  dynamic userData;
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  Function fetchMovies;
  UsersView(
      {super.key,
      required this.providers,
      required this.platformsSelected,
      required this.setPlatformsSelected,
      required this.setProviders,
      required this.userData,
      required this.fetchMovies});

  @override
  State<UsersView> createState() => _UsersViewState(
      providers,
      platformsSelected,
      setPlatformsSelected,
      setProviders,
      userData,
      fetchMovies);
}

class _UsersViewState extends State<UsersView> {
  final user = FirebaseAuth.instance.currentUser!;
  dynamic userData;
  int selectedIndex = 0;
  int previousSelectedIndex = 0;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  Function fetchMovies;
  List likedMovies = [];
  List likedSeries = [];
  static const url_image = 'https://image.tmdb.org/t/p/w500';

  _UsersViewState(
      this.providers,
      this.platformsSelected,
      this.setPlatformsSelected,
      this.setProviders,
      this.userData,
      this.fetchMovies);

  List<dynamic> providers;

  @override
  @override
  void initState() {
    super.initState();
    fetchLikedMovies();
    fetchLikedSeries();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    fetchLikedMovies();
    fetchLikedSeries();
    return Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(180, 0, 0, 1),
                secondary: Color.fromRGBO(180, 0, 0, 1))),
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
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/aladdin.jpg',
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(144, 144, 144, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: const Text(
                            'Share',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          onPressed: () {
                            Share.share(
                                'Check out my app Flixer in Google Play Store',
                                subject: 'Look what I made!');
                          },
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 120),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          user.photoURL!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(144, 144, 144, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: const Text(
                            'Settings',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsWidget(
                                        fetchMovies: widget.fetchMovies,
                                        userData: widget.userData,
                                        providers: widget.providers,
                                        platformsSelected:
                                            widget.platformsSelected,
                                        setPlatformsSelected:
                                            widget.setPlatformsSelected,
                                        setProviders: widget.setProviders,
                                      )),
                            );
                          },
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                            primary: Color.fromRGBO(180, 0, 0, 1),
                            secondary: Color.fromRGBO(180, 0, 0, 1))),
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: buildUserDataCard(index))
                              : index == 3
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: buildUserDataCard(index))
                                  : buildUserDataCard(index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 15);
                        },
                        itemCount: 4)),
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Color.fromRGBO(50, 50, 50, 1),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Series',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('SEE ALL',
                                style: TextStyle(
                                    color: Color.fromRGBO(180, 0, 0, 1),
                                    fontSize: 12))))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(180, 0, 0, 1),
                                secondary: Color.fromRGBO(180, 0, 0, 1))),
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: buildSerieCard(index),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 5);
                            },
                            itemCount: likedSeries.length)),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Color.fromRGBO(50, 50, 50, 1),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Movies',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('SEE ALL',
                                style: TextStyle(
                                    color: Color.fromRGBO(180, 0, 0, 1),
                                    fontSize: 12))))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: Theme(
                        data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                                primary: Color.fromRGBO(180, 0, 0, 1),
                                secondary: Color.fromRGBO(180, 0, 0, 1))),
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: buildMovieCard(index),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 5);
                            },
                            itemCount: likedMovies.length)),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget buildUserDataCard(int index) => SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(42, 42, 42, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ))),
            child: const Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: () {},
          )));

  Widget buildMovieCard(int index) => SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: likedMovies.asMap().containsKey(index)
                  ? Image.network(url_image + likedMovies[index]['poster_path'],
                      fit: BoxFit.cover)
                  : Container(),
            ),
          )));

  Widget buildSerieCard(int index) => SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: () {},
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              clipBehavior: Clip.hardEdge,
              color: Colors.transparent,
              child: likedSeries.asMap().containsKey(index)
                  ? Image.network(url_image + likedSeries[index]['poster_path'],
                      fit: BoxFit.cover)
                  : Container(),
            ),
          )));

  void fetchLikedMovies() async {
    final usersSnap = await FirebaseDatabase.instance.ref("users/").get();
    String userID = usersSnap.children
        .firstWhere((usr) => usr.child('email').value == user.email)
        .key!;

    final usersMoviesSnap = await FirebaseDatabase.instance
        .ref("users/" + userID + "/likedMovies/")
        .get();

    setState(() {
      likedMovies.clear();
    });

    for (var movie in usersMoviesSnap.children) {
      likedMovies.add(movie.value);
    }
  }

  void fetchLikedSeries() async {
    final usersSnap = await FirebaseDatabase.instance.ref("users/").get();
    String userID = usersSnap.children
        .firstWhere((usr) => usr.child('email').value == user.email)
        .key!;

    final usersSeriesSnap = await FirebaseDatabase.instance
        .ref("users/" + userID + "/likedSeries/")
        .get();

    setState(() {
      likedSeries.clear();
    });

    for (var movie in usersSeriesSnap.children) {
      likedSeries.add(movie.value);
    }
  }
}
