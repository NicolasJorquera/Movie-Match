import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class JoinWidget extends StatefulWidget {
  int selectedIndex;
  Function setSelectedIndex;
  JoinWidget(
      {super.key, required this.setSelectedIndex, required this.selectedIndex});

  @override
  State<JoinWidget> createState() =>
      _JoinWidgetState(this.setSelectedIndex, this.selectedIndex);
}

class _JoinWidgetState extends State<JoinWidget> {
  int currentStep = 0;
  Function setSelectedIndex;
  int selectedIndex;
  Map sessionData = {
    'Country': 'Chile',
    'Platforms': [''],
    'MovieOrSerie': 'Movie',
    'Genres': ['']
  };
  _JoinWidgetState(this.setSelectedIndex, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
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
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: SelectableText(
                        'Session ID',
                        style: TextStyle(color: Colors.white),
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
          Column(
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
                      width: 200,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Image.asset(
                                'assets/logos/primelogo.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 0.1,
                            );
                          },
                          itemCount: 50)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                sessionData['MovieOrSerie'] +
                    's of ' +
                    sessionData['Genres'].toString(),
                style: const TextStyle(color: Colors.white),
              ),
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
                    onPressed: () {
                      widget.setSelectedIndex();
                    },
                    child: const Text(
                      'Start',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text(
              'Platforms',
              style: TextStyle(color: Colors.white),
            ),
            content: Container()),
        Step(
            isActive: currentStep >= 1,
            title: const Text('Genres', style: TextStyle(color: Colors.white)),
            content: Container()),
        Step(
            isActive: currentStep >= 2,
            title:
                const Text('Other step', style: TextStyle(color: Colors.white)),
            content: Container()),
      ];
}
