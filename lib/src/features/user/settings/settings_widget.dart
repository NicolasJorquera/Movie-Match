import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flixer/src/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_android/url_launcher_android.dart';

import '../../selectPlatform/selectPlatform_page.dart';
import 'account_widget.dart';
import 'about_widget.dart';

class SettingsWidget extends StatefulWidget {
  dynamic userData;
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  SettingsWidget(
      {super.key,
      required this.providers,
      required this.platformsSelected,
      required this.setPlatformsSelected,
      required this.setProviders, required this.userData});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState(this.providers,
      this.platformsSelected, this.setPlatformsSelected, this.setProviders, this.userData);
}

class _SettingsWidgetState extends State<SettingsWidget> {
  dynamic userData;
  int count = 0;
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  _SettingsWidgetState(this.providers, this.platformsSelected,
      this.setPlatformsSelected, this.setProviders, this.userData);

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
                        'User',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                        shape: const RoundedRectangleBorder(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountWidget(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        shape: const RoundedRectangleBorder(
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
                                  builder: (context) => SelectPlatformView(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        shape: const RoundedRectangleBorder(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutWidget(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                        shape: const RoundedRectangleBorder(
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
                          onPressed: () async {
                            String email =
                                Uri.encodeComponent("mail@fluttercampus.com");
                            String subject =
                                Uri.encodeComponent("Hello Flutter");
                            String body = Uri.encodeComponent(
                                "Hi! I'm Flutter Developer");
                            print(subject); //output: Hello%20Flutter
                            Uri mail = Uri.parse(
                                "mailto:$email?subject=$subject&body=$body");
                            if (await launchUrl(mail)) {
                              //email app opened
                            } else {
                              //email app is not opened
                            }
                          },
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Text(
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
