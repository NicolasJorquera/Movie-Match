import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import '../../../home/widget/movieInfo_widget.dart';

class ResultsWidget extends StatefulWidget {
  String sessionID = '';
  List<dynamic> allProviders = [];
  ResultsWidget(
      {super.key, required this.sessionID, required this.allProviders});

  @override
  State<ResultsWidget> createState() =>
      _ResultsWidgetState(sessionID, allProviders);
}

class _ResultsWidgetState extends State<ResultsWidget> {
  List<dynamic> sessionMovies = [];
  String sessionID = '';
  Map sessionData = {};
  List flixers = [];
  List<dynamic> allProviders = [];
  static const url_image = 'https://image.tmdb.org/t/p/w500';
  final user = FirebaseAuth.instance.currentUser!;
  _ResultsWidgetState(this.sessionID, this.allProviders);
  final AppinioSwiperController controller = AppinioSwiperController();
  int cardIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchSessionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                                primary: Color.fromRGBO(180, 0, 0, 1),
                                secondary: Color.fromRGBO(180, 0, 0, 1))),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Card(
                                  color: Colors.transparent,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: !sessionData.containsKey('Platforms')
                                      ? Image.network(
                                          url_image +
                                              widget.allProviders[index]
                                                  ['logo_path'],
                                          fit: BoxFit.cover,
                                        )
                                      : widget.allProviders.firstWhere(
                                                  (element) =>
                                                      element[
                                                          'provider_name'] ==
                                                      sessionData['Platforms']
                                                          [index],
                                                  orElse: () => null) !=
                                              null
                                          ? Image.network(
                                              url_image +
                                                  widget.allProviders
                                                      .firstWhere((element) =>
                                                          element[
                                                              'provider_name'] ==
                                                          sessionData[
                                                                  'Platforms'][
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
                            itemCount: sessionData.containsKey('Platforms')
                                ? sessionData['Platforms'].length
                                : widget.allProviders.length))),
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
                            .sublist(0, sessionData['Genres'].length - 1)
                            .join(', ') +
                        ' and ' +
                        List<String>.from(sessionData['Genres']).last,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          color: Colors.white24,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              flixers[index]['name'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        flixers.asMap().containsKey(index + 1)
                            ? Card(
                                color: Colors.white24,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    flixers[index + 1]['name'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Card(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
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
    );
  }

  void fetchSessionData() async {
    DatabaseReference sessionRef =
        FirebaseDatabase.instance.ref("matchSessions/" + sessionID.toString());

    DataSnapshot sessionSnapshot = await sessionRef.get();

    if (sessionSnapshot.exists && sessionSnapshot.key != 0) {
      setState(() {
        sessionData = Map<dynamic, dynamic>.from(
            sessionSnapshot.child('sessionData').value! as Map);
      });
      DataSnapshot usersSessionSnapshot =
          await sessionRef.child("flixers/").get();

      DataSnapshot usersSnapshot =
          await FirebaseDatabase.instance.ref('/users').get();

      for (var user in usersSessionSnapshot.children) {
        for (var element in usersSnapshot.children) {
          if (element.key == user.value!) {
            setState(() {
              flixers.add(Map<dynamic, dynamic>.from(element.value as Map));
            });
          }
        }
      }
    } else {
      setState(() {
        sessionData = {};
      });
    }
  }
}
