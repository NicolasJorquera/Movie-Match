import 'package:flutter/material.dart';
import 'package:flutter_movie_ticket/src/core/constants/app_colors.dart';

import 'settings/settings_widget.dart';

class UsersView extends StatefulWidget {
  const UsersView({
    super.key,
  });

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  int selectedIndex = 0;
  int previousSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: const Text(
                        'Share',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      onPressed: () {},
                    )),
                Container(
                  padding: const EdgeInsets.only(top: 120),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.asset(
                      'assets/images/greta.jpg',
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                          builder: (context) =>
                                              SettingsWidget()),
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
                itemCount: 4),
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
                    'Lists',
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
                  top: 10,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: buildmovieCard(index))
                          : index == 19
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: buildmovieCard(index))
                              : buildmovieCard(index);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 5);
                    },
                    itemCount: 20),
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
                    'Shows',
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
                  top: 10,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: buildmovieCard(index))
                          : index == 19
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: buildmovieCard(index))
                              : buildmovieCard(index);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 5);
                    },
                    itemCount: 20),
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
                  top: 10,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: buildmovieCard(index))
                          : index == 19
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: buildmovieCard(index))
                              : buildmovieCard(index);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 5);
                    },
                    itemCount: 20),
              ),
            ),
          ],
        )
      ],
    );
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
