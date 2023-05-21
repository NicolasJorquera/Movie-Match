import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../movieTinder_widget.dart';

class JoinWidget extends StatefulWidget {
  List<dynamic> platformsSelected;
  List<dynamic> providers;
  JoinWidget(
      {super.key, required this.platformsSelected, required this.providers});

  @override
  State<JoinWidget> createState() =>
      _JoinWidgetState(platformsSelected, providers);
}

class _JoinWidgetState extends State<JoinWidget> {
  int currentStep = 0;
  final user = FirebaseAuth.instance.currentUser!;
  Map sessionData = {};
  List flixers = [];
  String sessionID = '';
  static const url_image = 'https://image.tmdb.org/t/p/w500';
  List<dynamic> allProviders = [];
  List<dynamic> platformsSelected;
  List<dynamic> providers;
  _JoinWidgetState(this.platformsSelected, this.providers);

  @override
  Widget build(BuildContext context) {
    setState(() {
      allProviders = widget.providers + widget.platformsSelected;
    });
    setState(() {
      allProviders.sort((a, b) => a['provider_name']
          .toString()
          .compareTo(b['provider_name'].toString()));
    });
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (value) async {
                            setState(() {
                              sessionID = value;
                            });

                            DatabaseReference sessionRef = FirebaseDatabase
                                .instance
                                .ref("matchSessions/" + sessionID.toString());

                            DataSnapshot sessionSnapshot =
                                await sessionRef.get();

                            if (sessionSnapshot.exists &&
                                sessionSnapshot.key != 0) {
                              setState(() {
                                sessionData = Map<dynamic, dynamic>.from(
                                    sessionSnapshot.child('sessionData').value!
                                        as Map);
                              });
                              DataSnapshot usersSessionSnapshot =
                                  await sessionRef.child("flixers/").get();

                              DataSnapshot usersSnapshot =
                                  await FirebaseDatabase.instance
                                      .ref('/users')
                                      .get();

                              for (var user in usersSessionSnapshot.children) {
                                for (var element in usersSnapshot.children) {
                                  if (element.key == user.value!) {
                                    setState(() {
                                      flixers.add(Map<dynamic, dynamic>.from(
                                          element.value as Map));
                                    });
                                    print(flixers);
                                  }
                                }
                              }
                            } else {
                              setState(() {
                                sessionData = {};
                              });
                            }
                          },
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Username'),
                          cursorColor: Colors.white,
                          strutStyle: StrutStyle.disabled,
                          textCapitalization: TextCapitalization.characters,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       Icons.ios_share,
                  //       color: Color.fromRGBO(180, 0, 0, 1),
                  //     ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            sessionData.isEmpty
                ? const Text(
                    'No session found!',
                    style: TextStyle(color: Colors.white24, fontSize: 25),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Session data',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Country:  ' + sessionData['Country'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Platforms: ',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 40,
                            width: 250,
                            child: Expanded(
                                child: Theme(
                                    data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                            primary:
                                                Color.fromRGBO(180, 0, 0, 1),
                                            secondary:
                                                Color.fromRGBO(180, 0, 0, 1))),
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Card(
                                              color: Colors.transparent,
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                              child: !sessionData
                                                      .containsKey('Platforms')
                                                  ? Image.network(
                                                      url_image +
                                                          allProviders[index]
                                                              ['logo_path'],
                                                      fit: BoxFit.cover,
                                                    )
                                                  : allProviders.firstWhere(
                                                              (element) =>
                                                                  element[
                                                                      'provider_name'] ==
                                                                  sessionData[
                                                                          'Platforms']
                                                                      [index],
                                                              orElse: () =>
                                                                  null) !=
                                                          null
                                                      ? Image.network(
                                                          url_image +
                                                              allProviders.firstWhere((element) =>
                                                                  element[
                                                                      'provider_name'] ==
                                                                  sessionData[
                                                                          'Platforms']
                                                                      [
                                                                      index])['logo_path'],
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Container(
                                                          color: Colors.red,
                                                        ));
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: 0.1,
                                          );
                                        },
                                        itemCount: sessionData
                                                .containsKey('Platforms')
                                            ? sessionData['Platforms'].length
                                            : allProviders.length))),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        !sessionData.containsKey('Genres')
                            ? sessionData['MoviesOrSeries'].toString() +
                                ' of ' +
                                'all genres'
                            : sessionData['Genres'].length == 1
                                ? sessionData['MoviesOrSeries'].toString() +
                                    ' of ' +
                                    List<String>.from(sessionData['Genres'])[0]
                                : sessionData['MoviesOrSeries'].toString() +
                                    ' of ' +
                                    List<String>.from(sessionData['Genres'])
                                        .sublist(
                                            0, sessionData['Genres'].length - 1)
                                        .join(', ') +
                                    ' and ' +
                                    List<String>.from(sessionData['Genres'])
                                        .last,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Flixers:',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        width: 400,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              if (index % 2 == 0) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Card(
                                      color: Colors.white24,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          flixers[index]['name'],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    flixers.asMap().containsKey(index + 1)
                                        ? Card(
                                            color: Colors.white24,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                flixers[index + 1]['name'],
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Card(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                flixers[index]['name'],
                                                style: const TextStyle(
                                                    color: Colors.transparent),
                                              ),
                                            ),
                                          ),
                                  ],
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemCount: flixers.length),
                      )
                    ],
                  ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(180, 0, 0, 1))),
                      onPressed: () async {
                        DatabaseReference sessionRef = FirebaseDatabase.instance
                            .ref("matchSessions/" + sessionID.toString());

                        DataSnapshot sessionSnapshot = await sessionRef.get();

                        if (sessionSnapshot.child('sessionStatus').value ==
                            'matching') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieTinderWidget(
                                      sessionID: sessionID,
                                    )),
                          );
                        } else {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2.5,
                                        color: Color.fromRGBO(100, 100, 100, 1),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: Colors.black,
                                  title: const Text(
                                    'Session has not started yet',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: const Text(
                                    'Wait for the session creator to start the session',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(
                                            fontSize: 15,
                                              color:
                                                  Color.fromRGBO(180, 0, 0, 1)),
                                        ))
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text(
                        'Start',
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  side: BorderSide(
                                      color: Color.fromRGBO(180, 0, 0, 1)))),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.black)),
                      onPressed: () async {
                        final usersRef =
                            await FirebaseDatabase.instance.ref("users/").get();
                        DataSnapshot userSnapshot = usersRef.children
                            .firstWhere((usr) =>
                                usr.child('email').value == user.email);

                        DatabaseReference sessionRef = FirebaseDatabase.instance
                            .ref("matchSessions/" + sessionID.toString());

                        DataSnapshot sessionSnapshot = await sessionRef.get();
                        bool userAlreadyInSession = false;
                        Iterable<DataSnapshot> usersSession =
                            sessionSnapshot.child('flixers').children;

                        for (var element in usersSession) {
                          if (element.value == userSnapshot.key.toString()) {
                            userAlreadyInSession = true;
                          }
                        }

                        if (!userAlreadyInSession) {
                          if (sessionSnapshot.child('sessionStatus').value ==
                              'setUp') {
                            await sessionRef
                                .child('flixers/' + userSnapshot.key.toString())
                                .set(userSnapshot.key.toString());
                          }
                        }

                        DataSnapshot usersSessionSnapshot =
                            await sessionRef.child("flixers/").get();

                        DataSnapshot usersSnapshot =
                            await FirebaseDatabase.instance.ref('/users').get();

                        for (var user in usersSessionSnapshot.children) {
                          for (var element in usersSnapshot.children) {
                            if (element.key == user.value!) {
                              setState(() {
                                flixers.add(Map<dynamic, dynamic>.from(
                                    element.value as Map));
                              });
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Join',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
