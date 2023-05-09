import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_movie_ticket/src/core/constants/app_colors.dart';

import '../../selectPlatform/selectPlatform_page.dart';

class AccountWidget extends StatefulWidget {
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  AccountWidget(
      {super.key,
      required this.providers,
      required this.platformsSelected,
      required this.setPlatformsSelected,
      required this.setProviders});

  @override
  State<AccountWidget> createState() => _AccountWidgetState(this.providers,
      this.platformsSelected, this.setPlatformsSelected, this.setProviders);
}

class _AccountWidgetState extends State<AccountWidget> {
  int count = 0;
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  _AccountWidgetState(this.providers, this.platformsSelected,
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
                          'USER INFORMATION',
                          style: TextStyle(color: Colors.white54, fontSize: 17),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.person,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Username',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              'name',
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.photo,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Profile picture',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.edit,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.photo_camera_back,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Cover picture',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.edit,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.mail,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Email',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              'mail@gmail.com',
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.pin_drop,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Country',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              'country',
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                          'PREFERENCES',
                          style: TextStyle(color: Colors.white54, fontSize: 17),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.language,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Language',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              'language',
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Color.fromRGBO(180, 0, 0, 1),
                              size: 30,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Preference 2',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Text(
                              'preference',
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white10,
                    ),
                    const SizedBox(
                      height: 10,
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
