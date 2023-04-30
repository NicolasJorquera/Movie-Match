import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_movie_ticket/src/core/constants/app_colors.dart';

import '../../selectPlatform/selectPlatform_page.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget({
    super.key,
  });

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(children: const [
                      BackButton(
                        color: Colors.white,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ]),
                    const SizedBox(
                      height: 30,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: Colors.white10,
                        child: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color.fromRGBO(180, 0, 0, 1),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Account',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {},
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: Colors.white10,
                        child: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.play_arrow_outlined,
                                  size: 30,
                                  color: Color.fromRGBO(180, 0, 0, 1),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Streaming services',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPlatformView()),
                            );
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: Colors.white10,
                        child: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.question_mark,
                                  size: 30,
                                  color: Color.fromRGBO(180, 0, 0, 1),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'About & FAQ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {},
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: Colors.white10,
                        child: TextButton(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.mode_comment_outlined,
                                  size: 30,
                                  color: Color.fromRGBO(180, 0, 0, 1),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Send Feedback',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23),
                                )
                              ],
                            ),
                          ),
                          onPressed: () {},
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Text(
                  'Version 0.1',
                  style: TextStyle(color: Colors.white),
                )
              ],
            )));
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

  Widget buildmovieCard(int index) => SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
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
}
