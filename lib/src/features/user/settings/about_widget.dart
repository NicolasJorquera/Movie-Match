import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_movie_ticket/src/core/constants/app_colors.dart';

import '../../selectPlatform/selectPlatform_page.dart';

class AboutWidget extends StatefulWidget {
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  AboutWidget(
      {super.key,
      required this.providers,
      required this.platformsSelected,
      required this.setPlatformsSelected,
      required this.setProviders});

  @override
  State<AboutWidget> createState() => _AboutWidgetState(this.providers,
      this.platformsSelected, this.setPlatformsSelected, this.setProviders);
}

class _AboutWidgetState extends State<AboutWidget> {
  int count = 0;
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  _AboutWidgetState(this.providers, this.platformsSelected,
      this.setPlatformsSelected, this.setProviders);

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
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          'FLIXER',
                          style: TextStyle(color: Color.fromRGBO(180, 0, 0, 1), fontSize: 17),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'About us',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Creators',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Text(
                          'FAQ',
                          style: TextStyle(color: Colors.white54, fontSize: 17),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 1',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 2',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 3',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 4',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 5',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 6',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 7',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 8',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 9',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question 10',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                  ],
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
